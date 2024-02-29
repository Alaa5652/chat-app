import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'constans.dart';
class MessageReceived extends StatelessWidget {
  const MessageReceived({
    super.key,
    required this.message,
  });
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration:  const BoxDecoration(
            color: kMaincolor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        margin: const EdgeInsets.only(right: 50, top:15, left: 10),
        padding: EdgeInsets.all(13),
        child:  Text(
          message.text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
class MessageSended extends StatelessWidget {
  const MessageSended({
    super.key,
    required this.message,
  });
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration:  const BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        margin: const EdgeInsets.only(left: 50, top:15, right: 10),
        padding: EdgeInsets.all(13),
        child:  Column(
          children: [
            Text(
              message.text,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              formatDateTime(message.time),
              style: TextStyle(fontSize: 12.0, color: Colors.grey),

            ),
          ],
        ),
      ),
    );
  }
}
String formatDateTime(DateTime dateTime) {
  return DateFormat('dd/MM/yyyy hh:mm a').format(dateTime);
}
