import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() async {
  runApp(const PersonalFinanceApp(
    title: 'Finances',
  ));
}

class PersonalFinanceApp extends StatelessWidget {
  const PersonalFinanceApp({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          color: Colors.green,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
