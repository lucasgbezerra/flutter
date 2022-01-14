import 'package:flutter/material.dart';

class StaggerAnimation extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> buttonSqueeze;
  final Animation<double> buttonZoomOut;

  StaggerAnimation({Key? key, required this.controller})
      : buttonSqueeze = Tween<double>(begin: 320.0, end: 60.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.15),
          ),
        ),
        buttonZoomOut = Tween<double>(begin: 60, end: 1000).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.5,
              1,
              curve: Curves.bounceOut,
            ),
          ),
        ),
        super(key: key);

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Hero(
        tag: "fadeOut",
        child: buttonZoomOut.value == 60
            ? TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 26, 26, 1.0),
                  minimumSize: Size(buttonSqueeze.value, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  controller.forward();
                },
                child: _buildChild(context),
              )
            : Container(
                height: buttonZoomOut.value,
                width: buttonZoomOut.value,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 26, 26, 1.0),
                  borderRadius: BorderRadius.circular(buttonZoomOut.value == 60
                      ? 30
                      : 30 - 3 * buttonZoomOut.value / 100),
                ),
              ),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    if (buttonSqueeze.value > 75) {
      return const Text(
        "Sign In",
        style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3),
      );
    } else {
      return const CircularProgressIndicator(
        strokeWidth: 1,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
