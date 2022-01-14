import 'package:flutter/material.dart';

class ListData extends StatelessWidget {
  final String title;
  final String subTitle;
  final ImageProvider image;
  final EdgeInsets margin;
  const ListData(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.image,
      required this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey, width: 1.0),
              top: BorderSide(color: Colors.grey, width: 1.0))),
      margin: margin,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Text(
                subTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
