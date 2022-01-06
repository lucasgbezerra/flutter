import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot snapshot;
  const PlaceTile(this.snapshot, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100.0,
            child: Image.network(snapshot.get('image'), fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                snapshot.get('title'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Text(
                snapshot.get('address'),
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[600],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      launch(
                          "https://www.google.com/maps/search/?api=1&query=${snapshot.get('latitude')},${snapshot.get('longitude')}");
                    },
                    child: Text(
                      "Location",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      enableFeedback: false,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      launch("tel:${snapshot.get('phone')}");
                    },
                    child: Text(
                      "Call",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      enableFeedback: false,
                    ),
                  ),
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }
}
