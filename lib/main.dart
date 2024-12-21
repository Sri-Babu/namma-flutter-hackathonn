import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/chat_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namma AI',
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        ChatScreen.routeName: (context) => const ChatScreen()
      },
    );
  }
}
