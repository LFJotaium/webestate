import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum TransitionType {
  slideUp,
  slideHorizontal,
  fadeThrough,
  zoom,
  materialSharedAxis,
}

class CustomTransition extends CustomTransitionPage {
  final Widget child;
  final TransitionType transitionType;
  final Curve curve;
  final Duration duration;

  CustomTransition({
    required this.child,
    required this.transitionType,
    this.curve = Curves.easeInOut,
    this.duration = const Duration(milliseconds: 300),
    super.key,
  }) : super(
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (transitionType) {
        case TransitionType.slideUp:
          return _slideUpTransition(animation, child, curve);
        case TransitionType.slideHorizontal:
          return _slideHorizontalTransition(animation, child, curve);
        case TransitionType.fadeThrough:
          return _fadeThroughTransition(animation, secondaryAnimation, child);
        case TransitionType.zoom:
          return _zoomTransition(animation, child, curve);
        case TransitionType.materialSharedAxis:
          return _sharedAxisTransition(animation, secondaryAnimation, child);
      }
    },
  );

  // Slide up transition (like bottom sheet)
  static Widget _slideUpTransition(Animation<double> animation, Widget child, Curve curve) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: curve)),
      child: child,
    );
  }

  // Horizontal slide (like view pager)
  static Widget _slideHorizontalTransition(Animation<double> animation, Widget child, Curve curve) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: curve)),
      child: child,
    );
  }

  // Material fade through
  static Widget _fadeThroughTransition(
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return FadeTransition(
      opacity: animation,
      child: FadeTransition(
        opacity: ReverseAnimation(secondaryAnimation),
        child: child,
      ),
    );
  }

  // Zoom transition
  static Widget _zoomTransition(Animation<double> animation, Widget child, Curve curve) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.9, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: curve),
      ),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  // Material Shared Axis (requires material_components package)
  static Widget _sharedAxisTransition(
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return SharedAxisTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.horizontal,
      child: child,
    );
  }
}