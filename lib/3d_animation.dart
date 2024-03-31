import 'dart:math' show pi;
import 'package:vector_math/vector_math_64.dart' show Vector3;

import 'package:flutter/material.dart';

class ThreeDAnimation extends StatefulWidget {
  const ThreeDAnimation({super.key});

  @override
  State<ThreeDAnimation> createState() => _ThreeDAnimationState();
}

class _ThreeDAnimationState extends State<ThreeDAnimation>
    with TickerProviderStateMixin {
  late AnimationController controllerX;
  late AnimationController controllerY;
  late AnimationController controllerZ;

  late Tween<double> animation;

  @override
  void initState() {
    controllerX =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    controllerY =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    controllerZ =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));

    animation = Tween<double>(begin: 0, end: 2 * pi);
    super.initState();
  }

  @override
  void dispose() {
    controllerX.dispose();
    controllerY.dispose();
    controllerZ.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controllerX
      ..reset()
      ..repeat();
    controllerY
      ..reset()
      ..repeat();
    controllerZ
      ..reset()
      ..repeat();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 200,
              width: double.infinity,
            ),
            AnimatedBuilder(
                animation: Listenable.merge([
                  controllerX,
                  controllerY,
                  controllerX,
                ]),
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..rotateX(animation.evaluate(controllerX))
                      ..rotateY(animation.evaluate(controllerY))
                      ..rotateZ(animation.evaluate(controllerZ)),
                    child: Stack(
                      children: [
                        //back
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..translate(Vector3(0,0,-100)),
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.purple,
                          ),
                        ),
                        //left side
                        Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()..rotateY(pi/2),
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.red,
                          ),
                        ),
                        //right side
                        Transform(
                          alignment: Alignment.centerRight,
                          transform: Matrix4.identity()..rotateY(-pi/2),
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.blue,
                          ),
                        ),
                        //front
                        Container(
                          width: 100,
                          height: 100,
                          color: Colors.green,
                        ),

                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
