import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final List<String> categories = [
    "Jobs",
    "Studies",
    "HomeWork",
  ];

  int _actualCategory = 0;

  void selectForward(){
    setState(() {
      _actualCategory++;
    });
  }


  void selectBack(){
    setState(() {
      _actualCategory--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color:  _actualCategory > 0 ?  Colors.white : Colors.white24,
            ),
            onPressed: _actualCategory > 0 ?  selectBack : null,
          ),
          Text(
            categories[_actualCategory].toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: _actualCategory < categories.length - 1 ?  Colors.white : Colors.white24,
            ),
            onPressed: _actualCategory < categories.length - 1 ?  selectForward : null,
          ),
        ],
      ),
    );
  }
}
