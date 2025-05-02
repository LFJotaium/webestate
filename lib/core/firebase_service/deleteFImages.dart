import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloudflare_r2/cloudflare_r2.dart';

Future<void> deleteFImages(List<String> imageUrls, String estateId) async {
  const String bucketName = 'estate-images'; // Your R2 bucket name
  const String r2BaseUrl = 'https://pub-ee983ae954aa4945abf34f2df011e49c.r2.dev';

  try {

    // Extract object names from URLs
    final objectNames = imageUrls.map((url) {
      if (url.startsWith(r2BaseUrl)) {
        return url.replaceFirst(r2BaseUrl, '');
      } else {
        throw Exception('Invalid R2 URL format: $url');
      }
    }).toList();

    // Delete in batch
    await CloudFlareR2.deleteObjects(
      bucket: bucketName,
      objectNames: objectNames,
    );
  } catch (e) {
    throw Exception('❌ Error deleting R2 images: $e');
  }
}
