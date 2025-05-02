import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/firebase_service/firebase_service.dart';
import '../../../core/firebase_instances.dart';
import '../../../data/models/estate_models/abstract_estate_model.dart';
import '../add_screens/shared/basic_info_step.dart';
import '../add_screens/shared/location_step.dart';
import '../add_screens/shared/step_indicator.dart';
import '../add_screens/apartments/widgets/details_step.dart'
    as apartment_details;
import '../add_screens/apartments/widgets/features_step.dart'
    as apartment_features;
import '../add_screens/lands/widgets/details_step.dart' as land_details;
import '../add_screens/lands/widgets/features_step.dart' as land_features;
import 'media_step.dart';
import '../add_screens/houses/widgets/details_step.dart' as house_details;
import '../add_screens/houses/widgets/features_step.dart' as house_features;
import '../add_screens/villas/widgets/details_step.dart' as villa_details;
import '../add_screens/villas/widgets/features_step.dart' as villa_features;

class UpdateEstateScreen extends StatefulWidget {
  final dynamic estate;

  const UpdateEstateScreen({required this.estate});

  @override
  _UpdateEstateScreenState createState() => _UpdateEstateScreenState();
}

class _UpdateEstateScreenState extends State<UpdateEstateScreen>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  int _currentStep = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Form controllers
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _areaController;
  late TextEditingController _cityController;
  late TextEditingController _locationDescController;
  late TextEditingController _phoneController;
  late TextEditingController _videoUrlController;

  String _landType = "agriculture";

  // Form values
  late String _listingType;
  LatLng? _location;
  List<XFile> _images = [];
  List<String> _existingImageUrls = [];
  bool _isLoading = true;

  // Type-specific controllers and values
  late Map<String, dynamic> _typeSpecificControllers;
  late Map<String, bool> _typeSpecificFeatures;

  @override
  void initState() {
    super.initState();
    _initializeData();
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

  void _initializeData() {
    // Initialize common fields
    _titleController = TextEditingController(text: widget.estate.title);
    _descriptionController =
        TextEditingController(text: widget.estate.description);
    _priceController =
        TextEditingController(text: widget.estate.price.toString());
    _areaController =
        TextEditingController(text: widget.estate.area.toString());
    _cityController = TextEditingController(text: widget.estate.city);
    _locationDescController =
        TextEditingController(text: widget.estate.locationDescription);
    _phoneController =
        TextEditingController(text: widget.estate.ownerPhoneNumber);
    _videoUrlController =
        TextEditingController(text: widget.estate.videoTourUrl ?? '');
    _listingType = widget.estate.listingType;
    _location = LatLng(widget.estate.latitude, widget.estate.longitude);
    _existingImageUrls = widget.estate.images;

    // Initialize type-specific fields
    _typeSpecificControllers = {};
    _typeSpecificFeatures = {};

    switch (widget.estate.type) {
      case 'apartment':
        _initializeApartmentData();
        break;
      case 'house':
        _initializeHouseData();
        break;
      case 'villa':
        _initializeVillaData();
        break;
      case 'land':
        _initializeLandData();
        break;
    }

    setState(() => _isLoading = false);
  }

  void _initializeApartmentData() {
    _typeSpecificControllers = {
      'totalRooms': TextEditingController(
          text: widget.estate.totalRooms?.toString() ?? ''),
      'totalBathrooms': TextEditingController(
          text: widget.estate.totalBathrooms?.toString() ?? ''),
      'totalKitchens': TextEditingController(
          text: widget.estate.totalKitchens?.toString() ?? ''),
      'floor':
          TextEditingController(text: widget.estate.floor?.toString() ?? ''),
      'totalFloors': TextEditingController(
          text: widget.estate.totalFloors?.toString() ?? ''),
    };

    _typeSpecificFeatures = {
      'balcony': widget.estate.hasBalcony ?? false,
      'parking': widget.estate.hasParking ?? false,
      'elevator': widget.estate.hasElevator ?? false,
      'storage': widget.estate.hasStorage ?? false,
      'ac': widget.estate.hasAirConditioning ?? false,
      'wifi': widget.estate.hasWifi ?? false,
      'pool': widget.estate.hasPool ?? false,
      'gym': widget.estate.gymNearby ?? false,
      'furnished': widget.estate.isFurnished ?? false,
      'utilities': widget.estate.utilitiesIncluded ?? false,
    };
  }

  void _initializeHouseData() {
    _typeSpecificControllers = {
      'totalRooms': TextEditingController(
          text: widget.estate.totalRooms?.toString() ?? ''),
      'totalBathrooms': TextEditingController(
          text: widget.estate.totalBathrooms?.toString() ?? ''),
      'totalKitchens': TextEditingController(
          text: widget.estate.totalKitchens?.toString() ?? ''),
      'totalFloors': TextEditingController(
          text: widget.estate.totalFloors?.toString() ?? ''),
    };

    _typeSpecificFeatures = {
      'balcony': widget.estate.hasBalcony ?? false,
      'parking': widget.estate.hasParking ?? false,
      'elevator': widget.estate.hasElevator ?? false,
      'storage': widget.estate.hasStorage ?? false,
      'ac': widget.estate.hasAirConditioning ?? false,
      'furnished': widget.estate.isFurnished ?? false,
      'utilities': widget.estate.utilitiesIncluded ?? false,
    };
  }

  void _initializeVillaData() {
    _typeSpecificControllers = {
      'totalRooms': TextEditingController(
          text: widget.estate.totalRooms?.toString() ?? ''),
      'totalBathrooms': TextEditingController(
          text: widget.estate.totalBathrooms?.toString() ?? ''),
      'totalKitchens': TextEditingController(
          text: widget.estate.totalKitchens?.toString() ?? ''),
    };

    _typeSpecificFeatures = {
      'balcony': widget.estate.hasBalcony ?? false,
      'parking': widget.estate.hasParking ?? false,
      'elevator': widget.estate.hasElevator ?? false,
      'storage': widget.estate.hasStorage ?? false,
      'ac': widget.estate.hasAirConditioning ?? false,
      'wifi': widget.estate.hasWifi ?? false,
      'pool': widget.estate.hasPool ?? false,
      'gym': widget.estate.gymNearby ?? false,
      'furnished': widget.estate.isFurnished ?? false,
      'utilities': widget.estate.utilitiesIncluded ?? false,
    };
  }

  void _initializeLandData() {
    _typeSpecificControllers = {};

    _typeSpecificFeatures = {
      'roadAccess': widget.estate.roadAccess ?? false,
    };
    _landType = widget.estate.landUse ?? 'agriculture';
  }
  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    setState(() {
      _images.addAll(pickedFiles.map((file) => XFile(file.path)));
    });
  }

  Future<void> _submitForm() async {
    try {
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
            content: Text('الرجاء تملئة كل المعلومات'),
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
              Text('جاري التعديل...'),
            ],
          ),
        ),
      );

