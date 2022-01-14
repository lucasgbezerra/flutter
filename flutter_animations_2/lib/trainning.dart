// import 'package:flutter/animation.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Animations 2',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const LogoAPP(),
//     );
//   }
// }

// class LogoAPP extends StatefulWidget {
//   const LogoAPP({Key? key}) : super(key: key);

//   @override
//   State<LogoAPP> createState() => _LogoAPPState();
// }

// class _LogoAPPState extends State<LogoAPP> with TickerProviderStateMixin {
//   late AnimationController controller;
//   late Animation<double> animation;

//   @override
//   void initState() {
//     super.initState();
//     controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );

//     // animation = Tween<double>(begin: 0, end: 300).animate(controller)
//     // ..addListener(() {
//     //   setState(() {});
//     // })..addStatusListener((status) {

//     // Animação cresce e diminui de acordo com o status identificado
//     // animation = Tween<double>(begin: 0, end: 300).animate(controller)
//     //   ..addStatusListener((status) {
//     //     if (status == AnimationStatus.completed)
//     //       controller.reverse();
//     //     else if (status == AnimationStatus.dismissed) controller.forward();
//     //   });

//     //Curved Animation
//     animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
//     animation.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         controller.reverse();
//       } else if (status == AnimationStatus.dismissed) {
//         controller.forward();
//       }
//     });
  
//     controller.forward();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GrowAndOpacityTransition(
//       animation: animation,
//       child: const LogoWidget(),
//     );
//   }
// }

// // class AnimatedLogo extends AnimatedWidget {
// //   final Animation<double> animation;

// //   const AnimatedLogo(this.animation, {Key? key})
// //       : super(key: key, listenable: animation);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Container(
// //         height: animation.value,
// //         width: animation.value,
// //         child: FlutterLogo(),
// //       ),
// //     );
// //   }
// // }

// class LogoWidget extends StatelessWidget {
//   const LogoWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: const FlutterLogo(),
//     );
//   }
// }

// class GrowAndOpacityTransition extends StatelessWidget {
//   final Animation<double> animation;
//   final Widget child;
//   final sizeTween = Tween<double>(begin: 0, end: 200);
//   final opacityTween = Tween<double>(begin: 0.1, end: 1);

//   GrowAndOpacityTransition(
//       {Key? key, required this.animation, required this.child})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: AnimatedBuilder(
//         animation: animation,
//         child: child,
//         builder: (context, child) {
//           return Opacity(
//             opacity: opacityTween.evaluate(animation),
//             child: Container(
//               height: sizeTween.evaluate(animation),
//               width: sizeTween.evaluate(animation),
//               child: child,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
