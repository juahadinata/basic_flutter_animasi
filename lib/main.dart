import 'package:basic_flutter_animation/explicit_sampel/loading_animation.dart';
import 'package:basic_flutter_animation/modal_route/fade_route_sampel.dart';
import 'package:basic_flutter_animation/pageroute_builder_anim/splash_anim.dart';
import 'package:basic_flutter_animation/sunflower/sunflower_anim.dart';
import 'package:basic_flutter_animation/ticker_tanpa_animationcontroller/ticker_demo.dart';

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
      home: const Sunflower(),
      // home: const FadeRouteSampel(),
      // home: const SplashAnimation(),
      // home: const TickerDemo(),
      // home: const RadialProgressAnimation(progress: 0.85, color: Colors.blue),
      // home: const ListAnimation(),
      // home: const LoginScreenAnimation(),
      // home: const PulsatingCircleAnimation(),
      // home: const ShoppingCartButton(),
      // home: const AnimatedColorPalette(),
    );
  }
}
