import 'dart:math' as math;

import 'package:flutter/material.dart';

const int maxSeeds = 250;

class Sunflower extends StatefulWidget {
  const Sunflower({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SunflowerState();
  }
}

class _SunflowerState extends State<Sunflower> {
  int seeds = maxSeeds ~/ 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(title: const Text('Sunflower')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: SunflowerWidget(seeds)),
            const SizedBox(height: 20),
            Text(
              'Showing ${seeds.round()} seeds',
              style: const TextStyle(color: Colors.amber),
            ),
            SizedBox(
              width: 300,
              child: Slider(
                min: 1,
                max: maxSeeds.toDouble(),
                value: seeds.toDouble(),
                onChanged: (val) {
                  setState(() => seeds = val.round());
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SunflowerWidget extends StatelessWidget {
  static const tau = math.pi * 2;
  static const scaleFactor = 1 / 40;
  static const size = 600.0;
  static final phi = (math.sqrt(5) + 1) / 2;
  static final rng = math.Random();

  final int seeds;

  const SunflowerWidget(this.seeds, {super.key});

  @override
  Widget build(BuildContext context) {
    final seedWidgets = <Widget>[];

    for (var i = 0; i < seeds; i++) {
      final theta = i * tau / phi;
      final r = math.sqrt(i) * scaleFactor;
      //
      final x = r * math.cos(theta);
      final y = -1 * r * math.sin(theta);

      seedWidgets.add(
        AnimatedAlign(
          key: ValueKey(i),
          duration: Duration(milliseconds: rng.nextInt(500) + 250),
          curve: Curves.easeInOut,
          alignment: Alignment(x, y),
          child: const Dot(true),
        ),
      );
    }

    for (var j = seeds; j < maxSeeds; j++) {
      final x = math.cos(tau * j / (maxSeeds - 1)) * 0.9;
      final y = math.sin(tau * j / (maxSeeds - 1)) * 0.9;

      seedWidgets.add(
        AnimatedAlign(
          key: ValueKey(j),
          duration: Duration(milliseconds: rng.nextInt(500) + 250),
          curve: Curves.easeInOut,
          alignment: Alignment(x, y),
          child: const Dot(false),
        ),
      );
    }

    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
        height: size,
        width: size,
        child: Stack(children: seedWidgets),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  static const size = 8.0;
  static const radius = 4.0;

  final bool lit;

  const Dot(this.lit, {super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: lit ? Colors.orange : Colors.grey.shade700,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: const SizedBox(height: size, width: size),
    );
  }
}
