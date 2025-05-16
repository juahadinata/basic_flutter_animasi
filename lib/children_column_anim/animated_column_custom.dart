import 'package:flutter/material.dart';

class AnimatedColumnCustom extends StatefulWidget {
  const AnimatedColumnCustom({super.key});

  @override
  State<AnimatedColumnCustom> createState() => _AnimatedColumnCustomState();
}

class _AnimatedColumnCustomState extends State<AnimatedColumnCustom>
    with SingleTickerProviderStateMixin {
  ///? Property
  late AnimationController _controller;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  final int itemCount = 4;

  ///? InitState
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimations = List.generate(itemCount, (index) {
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(index * 0.15, 1.0, curve: Curves.easeIn),
      );
    });

    _slideAnimations = List.generate(itemCount, (index) {
      return Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.15, 1.0, curve: Curves.easeOut),
        ),
      );
    });

    _controller.forward();
  }

  ///? dispose
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///? Method Animasi pembungkus
  Widget _wrapAnimated(int index, Widget child) {
    return FadeTransition(
      opacity: _fadeAnimations[index],
      child: SlideTransition(
        position: _slideAnimations[index],
        child: child,
      ),
    );
  }

  ///? build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          _wrapAnimated(
            0,
            const Text(
              'Judul',
              style: TextStyle(fontSize: 24),
            ),
          ),
          _wrapAnimated(
            1,
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.orange),
                SizedBox(
                  width: 8,
                ),
                Text('Rating 5'),
              ],
            ),
          ),
          _wrapAnimated(
            2,
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: Container(
                height: 80,
                color: Colors.teal,
              ),
            ),
          ),
          _wrapAnimated(
            3,
            ElevatedButton(
              onPressed: () {},
              child: const Text('Klik Saya'),
            ),
          ),
        ],
      ),
    );
  }
}
