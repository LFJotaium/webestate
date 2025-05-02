import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../../../l10n/generated/app_localizations.dart';

class MediaStep extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final List<XFile> images;
  final TextEditingController videoUrlController;
  final Function() onPickImages;
  final Function(int) onRemoveImage;

  const MediaStep({
    required this.fadeAnimation,
    required this.images,
    required this.videoUrlController,
    required this.onPickImages,
    required this.onRemoveImage,
  });


  Future<dynamic> getImage(XFile image) async {
    return await image.readAsBytes();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).add_apartment_media,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 24),
            Text(
              AppLocalizations.of(context).add_apartment_addPhotos,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            images.isEmpty
                ? GestureDetector(
              onTap: onPickImages,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt,
                        size: 50, color: Colors.grey.shade400),
                    SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context).add_apartment_photosHint,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn().scale()
                : SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length + 1,
                  // In the ListView.builder where you display images
                  itemBuilder: (ctx, i) {
                    if (i == images.length) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: onPickImages,
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                style: BorderStyle.solid,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add,
                                      size: 40,
                                      color: Colors.grey.shade400),
                                  Text(
                                    AppLocalizations.of(context).add_apartment_addPhotos,
                                    style: TextStyle(
                                        color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    print(images[i].path);
                    // Fetch image as bytes and display as MemoryImage
                    return FutureBuilder(
                      future: getImage(XFile(images[i].path)),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasData) {
                          final imageBytes = snapshot.data as List<int>;
                          return Stack(
                            children: [
                              Container(
                                width: 150,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: MemoryImage(Uint8List.fromList(imageBytes)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: GestureDetector(
                                  onTap: () => onRemoveImage(i),
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.close,
                                        color: Colors.white, size: 16),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        // In case of an error
                        return Container(
                          width: 150,
                          margin: EdgeInsets.only(right: 8),
                          color: Colors.grey.shade300,
                          child: Center(child: Icon(Icons.error)),
                        );
                      },
                    );
                  }
              ),
            ),
            SizedBox(height: 24),
            TextFormField(
              controller: videoUrlController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).add_apartment_videoUrl,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.video_library),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              keyboardType: TextInputType.url,
              textDirection: AppLocalizations.of(context).localeName == 'ar' ||
                  AppLocalizations.of(context).localeName == 'he'
                  ? TextDirection.rtl : TextDirection.ltr,
            ).animate().fadeIn().slideX(begin: 0.1, end: 0),
          ],
        ),
      ),
    );
  }
}