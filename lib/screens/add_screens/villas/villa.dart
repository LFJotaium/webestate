import 'dart:io' as villa;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import '../../../../data/repositories/villa_repository.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../shared/location_step.dart';
import '../shared/media_step.dart';
import '../shared/step_indicator.dart';
import '../shared/basic_info_step.dart';
import 'widgets/details_step.dart';
import 'widgets/features_step.dart';

class VillaOnboardingScreen extends StatefulWidget {
  @override
  _VillaOnboardingScreenState createState() => _VillaOnboardingScreenState();
}

class _VillaOnboardingScreenState extends State<VillaOnboardingScreen>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  int _currentStep = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Form controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _locationLatLngController =
      TextEditingController();
  final TextEditingController _locationDescController = TextEditingController();
  final TextEditingController _totalRoomsController = TextEditingController();
  final TextEditingController _totalBathroomsController =
      TextEditingController();
  final TextEditingController _totalKitchensController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _videoUrlController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  // Form values
  String _listingType = 'rent';
  LatLng? _location = LatLng(32.51712600, 35.14853100);
  List<XFile> _images = [];
  bool _hasBalcony = false;
  bool _hasParking = false;
  bool _hasElevator = false;
  bool _hasStorage = false;
  bool _hasAirConditioning = false;
  bool _hasWifi = false;
  bool _hasPool = false;
  bool _gymNearby = false;
  bool _isFurnished = false;
  bool _utilitiesIncluded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _areaController.dispose();
    _locationDescController.dispose();
    _locationLatLngController.dispose();
    _totalRoomsController.dispose();
    _totalBathroomsController.dispose();
    _totalKitchensController.dispose();
    _phoneController.dispose();
    _videoUrlController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images.addAll(pickedFiles.map((file) => XFile(file.path)));
      });
    }
  }

  Future<void> _submitForm() async {
    try {
      // Validate required fields
      if (_images.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(AppLocalizations.of(context).add_apartment_photosRequired),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_titleController.text.isEmpty ||
          _descriptionController.text.isEmpty ||
          _priceController.text.isEmpty ||
          _areaController.text.isEmpty ||
          _cityController.text.isEmpty ||
          _locationDescController.text.isEmpty ||
          _phoneController.text.isEmpty ||
          _location == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(AppLocalizations.of(context).add_apartment_requiredFields),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(AppLocalizations.of(context).add_apartment_loading),
            ],
          ),
        ),
      );

      try {
        double price, area, rooms, kitchens, bathrooms, floors, floor;
        price = double.parse(_priceController.text);
        area = double.parse(_areaController.text);
        rooms = double.parse(_totalRoomsController.text);
        kitchens = double.parse(_totalKitchensController.text);
      } catch (e) {
        Navigator.pop(context); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('الرجاء التأكد من المعلومات, تحقق من أنك لم تضع احرفا بدلا من الارقام'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('المستخدم ليس مسجلا'),
            backgroundColor: Colors.red,
          ),
        );
      }
      try {
        SnackBar(
          content: Text('تجربة - تم الدفع'),
          backgroundColor: Colors.red,
        );        } catch (e) {
        print('Payment failed: $e');
      }
      await addVilla(
        listingType: _listingType,
        title: _titleController.text,
        description: _descriptionController.text,
        ownerId: currentUser?.uid ?? "AnonymousUID",
        ownerName: currentUser?.displayName ?? 'Anonymous',
        ownerPhoneNumber: _phoneController.text,
        price: double.parse(_priceController.text),
        currency: 'ILS', // Or get from user settings
        locationDescription: _locationDescController.text,
        city: _cityController.text,
        latitude: _location!.latitude,
        longitude: _location!.longitude,
        images: _images,
        videoTourUrl: _videoUrlController.text.isNotEmpty
            ? _videoUrlController.text
            : null,
        area: double.parse(_areaController.text),
        totalRooms: int.parse(_totalRoomsController.text),
        totalBathrooms: int.parse(_totalBathroomsController.text),
        totalKitchens: int.parse(_totalKitchensController.text),
        hasBalcony: _hasBalcony,
        hasParking: _hasParking,
        hasElevator: _hasElevator,
        hasStorage: _hasStorage,
        hasAirConditioning: _hasAirConditioning,
        isFurnished: _isFurnished,
        utilitiesIncluded: _utilitiesIncluded, distanceFromCenter: 0.0,
        publicTransportAccess: false, amenities: [],
      );

      // Close loading dialog
      Navigator.pop(context);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).add_apartment_addSuccess),
          backgroundColor: Colors.green,
        ),
      );
      context.go('/profile_screen');

      // Optionally navigate away after success
      // Navigator.pop(context); // Go back to previous screen
    } catch (e) {
      // Close loading dialog if still open
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${AppLocalizations.of(context).add_apartment_addError} ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error submitting apartment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: AppLocalizations.of(context).localeName == 'ar' ||
              AppLocalizations.of(context).localeName == 'he'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "اضافة فيلا",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: size.height * 0.02,
                ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            StepIndicator(maxSteps: 5, currentStep: _currentStep),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  BasicInfoStep(
                    fadeAnimation: _fadeAnimation,
                    titleController: _titleController,
                    descriptionController: _descriptionController,
                    priceController: _priceController,
                    listingType: _listingType,
                    onListingTypeChanged: (value) =>
                        setState(() => _listingType = value!),
                  ),
                  LocationStep(
                    fadeAnimation: _fadeAnimation,
                    cityController: _cityController,
                    locationDescController: _locationDescController,
                    phoneController: _phoneController,
                    initialLocation: _location,
                    onLocationChanged: (latLng) {
                      setState(() {
                        _location = latLng;
                      });
                    },
                  ),
                  VillaDetailsStep(
                    fadeAnimation: _fadeAnimation,
                    areaController: _areaController,
                    totalRoomsController: _totalRoomsController,
                    totalBathroomsController: _totalBathroomsController,
                    totalKitchensController: _totalKitchensController,
                  ),
                  VillaFeaturesStep(
                    fadeAnimation: _fadeAnimation,
                    hasBalcony: _hasBalcony,
                    hasParking: _hasParking,
                    hasElevator: _hasElevator,
                    hasStorage: _hasStorage,
                    hasAirConditioning: _hasAirConditioning,
                    hasWifi: _hasWifi,
                    hasPool: _hasPool,
                    gymNearby: _gymNearby,
                    isFurnished: _isFurnished,
                    utilitiesIncluded: _utilitiesIncluded,
                    onFeatureChanged: (feature, value) {
                      setState(() {
                        switch (feature) {
                          case 'balcony':
                            _hasBalcony = value;
                            break;
                          case 'parking':
                            _hasParking = value;
                            break;
                          case 'elevator':
                            _hasElevator = value;
                            break;
                          case 'storage':
                            _hasStorage = value;
                            break;
                          case 'ac':
                            _hasAirConditioning = value;
                            break;
                          case 'wifi':
                            _hasWifi = value;
                            break;
                          case 'pool':
                            _hasPool = value;
                            break;
                          case 'gym':
                            _gymNearby = value;
                            break;
                          case 'furnished':
                            _isFurnished = value;
                            break;
                          case 'utilities':
                            _utilitiesIncluded = value;
                            break;
                        }
                      });
                    },
                  ),
                  MediaStep(
                    fadeAnimation: _fadeAnimation,
                    images: _images,
                    videoUrlController: _videoUrlController,
                    onPickImages: _pickImages,
                    onRemoveImage: (index) {
                      setState(() {
                        _images.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentStep > 0)
                    ElevatedButton(
                      onPressed: () {
                        _animationController.reset();
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                        setState(() => _currentStep--);
                        _animationController.forward();
                      },
                      child:
                          Text(AppLocalizations.of(context).add_apartment_back),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.grey.shade800,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ).animate().fadeIn(),
                  if (_currentStep == 0) SizedBox(width: 48),
                  ElevatedButton(
                    onPressed: () async {
                      if (_currentStep < 4) {
                        _animationController.reset();
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                        setState(() => _currentStep++);
                        _animationController.forward();
                      } else {
                        if (_images.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)
                                  .add_apartment_photosRequired),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                          return;
                        }

                        await _submitForm();
                      }
                    },
                    child: Text(
                      _currentStep == 4
                          ? "تسليم"
                          : AppLocalizations.of(context).add_apartment_next,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                  ).animate().fadeIn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
