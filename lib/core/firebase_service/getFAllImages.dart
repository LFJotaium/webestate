import 'package:cloudflare_r2/cloudflare_r2.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<List<String>> getFAllImages(String estateId) async {
  const String bucketName = 'estate-images'; // Your actual bucket
  const String r2BaseUrl = 'https://pub-ee983ae954aa4945abf34f2df011e49c.r2.dev';

  try {
    final prefix = 'estates/$estateId/previewimages/';
    final objects = await CloudFlareR2.listObjectsV2(
      bucket: bucketName,
      prefix: prefix,
    );

    final urls = objects.map((obj) => '$r2BaseUrl/${obj.key}').toList();
    return urls;
  } catch (e) {
    print('❌ Error getting all R2 images for estate $estateId: $e');
    return [];
  }
}
