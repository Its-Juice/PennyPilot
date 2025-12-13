import 'package:flutter/material.dart';

/// Shared axis page transition (Material 3 motion)
class SharedAxisPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final SharedAxisTransitionType transitionType;

  SharedAxisPageRoute({
    required this.page,
    this.transitionType = SharedAxisTransitionType.horizontal,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: transitionType,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );
}

enum SharedAxisTransitionType {
  horizontal,
  vertical,
  scaled,
}

/// Shared axis transition widget
class SharedAxisTransition extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final SharedAxisTransitionType transitionType;
  final Widget child;

  const SharedAxisTransition({
    super.key,
    required this.animation,
    required this.secondaryAnimation,
    required this.transitionType,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    switch (transitionType) {
      case SharedAxisTransitionType.horizontal:
        return _buildHorizontalTransition();
      case SharedAxisTransitionType.vertical:
        return _buildVerticalTransition();
      case SharedAxisTransitionType.scaled:
        return _buildScaledTransition();
    }
  }

  Widget _buildHorizontalTransition() {
    final incomingSlide = Tween<Offset>(
      begin: const Offset(0.3, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    ));

    final outgoingSlide = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.3, 0.0),
    ).animate(CurvedAnimation(
      parent: secondaryAnimation,
      curve: Curves.easeInOut,
    ));

    final incomingFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
    ));

    final outgoingFade = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: secondaryAnimation,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    ));

    return SlideTransition(
      position: secondaryAnimation.status == AnimationStatus.forward
          ? outgoingSlide
          : incomingSlide,
      child: FadeTransition(
        opacity: secondaryAnimation.status == AnimationStatus.forward
            ? outgoingFade
            : incomingFade,
        child: child,
      ),
    );
  }

  Widget _buildVerticalTransition() {
    final incomingSlide = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    ));

    final outgoingSlide = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -0.3),
    ).animate(CurvedAnimation(
      parent: secondaryAnimation,
      curve: Curves.easeInOut,
    ));

    final incomingFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
    ));

    final outgoingFade = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: secondaryAnimation,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    ));

    return SlideTransition(
      position: secondaryAnimation.status == AnimationStatus.forward
          ? outgoingSlide
          : incomingSlide,
      child: FadeTransition(
        opacity: secondaryAnimation.status == AnimationStatus.forward
            ? outgoingFade
            : incomingFade,
        child: child,
      ),
    );
  }

  Widget _buildScaledTransition() {
    final incomingScale = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    ));

    final outgoingScale = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: secondaryAnimation,
      curve: Curves.easeInOut,
    ));

    final incomingFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
    ));

    final outgoingFade = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: secondaryAnimation,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    ));

    return ScaleTransition(
      scale: secondaryAnimation.status == AnimationStatus.forward
          ? outgoingScale
          : incomingScale,
      child: FadeTransition(
        opacity: secondaryAnimation.status == AnimationStatus.forward
            ? outgoingFade
            : incomingFade,
        child: child,
      ),
    );
  }
}

/// Fade through transition (for switching between views)
class FadeThroughTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const FadeThroughTransition({
    super.key,
    required this.animation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final fadeIn = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: const Interval(0.35, 1.0, curve: Curves.easeIn),
    ));

    final scaleIn = Tween<double>(
      begin: 0.92,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: const Interval(0.35, 1.0, curve: Curves.easeOut),
    ));

    return FadeTransition(
      opacity: fadeIn,
      child: ScaleTransition(
        scale: scaleIn,
        child: child,
      ),
    );
  }
}
