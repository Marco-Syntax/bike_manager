import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/views/home_view.dart';

void main() {
  runApp(const ProviderScope(child: BikeManagerApp()));
}

class BikeManagerApp extends StatelessWidget {
  const BikeManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bike Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomeView(),
    );
  }
}
 
