import 'package:chat_app/chatList.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp( myId:"nFGKPmMDha4Blcux3YNr"));
}

class MyApp extends StatelessWidget {
  final String? myId;
  const MyApp({Key? key, required this.myId}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home:  ChatList(myId: myId),
    );
  }
}