import 'package:flutter/material.dart';
import 'package:flutter_animations_2/screens/home/widgets/category_view.dart';

class HomeTop extends StatelessWidget {
  final Animation<double> containerGrow;
  const HomeTop({Key? key, required this.containerGrow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * 0.4,
      width: screenSize.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Welcome, Lucas!",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            Container(
              height: containerGrow.value * 120,
              width: containerGrow.value * 120,
              alignment: Alignment.topRight,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/profile.jpg'),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle),
              child: Container(
                height: containerGrow.value * 35,
                width: containerGrow.value * 35,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Text(
                  "2",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 15 * containerGrow.value
                  ),
                ),
              ),
            ),
            CategoryView()
          ],
        ),
      ),
    );
  }
}
