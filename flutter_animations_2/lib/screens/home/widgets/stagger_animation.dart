import 'package:flutter/material.dart';
import 'package:flutter_animations_2/screens/home/widgets/animated_list_view.dart';
import 'package:flutter_animations_2/screens/home/widgets/fade_container.dart';
import 'package:flutter_animations_2/screens/home/widgets/home_top.dart';

class StaggerAnimation extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> containerGrow;
  final Animation<EdgeInsets> listSlidePosition;
  final Animation<Color?> fadeAnimation;

  StaggerAnimation({Key? key, required this.controller})
      : containerGrow = CurvedAnimation(
          parent: controller,
          curve: Curves.ease,
        ),
        listSlidePosition = EdgeInsetsTween(
                begin: const EdgeInsets.only(bottom: 0),
                end: const EdgeInsets.only(bottom: 80))
            .animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.3, 0.8, curve: Curves.ease),
          ),
        ),
        fadeAnimation = ColorTween(
                begin: const Color.fromRGBO(255, 26, 26, 1.0),
                end: const Color.fromRGBO(255, 26, 26, 0))
            .animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.decelerate,
          ),
        ),
        super(key: key);

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.zero,
          children: [
            HomeTop(containerGrow: containerGrow),
            AnimatedListView(listSlidePosition: listSlidePosition),
          ],
        ),
        IgnorePointer(child: FadeContainer(fadeAnimation: fadeAnimation))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller,
        builder: _buildAnimation,
      ),
    );
  }
}
