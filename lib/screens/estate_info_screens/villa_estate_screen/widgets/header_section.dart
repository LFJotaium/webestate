import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webestate/data/models/estate_models/villa_model.dart';

import '../../../../data/models/estate_models/apartment_model.dart';

class HeaderSection extends StatefulWidget {
  final Villa villa;

  const HeaderSection({super.key, required this.villa});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  late PageController _pageController;
  int _currentPage = 0;
  bool _showArrows = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    widget.villa.images.forEach((url) {
      PaintingBinding.instance.imageCache.evict(url);
    });
    super.dispose();
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;
    final hasMultipleImages = widget.villa.images.length > 1;

    return SliverAppBar(
      expandedHeight: isWeb ? 500 : 300,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: MouseRegion(
              onEnter: (_) => setState(() => _showArrows = isWeb && hasMultipleImages),
              onExit: (_) => setState(() => _showArrows = false),
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: widget.villa.images.length,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: widget.villa.images[index],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[200],
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      );
                    },
                  ),

                  // Left arrow
                  if (_showArrows && _currentPage > 0)
                    Positioned(
                      left: 20,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 36,
                          ),
                          onPressed: () => _goToPage(_currentPage - 1),
                        ),
                      ),
                    ),

                  // Right arrow
                  if (_showArrows && _currentPage < widget.villa.images.length - 1)
                    Positioned(
                      right: 20,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 36,
                          ),
                          onPressed: () => _goToPage(_currentPage + 1),
                        ),
                      ),
                    ),

                  // Page indicator
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: widget.villa.images.length,
                        effect: const ExpandingDotsEffect(
                          dotWidth: 8,
                          dotHeight: 8,
                          activeDotColor: Colors.white,
                          dotColor: Colors.white54,
                        ),
                        onDotClicked: (index) => _goToPage(index),
                      ),
                    ),
                  ),

                  // Video tour button
                  if (widget.villa.videoTourUrl.isNotEmpty)
                    Positioned(
                      bottom: 16,
                      right: isWeb ? 32 : 16,
                      child: GestureDetector(
                        onTap: () => _launchVideoTour(widget.villa.videoTourUrl),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.play_arrow, color: Colors.white),
                              const SizedBox(width: 8),
                              Text(
                                'جولة فيديو',
                                style: GoogleFonts.cairo(
                                  color: Colors.white,
                                  fontSize: isWeb ? 18 : 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchVideoTour(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}