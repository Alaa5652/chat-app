import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
const kMaincolor = Color(0xff274460);
const String kLogo = 'assets/images/scholar.png';
const String kMessagecollection = 'message';
const String kcreatesdAt = 'createdAt';
const String kUseremail = 'useremail';
Map<String, WidgetBuilder> screens = {
  LoginScreen.id: (context) => LoginScreen(),
  SingInScreen.id: (context) => SingInScreen(),
  ChatScreen.id: (context) => ChatScreen(),
};
