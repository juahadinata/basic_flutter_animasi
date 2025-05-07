import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedColorPalette extends StatefulWidget {
  const AnimatedColorPalette({super.key});

  @override
  State<AnimatedColorPalette> createState() => _AnimatedColorPaletteState();
}

class _AnimatedColorPaletteState extends State<AnimatedColorPalette> {
  List<Color> currentPalette = generateRandomPalette();

  static List<Color> generateRandomPalette() {
    final random = Random();
    return List.generate(
        5,
        (_) => Color.fromRGBO(
              random.nextInt(256),
              random.nextInt(256),
              random.nextInt(256),
              1,
            ));
  }

  void regeneratePalette() {
    setState(() {
      currentPalette = generateRandomPalette();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Palette Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (Color color in currentPalette)
              AnimatedContainer(
                duration: const Duration(microseconds: 500),
                width: 100,
                height: 100,
                color: color,
                margin: const EdgeInsets.all(8),
              ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: regeneratePalette,
                child: const Text('Generate New Palette'))
          ],
        ),
      ),
    );
  }
}
