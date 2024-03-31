import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TwoHalfCircleAnimations extends StatefulWidget {
  const TwoHalfCircleAnimations({super.key});

  @override
  State<TwoHalfCircleAnimations> createState() =>
      _TwoHalfCircleAnimationsState();
}

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;
    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }
    path.arcToPoint(
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      offset,
      clockwise: clockwise,
    );
    path.close();
    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;

  const HalfCircleClipper({required this.side});

  @override
  Path getClip(Size size) {
    return side.toPath(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

class _TwoHalfCircleAnimationsState extends State<TwoHalfCircleAnimations>
    with TickerProviderStateMixin {
  late AnimationController _counterClockwiseRotationController;
  late Animation<double> _counterClockwiseAnimation;

  late AnimationController _flipAnimationController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    _counterClockwiseRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _counterClockwiseAnimation = Tween<double>(begin: 0, end: -pi / 2).animate(
      CurvedAnimation(
          parent: _counterClockwiseRotationController, curve: Curves.bounceOut),
    );

    //flip animation
    _flipAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(
          parent: _flipAnimationController, curve: Curves.bounceOut),
    );

    _counterClockwiseRotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
                begin: _flipAnimation.value, end: _flipAnimation.value + pi)
            .animate(
          CurvedAnimation(
              parent: _flipAnimationController, curve: Curves.bounceOut),
        );
        _flipAnimationController
          ..reset()
          ..forward();
      }
    });
    _flipAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _counterClockwiseAnimation = Tween<double>(
                begin: _counterClockwiseAnimation.value,
                end: _counterClockwiseAnimation.value - pi / 2.0)
            .animate(
          CurvedAnimation(
              parent: _counterClockwiseRotationController, curve: Curves.bounceOut),
        );
        _counterClockwiseRotationController
          ..reset()
          ..forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _counterClockwiseRotationController.dispose();
    _flipAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width / 2;

    _counterClockwiseRotationController
      ..reset()
      ..forward.delayed(
        const Duration(seconds: 1),
      );

    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: _counterClockwiseRotationController,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(_counterClockwiseAnimation.value),
                child: Row(
                  children: [
                    AnimatedBuilder(
                      animation: _flipAnimationController,
                      builder: (context,child) {
                        return Transform(
                          transform: Matrix4.rotationX(_flipAnimationController.value),
                          alignment: Alignment.centerRight,
                          child: ClipPath(
                            clipper: HalfCircleClipper(side: CircleSide.left),
                            child: Container(
                              width: size,
                              height: size,
                              color: Colors.blue,
                            ),
                          ),
                        );
                      }
                    ),
                    AnimatedBuilder(
                      animation: _flipAnimationController,
                      builder: (context,child) {
                        return Transform(
                          transform: Matrix4.rotationX(_flipAnimationController.value),
                          alignment: Alignment.centerLeft,
                          child: ClipPath(
                            clipper: HalfCircleClipper(side: CircleSide.right),
                            child: Container(
                              width: size,
                              height: size,
                              color: Colors.red,
                            ),
                          ),
                        );
                      }
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
