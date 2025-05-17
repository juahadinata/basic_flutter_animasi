import 'package:flutter/material.dart';

class PulsatingCircleAnimation extends StatelessWidget {
  const PulsatingCircleAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Pulsating Circle Animation'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 100),
                  duration: const Duration(seconds: 1),
                  builder: (context, size, widget) {
                    return Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.shade100.withOpacity(0.7),
                              blurRadius: size,
                              spreadRadius: size / 2,
                            )
                          ]),
                    );
                  }),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.1, end: 2.0),
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: const Icon(Icons.favorite, color: Colors.red, size: 48),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: TweenAnimationBuilder<Color?>(
                tween: ColorTween(begin: Colors.blue, end: Colors.green),
                duration: const Duration(seconds: 3),
                builder: (context, color, _) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}
