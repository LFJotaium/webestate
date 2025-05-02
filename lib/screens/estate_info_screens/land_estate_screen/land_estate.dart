
import 'package:webestate/screens/estate_info_screens/land_estate_screen/widgets/action_button_section.dart';
import 'package:webestate/screens/estate_info_screens/land_estate_screen/widgets/amenities_section.dart';
import 'package:webestate/screens/estate_info_screens/land_estate_screen/widgets/description_section.dart';
import 'package:webestate/screens/estate_info_screens/land_estate_screen/widgets/details_section.dart';
import 'package:webestate/screens/estate_info_screens/land_estate_screen/widgets/features_section.dart';
import 'package:webestate/screens/estate_info_screens/land_estate_screen/widgets/header_section.dart';
import 'package:webestate/screens/estate_info_screens/land_estate_screen/widgets/info_card_section.dart';
import 'package:webestate/screens/estate_info_screens/land_estate_screen/widgets/location_section.dart';
import 'package:webestate/screens/estate_info_screens/land_estate_screen/widgets/owner_info_section.dart';
import 'package:webestate/screens/estate_info_screens/land_estate_screen/widgets/reviews_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../../../core/firebase_instances.dart';
import '../../../data/application/saved_estates_provider.dart';
import '../../../data/models/estate_models/land_model.dart';


class LandDetailsPage extends ConsumerStatefulWidget {
  final Land land;

  const LandDetailsPage({super.key, required this.land});

  @override
  ConsumerState<LandDetailsPage> createState() => _LandDetailsPageState();
}

class _LandDetailsPageState extends ConsumerState<LandDetailsPage> {




  final currentUser = FirebaseAuth.instance.currentUser;
  late Future<bool> _isSavedFuture;

  @override
  void initState() {
    super.initState();
    _isSavedFuture = _checkIfSaved();
  }

  Future<bool> _checkIfSaved() async {
    if (currentUser == null) return false;

    final firestore = (DateTime.now().millisecondsSinceEpoch % 2 == 0)
        ? FirebaseInstances.primary
        : FirebaseInstances.secondary;

    final userDoc =
    await firestore.collection('users').doc(currentUser!.uid).get();

    final savedIds = List<String>.from(userDoc.data()?['savedEstateIds'] ?? []);
    return savedIds.contains('land|${widget.land.estateId}');
  }

  Future<void> _toggleSave() async {
    if (currentUser == null) {
      // Show login dialog or redirect to login
      return;
    }

    final notifier = ref.read(savedEstatesProvider.notifier);
    await notifier.toggleSaveEstate(
      currentUser!.uid,
      widget.land.estateId,
      'land',context
    );

    // Update local UI state
    setState(() {
      _isSavedFuture = _isSavedFuture.then((value) => !value);
    });
  }






  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isFavorite = ValueNotifier(false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: CustomScrollView(
        slivers: [
          HeaderSection(land: widget.land),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoCardSection(land: widget.land),
                  const SizedBox(height: 24),
                  OwnerInfoSection(land: widget.land),
                  const SizedBox(height: 24),
                  DetailsSection(land: widget.land),
                  const SizedBox(height: 24),
                  LocationSection(land: widget.land),

                ],
              ),
            ),
          ),
        ],
      ),

    );
  }

  AppBar _buildAppBar(
      BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              context.pop();
            } else {
              context.go('/startup_screen');
            }
          }      ),
      actions: [

        if(FirebaseAuth.instance.currentUser != null)
          if (FirebaseAuth.instance.currentUser!.uid == widget.land.ownerId)          IconButton(
            icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                )),
            onPressed: () => context.push('/update_screen',extra: widget.land),
          ),
        FutureBuilder<bool>(
          future: _isSavedFuture,
          builder: (context, snapshot) {

            final isSaved = snapshot.data ?? false;
            print(isSaved);
            return IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isSaved ? Icons.favorite : Icons.favorite_border,
                  color: isSaved ? Colors.red : Colors.white,
                ),
              ),
              onPressed: _toggleSave,
            );
          },
        ),

      ],
    );
  }


}