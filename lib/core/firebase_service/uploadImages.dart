import 'dart:typed_data';
import 'dart:io' show File; // Only used on non-web platforms
import 'package:cloudflare_r2/cloudflare_r2.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';

Future<List<String>> uploadFImages(List<dynamic> images, String estateId) async {
  const String bucketName = 'estate-images';
  const String r2BaseUrl = 'https://pub-ee983ae954aa4945abf34f2df011e49c.r2.dev';

  List<String> imageUrls = [];

  try {
    for (int i = 0; i < images.length; i++) {
      Uint8List imageBytes;

      if (kIsWeb) {
        // Web: images are XFile
        imageBytes = await (images[i] as XFile).readAsBytes();
      } else {
        // Mobile/Desktop: images can be File or XFile
        if (images[i] is XFile) {
          imageBytes = await (images[i] as XFile).readAsBytes();
        } else if (images[i] is File) {
          imageBytes = await (images[i] as File).readAsBytes();
        } else {
          throw Exception("Unsupported image type");
        }
      }

      final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
      final objectPath = 'estates/$estateId/previewimages/$fileName';

      await CloudFlareR2.putObject(
        bucket: bucketName,
        objectName: objectPath,
        objectBytes: imageBytes,
        contentType: 'image/jpeg',
      );

      final url = '$r2BaseUrl/$objectPath';
      imageUrls.add(url);
    }
  } catch (e) {
    throw Exception('❌ Error uploading images to R2: $e');
  }

  return imageUrls;
}