// 1. First get ALL existing images from Firebase (not just the ones to keep)
      final allExistingImages = await FirebaseService().getAllImages(widget.estate.estateId);

// 2. Upload new images if any
      List<String> newImageUrls = [];
      if (_images.isNotEmpty) {
        print("Uploading ${_images.length} new images...");
        newImageUrls = await FirebaseService().uploadImages(_images, widget.estate.estateId);
        print("Uploaded new image URLs: $newImageUrls");
      }

// 3. Combine the images you WANT TO KEEP with new images
      final allImageUrls = [..._existingImageUrls, ...newImageUrls];
      print("All desired image URLs: $allImageUrls");

// 4. Find which existing images are NOT in the desired set
      final imagesToDelete = allExistingImages.where(
              (url) => !allImageUrls.contains(url)
      ).toList();
      print("Images to delete: $imagesToDelete");

// 5. Delete the unwanted images
      if (imagesToDelete.isNotEmpty) {
        print("Deleting ${imagesToDelete.length} images...");
        await FirebaseService().deleteImages(imagesToDelete, widget.estate.estateId);
        print("Deleted images.");
      }

      final updateData = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'listingType': _listingType,
        'price': double.parse(_priceController.text),
        'area': double.parse(_areaController.text),
        'city': _cityController.text,
        'locationDescription': _locationDescController.text,
        'latitude': _location!.latitude,
        'longitude': _location!.longitude,
        'ownerPhoneNumber': _phoneController.text,
        'videoTourUrl': _videoUrlController.text.isNotEmpty
            ? _videoUrlController.text
            : null,
        'images': allImageUrls,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // Add type-specific data
      switch (widget.estate.type) {
        case 'apartment':
          updateData.addAll({
            'totalRooms':
                int.parse(_typeSpecificControllers['totalRooms']!.text),
            'totalBathrooms':
                int.parse(_typeSpecificControllers['totalBathrooms']!.text),
            'totalKitchens':
                int.parse(_typeSpecificControllers['totalKitchens']!.text),
            'floor': _typeSpecificControllers['floor']!.text.isNotEmpty
                ? int.parse(_typeSpecificControllers['floor']!.text)
                : null,
            'totalFloors':
                _typeSpecificControllers['totalFloors']!.text.isNotEmpty
                    ? int.parse(_typeSpecificControllers['totalFloors']!.text)
                    : null,
            'hasBalcony': _typeSpecificFeatures['balcony'],
            'hasParking': _typeSpecificFeatures['parking'],
            'hasElevator': _typeSpecificFeatures['elevator'],
            'hasStorage': _typeSpecificFeatures['storage'],
            'hasAirConditioning': _typeSpecificFeatures['ac'],
            'hasWifi': _typeSpecificFeatures['wifi'],
            'hasPool': _typeSpecificFeatures['pool'],
            'gymNearby': _typeSpecificFeatures['gym'],
            'isFurnished': _typeSpecificFeatures['furnished'],
            'utilitiesIncluded': _typeSpecificFeatures['utilities'],
          });
          break;


        case 'house':
          updateData.addAll({
            'totalRooms': int.parse(_typeSpecificControllers['totalRooms']!.text),
            'totalBathrooms':
            int.parse(_typeSpecificControllers['totalBathrooms']!.text),
            'totalKitchens':
            int.parse(_typeSpecificControllers['totalKitchens']!.text),
            'totalFloors': _typeSpecificControllers['totalFloors']!.text.isNotEmpty
                ? int.parse(_typeSpecificControllers['totalFloors']!.text)
                : null,
            'hasBalcony': _typeSpecificFeatures['balcony'],
            'hasParking': _typeSpecificFeatures['parking'],
            'hasElevator': _typeSpecificFeatures['elevator'],
            'hasStorage': _typeSpecificFeatures['storage'],
            'hasAirConditioning': _typeSpecificFeatures['ac'],
            'isFurnished': _typeSpecificFeatures['furnished'],
            'utilitiesIncluded': _typeSpecificFeatures['utilities'],
          });
          break;
        case 'villa':
          updateData.addAll({
            'totalRooms': int.parse(_typeSpecificControllers['totalRooms']!.text),
            'totalBathrooms':
            int.parse(_typeSpecificControllers['totalBathrooms']!.text),
            'totalKitchens':
            int.parse(_typeSpecificControllers['totalKitchens']!.text),
            'hasBalcony': _typeSpecificFeatures['balcony'],
            'hasParking': _typeSpecificFeatures['parking'],
            'hasElevator': _typeSpecificFeatures['elevator'],
            'hasStorage': _typeSpecificFeatures['storage'],
            'hasAirConditioning': _typeSpecificFeatures['ac'],
            'hasWifi': _typeSpecificFeatures['wifi'],
            'hasPool': _typeSpecificFeatures['pool'],
            'gymNearby': _typeSpecificFeatures['gym'],
            'isFurnished': _typeSpecificFeatures['furnished'],
            'utilitiesIncluded': _typeSpecificFeatures['utilities'],
          });
          break;
        case 'land':
          updateData.addAll({
            'landType': _landType,
            'roadAccess': _typeSpecificFeatures['roadAccess'],
          });
          break;

      }

      final primary = FirebaseInstances.primary;
      final secondary = FirebaseInstances.secondary;

      final path = primary
          .collection('estates')
          .doc('listings')
          .collection(widget.estate.type)
          .doc(widget.estate.estateId);

      await Future.wait([
        path.update(updateData),
        secondary
            .collection('estates')
            .doc('listings')
            .collection(widget.estate.type)
            .doc(widget.estate.estateId)
            .update(updateData),
      ]);

      // Close loading dialog
      Navigator.pop(context);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم التعديل بنجاح!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back
      Navigator.pop(context);
    } catch (e) {
      // Close loading dialog if still open
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating listing: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error updating estate: $e');
    }
  }

  Widget _buildDetailsStep() {
    switch (widget.estate.type) {
      case 'apartment':
        return apartment_details.ApartmentDetailsStep(
          fadeAnimation: _fadeAnimation,
          areaController: _areaController,
          totalRoomsController: _typeSpecificControllers['totalRooms']!,
          totalBathroomsController: _typeSpecificControllers['totalBathrooms']!,
          totalKitchensController: _typeSpecificControllers['totalKitchens']!,
          floorController: _typeSpecificControllers['floor']!,
          totalFloorsController: _typeSpecificControllers['totalFloors']!,
        );
      case 'house':
        return house_details.HouseDetailsStep(
          fadeAnimation: _fadeAnimation,
          areaController: _areaController,
          totalRoomsController: _typeSpecificControllers['totalRooms']!,
          totalBathroomsController: _typeSpecificControllers['totalBathrooms']!,
          totalKitchensController: _typeSpecificControllers['totalKitchens']!,
          totalFloorsController: _typeSpecificControllers['totalFloors']!,
        );
      case 'villa':
        return villa_details.VillaDetailsStep(
          fadeAnimation: _fadeAnimation,
          areaController: _areaController,
          totalRoomsController: _typeSpecificControllers['totalRooms']!,
          totalBathroomsController: _typeSpecificControllers['totalBathrooms']!,
          totalKitchensController: _typeSpecificControllers['totalKitchens']!,
        );
      case 'land':
        return land_details.LandDetailsStep(
          fadeAnimation: _fadeAnimation,
          areaController: _areaController,
          landType: _landType,
          onLandTypeChanged: (value) => setState(() => _landType = value!),
        );
      default:
        return Container();
    }
  }

  Widget _buildFeaturesStep() {
    switch (widget.estate.type) {
      case 'apartment':
        return apartment_features.ApartmentFeaturesStep(
          fadeAnimation: _fadeAnimation,
          hasBalcony: _typeSpecificFeatures['balcony']!,
          hasParking: _typeSpecificFeatures['parking']!,
          hasElevator: _typeSpecificFeatures['elevator']!,
          hasStorage: _typeSpecificFeatures['storage']!,
          hasAirConditioning: _typeSpecificFeatures['ac']!,
          hasWifi: _typeSpecificFeatures['wifi']!,
          hasPool: _typeSpecificFeatures['pool']!,
          gymNearby: _typeSpecificFeatures['gym']!,
          isFurnished: _typeSpecificFeatures['furnished']!,
          utilitiesIncluded: _typeSpecificFeatures['utilities']!,
          onFeatureChanged: (feature, value) {
            setState(() {
              _typeSpecificFeatures[feature] = value;
            });
          },
        );
      case 'house':
        return house_features.HouseFeaturesStep(
          fadeAnimation: _fadeAnimation,
          hasBalcony: _typeSpecificFeatures['balcony']!,
          hasParking: _typeSpecificFeatures['parking']!,
          hasElevator: _typeSpecificFeatures['elevator']!,
          hasStorage: _typeSpecificFeatures['storage']!,
          hasAirConditioning: _typeSpecificFeatures['ac']!,
          isFurnished: _typeSpecificFeatures['furnished']!,
          utilitiesIncluded: _typeSpecificFeatures['utilities']!,
          onFeatureChanged: (feature, value) {
            setState(() {
              _typeSpecificFeatures[feature] = value;
            });
          },
        );
      case 'villa':
        return villa_features.VillaFeaturesStep(
          fadeAnimation: _fadeAnimation,
          hasBalcony: _typeSpecificFeatures['balcony']!,
          hasParking: _typeSpecificFeatures['parking']!,
          hasElevator: _typeSpecificFeatures['elevator']!,
          hasStorage: _typeSpecificFeatures['storage']!,
          hasAirConditioning: _typeSpecificFeatures['ac']!,
          hasWifi: _typeSpecificFeatures['wifi']!,
          hasPool: _typeSpecificFeatures['pool']!,
          gymNearby: _typeSpecificFeatures['gym']!,
          isFurnished: _typeSpecificFeatures['furnished']!,
          utilitiesIncluded: _typeSpecificFeatures['utilities']!,
          onFeatureChanged: (feature, value) {
            setState(() {
              _typeSpecificFeatures[feature] = value;
            });
          },
        );
      case 'land':
        return land_features.LandFeaturesStep(
          fadeAnimation: _fadeAnimation,
          onFeatureChanged: (feature, value) {
            setState(() {
              _typeSpecificFeatures[feature] = value;
            });
          },
          roadAccess: _typeSpecificFeatures['roadAccess']!,
        );
      default:
        return Container();
    }
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
    _phoneController.dispose();
    _videoUrlController.dispose();
    _cityController.dispose();

    // Dispose type-specific controllers
    _typeSpecificControllers.values
        .forEach((controller) => controller.dispose());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl, // Adjust based on your localization
      child: Scaffold(
        appBar: AppBar(),
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
                  _buildDetailsStep(),
                  _buildFeaturesStep(),
                  MediaStep(
                    fadeAnimation: _fadeAnimation,
                    images: _images,
                    existingImageUrls: _existingImageUrls,
                    videoUrlController: _videoUrlController,
                    onPickImages: _pickImages,
                    onRemoveImage: (index) {
                      setState(() {
                        _images.removeAt(index);
                      });
                    },
                    onRemoveExistingImage: (index) {
                      setState(() {
                        _existingImageUrls.removeAt(index);
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
                      child: Text('رجوع'),
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
                        await _submitForm();
                      }
                    },
                    child: Text(_currentStep == 4 ? "سلم" : "التالي"),
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
