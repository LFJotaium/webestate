import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/firebase_instances.dart';
import '../models/estate_models/apartment_model.dart';
import '../models/estate_models/house_model.dart' show House;
import '../models/estate_models/land_model.dart' show Land;
import '../models/estate_models/villa_model.dart';



final savedEstatesProvider = StateNotifierProvider.autoDispose<
    SavedEstatesNotifier, AsyncValue<List<dynamic>>>((ref) {
  return SavedEstatesNotifier();
});

class SavedEstatesNotifier extends StateNotifier<AsyncValue<List<dynamic>>> {
  SavedEstatesNotifier() : super(const AsyncValue.loading());

  final _random = Random();

  /// Randomly choose either primary or secondary Firestore instance
  FirebaseFirestore get randomFirestore => FirebaseInstances.primary;


  Future<void> loadSavedEstates(String userId) async {
    state = const AsyncValue.loading();
    try {
      final userDoc = await randomFirestore.collection('users').doc(userId).get();
      final savedIds = userDoc.data()?['savedEstateIds'] as List<dynamic>? ?? [];

      if (savedIds.isEmpty) {
        state = AsyncValue.data([]);
        return;
      }

      final estates = <dynamic>[];

      for (final id in savedIds) {
        final parts = (id as String).split('|');
        if (parts.length != 2) continue;

        final type = parts[0];
        final estateId = parts[1];

        final doc = await randomFirestore
            .collection('estates')
            .doc('listings')
            .collection(type)
            .doc(estateId)
            .get();

        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          switch (type) {
            case 'apartment':
              estates.add(House.fromMap(data));
              break;
            case 'villa':
              estates.add(Villa.fromMap(data));
              break;
            case 'house':
              estates.add(House.fromMap(data));
              break;
            case 'land':
              estates.add(Land.fromMap(data));
              break;
          }
        }
      }

      state = AsyncValue.data(estates);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> toggleSaveEstate(
      String userId,
      String estateId,
      String estateType,
      BuildContext context,
      ) async {
    try {
      final estateKey = '$estateType|$estateId';

      final primaryUserRef = FirebaseInstances.primary.collection('users').doc(userId);
      final secondaryUserRef = FirebaseInstances.secondary.collection('users').doc(userId);

      // Use random Firestore for reading
      final userDoc = await randomFirestore.collection('users').doc(userId).get();
      final currentSaved = List<String>.from(userDoc.data()?['savedEstateIds'] ?? []);
      final isSaved = currentSaved.contains(estateKey);

      if (isSaved) {
        await Future.wait([
          primaryUserRef.update({
            'savedEstateIds': FieldValue.arrayRemove([estateKey])
          }),
          secondaryUserRef.update({
            'savedEstateIds': FieldValue.arrayRemove([estateKey])
          }),
        ]);

        if (state is AsyncData<List<dynamic>>) {
          final currentEstates = (state as AsyncData<List<dynamic>>).value;
          state = AsyncValue.data([
            for (final estate in currentEstates)
              if ((estate.estateId != estateId) || (estate.type != estateType)) estate
          ]);
        }
      } else {
        if (!isSaved && currentSaved.length >= 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'لقد تجاوزت الحد الأقصى لحفظ العقارات (10 عقارات).',
                textDirection: TextDirection.rtl,
              ),
              backgroundColor: Colors.redAccent,
            ),
          );
          return;
        }

        await Future.wait([
          primaryUserRef.update({
            'savedEstateIds': FieldValue.arrayUnion([estateKey])
          }),
          secondaryUserRef.update({
            'savedEstateIds': FieldValue.arrayUnion([estateKey])
          }),
        ]);

        final doc = await randomFirestore
            .collection('estates')
            .doc('listings')
            .collection(estateType)
            .doc(estateId)
            .get();

        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          dynamic newEstate;

          switch (estateType) {
            case 'apartment':
              newEstate = House.fromMap(data);
              break;
            case 'villa':
              newEstate = Villa.fromMap(data);
              break;
            case 'house':
              newEstate = House.fromMap(data);
              break;
            case 'land':
              newEstate = Land.fromMap(data);
              break;
          }

          if (state is AsyncData<List<dynamic>>) {
            final currentEstates = (state as AsyncData<List<dynamic>>).value;
            state = AsyncValue.data([...currentEstates, newEstate]);
          } else {
            state = AsyncValue.data([newEstate]);
          }
        }
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
