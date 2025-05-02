import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaStep extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final List<XFile> images;
  final List<String> existingImageUrls;
  final TextEditingController videoUrlController;
  final Function() onPickImages;
  final Function(int) onRemoveImage;
  final Function(int) onRemoveExistingImage;

  const MediaStep({
    required this.fadeAnimation,
    required this.images,
    required this.existingImageUrls,
    required this.videoUrlController,
    required this.onPickImages,
    required this.onRemoveImage,
    required this.onRemoveExistingImage,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Text(
              'الصور',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),

            // Display existing images
            if (existingImageUrls.isNotEmpty) ...[
              Text('الصور المتواجدة', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: existingImageUrls.length,
                  itemBuilder: (ctx, i) {
                    return Stack(
                      children: [
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: NetworkImage(existingImageUrls[i]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          left: 8,
                          child: GestureDetector(
                            onTap: () => onRemoveExistingImage(i),
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
                  },
                ),
              ),
              SizedBox(height: 16),
            ],

            // Display new images to be uploaded
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length + 1,
                itemBuilder: (ctx, i) {
                  if (i == images.length) {
                    return GestureDetector(
                      onTap: onPickImages,
                      child: Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                              Text(
                                'اضف المزيد',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  return FutureBuilder<Uint8List>(
                    future: images[i].readAsBytes(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          width: 150,
                          margin: const EdgeInsets.only(right: 8),
                          child: const Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (snapshot.hasError || !snapshot.hasData) {
                        return Container(
                          width: 150,
                          margin: const EdgeInsets.only(right: 8),
                          color: Colors.grey.shade300,
                          child: const Center(child: Icon(Icons.error)),
                        );
                      }

                      return Stack(
                        children: [
                          Container(
                            width: 150,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: MemoryImage(snapshot.data!),
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
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close, color: Colors.white, size: 16),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 24),
            TextFormField(
              controller: videoUrlController,
              decoration: InputDecoration(
                labelText: 'رابط فيديو عرض',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.video_library),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              keyboardType: TextInputType.url,
            ),
          ],
        ),
      ),
    );
  }
}