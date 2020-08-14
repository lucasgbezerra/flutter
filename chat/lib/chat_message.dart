import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  ChatMessage(this.data, this.mine);

  final Map<String, dynamic> data;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          !mine ?
          Padding(
            padding: !mine ? EdgeInsets.only(right: 10.0) : EdgeInsets.only(left: 10.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(data["senderPhotoUrl"]),
            )
          ) : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment: !mine ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                data['imageUrl'] != null ?
                    Image.network(data['imageUrl'], width: 250,)
                    :
                    Text(data['text'], style: TextStyle(fontSize: 16.0),
                    textAlign: !mine ? TextAlign.start : TextAlign.end,),
                Text(data['senderName'],
                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500, color: Colors.black54),),
              ],
            ),
          ),
          mine ?
          Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(data["senderPhotoUrl"]),
              )
          ) : Container(),
        ],
      ),
    );
  }
}
