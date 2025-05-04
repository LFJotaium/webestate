import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/firebase_instances.dart';
import '../models/estate_models/apartment_model.dart';
import '../models/estate_models/house_model.dart' show House;
import '../models/estate_models/land_model.dart' show Land;
import '../models/estate_models/villa_model.dart';

final userListedEstatesProvider = StateNotifierProvider.autoDispose<
    UserListedEstatesNotifier, AsyncValue<List<dynamic>>>((ref) {
  return UserListedEstatesNotifier();
});

class UserListedEstatesNotifier extends StateNotifier<AsyncValue<List<dynamic>>> {
  UserListedEstatesNotifier() : super(const AsyncValue.loading());

  static const _estateTypes = ['apartment', 'villa', 'land', 'house'];
  final _random = Random();

  FirebaseFirestore get _randomFirestore => FirebaseInstances.primary;

  Future<void> loadEstates(String userId) async {
    state = const AsyncValue.loading();
    try {
      final listingIds = await _fetchUserListingIds(userId);
      if (listingIds.isEmpty) {
        state = AsyncValue.data([]);
        return;
      }

      final estates = await _fetchEstates(listingIds);
      state = AsyncValue.data(estates);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<List<String>> _fetchUserListingIds(String userId) async {
    final userDoc = await _randomFirestore.collection('users').doc(userId).get();
    final listingIds = userDoc.data()?['listingIds'] as List<dynamic>?;

    return listingIds?.whereType<String>().toList() ?? [];
  }

  Future<List<dynamic>> _fetchEstates(List<String> listingIds) async {
    final estates = <dynamic>[];

    for (final id in listingIds) {
      final estateId = id.split('|').last;
      final estate = await _findEstate(estateId);
      if (estate != null) {
        estates.add(estate);
      }
    }

    return estates;
  }

  Future<dynamic> _findEstate(String estateId) async {
    for (final type in _estateTypes) {
      try {
        final doc = await _randomFirestore
            .collection('estates')
            .doc('listings')
            .collection(type)
            .doc(estateId)
            .get();

        if (doc.exists) {
          return _parseEstate(type, doc.data()!);
        }
      } catch (_) {
        continue; // Try the next type
      }
    }
    return null;
  }

  dynamic _parseEstate(String type, Map<String, dynamic> data) {
    switch (type) {
      case 'apartment':
        return Apartment.fromMap(data);
      case 'villa':
        return Villa.fromMap(data);
      case 'house':
        return House.fromMap(data);
      case 'land':
        return Land.fromMap(data);
      default:
        throw UnsupportedError('Unsupported estate type: $type');
    }
  }
}
