import 'package:flutter/material.dart';

class TweenSequenceModified extends StatefulWidget {
  const TweenSequenceModified({super.key});

  @override
  State<TweenSequenceModified> createState() => _TweenSequenceModifiedState();
}

class _TweenSequenceModifiedState extends State<TweenSequenceModified>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _leftAnimation;
  late Animation<double> _topAnimation;
  bool isOn = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Animasi horizontal: 0 → 150 lalu tetap
    _leftAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 150.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ConstantTween(150.0), // tetap di 150
        weight: 2,
      ),
    ]).animate(_controller);

    // Animasi vertikal: tetap 100 → turun ke 300
    _topAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: ConstantTween(100.0), // tetap di 100
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 100.0, end: 300.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playAnimation() {
    setState(() {
      isOn = !isOn;
    });
    if (isOn) {
      _controller.repeat(reverse: true); // animasi bolak-balik
    } else {
      _controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TweenSequence with ConstantTween')),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned(
                left: _leftAnimation.value,
                top: _topAnimation.value,
                child: Container(
                  width: 75,
                  height: 75,
                  color: Colors.green,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _playAnimation,
        child: isOn ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
      ),
    );
  }
}
