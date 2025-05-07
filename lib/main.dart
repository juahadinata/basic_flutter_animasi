import 'package:basic_flutter_animation/explicit_sampel/loading_animation.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Animation Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RadialProgressAnimation(progress: 0.85, color: Colors.blue),
      // home: const ListAnimation(),
      // home: const LoginScreenAnimation(),
      // home: const PulsatingCircleAnimation(),
      // home: const ShoppingCartButton(),
      // home: const AnimatedColorPalette(),
    );
  }
}
