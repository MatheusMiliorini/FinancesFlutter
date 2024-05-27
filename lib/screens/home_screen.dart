import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Finance Control'),
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
