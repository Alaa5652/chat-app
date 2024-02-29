import 'package:chat_app/constans/constans.dart';

class MessageModel {
  final String text;
  final String useremail;
  final DateTime time;
  MessageModel(this.text, this.useremail, this.time);
  factory MessageModel.fromJson(jsonData) {
    return MessageModel(jsonData[kMessagecollection], jsonData[kUseremail],
    DateTime.parse(jsonData[kcreatesdAt]));
  }
}
