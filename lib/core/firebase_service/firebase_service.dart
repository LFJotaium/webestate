import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cloudflare_r2/cloudflare_r2.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:webestate/core/firebase_service/uploadImages.dart';
import '../firebase_instances.dart';
import 'deleteFImages.dart';
import 'getFAllImages.dart';

class FirebaseService {
  Future<List<String>> uploadImages(List<dynamic> images, String estateId) async {
    return await uploadFImages(images, estateId);
  }


  Future<List<String>> getAllImages(String estateId) async {
    return await getFAllImages(estateId);
  }


  Future<void> deleteImages(List<String> imageUrls, String estateId) async {
    await deleteFImages(imageUrls,estateId);
  }




  Future<void> removeSavedEstate(String userId, String estateIdWithType) async {
    try {
      final userRefPrimary = FirebaseInstances.primary.collection('users').doc(userId);
      final userRefSecondary = FirebaseInstances.secondary.collection('users').doc(userId);

      await Future.wait([
        userRefPrimary.update({
          'savedEstateIds': FieldValue.arrayRemove([estateIdWithType])
        }),
        userRefSecondary.update({
          'savedEstateIds': FieldValue.arrayRemove([estateIdWithType])
        }),
      ]);

      print('Estate removed successfully from both Firestores');
    } catch (e) {
      print('Error removing estate: $e');
      throw e;
    }
  }

  Future<void> addEstateToUserListings({
    required String userId,
    required String estateId,
  }) async {
    final userRefPrimary = FirebaseInstances.primary.collection('users').doc(userId);
    final userRefSecondary = FirebaseInstances.secondary.collection('users').doc(userId);

    try {
      await Future.wait([
        userRefPrimary.update({
          'listingIds': FieldValue.arrayUnion([estateId]),
        }),
        userRefSecondary.update({
          'listingIds': FieldValue.arrayUnion([estateId]),
        }),
      ]);
    } catch (e) {
      throw Exception('Error adding estate to user listings in both Firestores: $e');
    }
  }





  Future<void> cloudfareInit() async {
    try {
      CloudFlareR2.init(
        accoundId: dotenv.env['CLOUDFARE_ACCOUNT_ID']!,
        accessKeyId: dotenv.env['CLOUDFARE_ACCESS_KEY_ID']!,
        secretAccessKey: dotenv.env['CLOUDFARE_SECRET_ACCESS_ID']!,
      );
    }
    catch(e){
      print(e.toString());
    }
  }

}
