import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../data/models/estate_models/abstract_estate_model.dart';

class ProfileEstateCarousel extends StatefulWidget {
  final List<dynamic> estates;
  final Widget Function(BuildContext, Estate, int) itemBuilder;

  const ProfileEstateCarousel({
    Key? key,
    required this.estates,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  State<ProfileEstateCarousel> createState() => _ProfileEstateCarouselState();
}

class _ProfileEstateCarouselState extends State<ProfileEstateCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final nextPage = _pageController.page?.round() ?? 0;
    if (nextPage != _currentPage) {
      setState(() {
        _currentPage = nextPage;
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_scrollListener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    if (widget.estates.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/empty_results_illustration.svg',
            width: 120,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            "No estates available",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        SizedBox(
          height: isDesktop ? 380 : 340, // Fixed height for carousel
          child: Scrollbar(
            controller: _pageController,
            thumbVisibility: true,
            child: ListView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.estates.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - index;
                      value = (1 - (value.abs() * 0.2)).clamp(0.8, 1.0);
                    }
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: isDesktop ? 20 : 15,
                          left: index == 0 ? (isDesktop ? 20 : 15) : 0,
                        ),
                        child: SizedBox(
                          height: 380, // Fixed height for cards
                          width: isDesktop ? 350 : 300, // Fixed width for cards
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: widget.itemBuilder(context, widget.estates[index], index),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (widget.estates.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.estates.length,
                  (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: _currentPage == index ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}