import 'dart:math' show pi;

import 'package:flutter/material.dart';

class RotateSquare extends StatefulWidget {
  const RotateSquare({super.key});

  @override
  State<RotateSquare> createState() => _RotateSquareState();
}

class _RotateSquareState extends State<RotateSquare>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = Tween<double>(begin: 0, end: 2 * pi).animate(controller);
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: AnimatedBuilder(
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateX(animation.value),
                  child: Container(
                    alignment: Alignment.center,
                    width: width * .3,
                    height: width * .3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(height * .04),
                      color: Colors.teal,
                    ),
                    child: const Text(
                      'X',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateZ(animation.value),
                  child: Container(
                    alignment: Alignment.center,
                    width: width * .3,
                    height: width * .3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(height * .04),
                      color: Colors.cyan,
                    ),
                    child: const Text(
                      'Z',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(animation.value),
                  child: Container(
                    alignment: Alignment.center,
                    width: width * .3,
                    height: width * .3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(height * .04),
                      color: Colors.yellow,
                    ),
                    child: const Text(
                      'Y',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          animation: controller,
        ),
      ),
    );
  }
}
