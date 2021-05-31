import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final bool belongsToMe;
  final String message;
  final String name;
  final String urlImage;
  final Key key;

  const Message(
      {this.message,
      this.name,
      this.belongsToMe = false,
      this.key,
      this.urlImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          this.belongsToMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: this.belongsToMe
                    ? Theme.of(context).accentColor
                    : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: this.belongsToMe
                      ? Radius.circular(10)
                      : Radius.circular(0),
                  bottomRight: this.belongsToMe
                      ? Radius.circular(0)
                      : Radius.circular(10),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 8),
                  textAlign: TextAlign.start,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        child: this.urlImage != null
                            ? null
                            : Icon(Icons.photo_size_select_actual_outlined),
                        backgroundImage: this.urlImage != null
                            ? NetworkImage(this.urlImage)
                            : null,
                      ),
                    ),
                    Text(message),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
