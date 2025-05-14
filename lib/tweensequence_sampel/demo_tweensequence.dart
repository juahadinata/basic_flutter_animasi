import 'package:flutter/material.dart';

class DemoTweenSequence extends StatefulWidget {
  const DemoTweenSequence({super.key});

  @override
  State<DemoTweenSequence> createState() => _DemoTweenSequenceState();
}

class _DemoTweenSequenceState extends State<DemoTweenSequence>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isOn = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    _animation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: 150.0)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: 150.0, end: 300.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 2),
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
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TweenSequence Demo')),
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned(
                top: 100,
                left: _animation.value,
                child: Container(
                  width: 75,
                  height: 75,
                  color: Colors.blue,
                ),
              )
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
