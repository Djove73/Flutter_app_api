import 'package:flutter/material.dart';
import 'views/game_items_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Free Games App',
      home: const GameItemsView(),
    );
  }
}
