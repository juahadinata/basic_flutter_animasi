import 'package:flutter/material.dart';

class HybridColumnAnimation extends StatefulWidget {
  const HybridColumnAnimation({super.key});

  @override
  State<HybridColumnAnimation> createState() => _HybridColumnAnimationState();
}

class _HybridColumnAnimationState extends State<HybridColumnAnimation>
    with SingleTickerProviderStateMixin {
  ///? property
  late AnimationController _controller;
  late Animation<Offset> _columnSlideAnimation;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  final int _childCount = 4;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Animasi masuk Column (geser dari bawah)
    _columnSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Animasi anak-anak (Fade dan Slide satu per satu)
    _fadeAnimations = List.generate(_childCount, (i) {
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3 + i * 0.15, 1.0, curve: Curves.easeIn),
      );
    });

    _slideAnimations = List.generate(_childCount, (i) {
      return Tween<Offset>(
        begin: const Offset(0, 0.2),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3 + i * 0.15, 1.0, curve: Curves.easeOut),
      ));
    });

    _controller.forward(); // Jalankan animasi
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedChild(int index, Widget child) {
    return FadeTransition(
      opacity: _fadeAnimations[index],
      child: SlideTransition(
        position: _slideAnimations[index],
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hybrid Column Animation")),
      body: Center(
        child: SlideTransition(
          position: _columnSlideAnimation,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            color: Colors.grey.shade300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildAnimatedChild(
                    0, const Text("Judul", style: TextStyle(fontSize: 24))),
                const SizedBox(height: 12),
                _buildAnimatedChild(
                    1,
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: Colors.orange),
                        SizedBox(width: 4),
                        Text("Rating 4.5"),
                      ],
                    )),
                const SizedBox(height: 12),
                _buildAnimatedChild(
                    2,
                    Container(
                      width: 150,
                      height: 50,
                      color: Colors.teal,
                      alignment: Alignment.center,
                      child: const Text("Kotak Konten",
                          style: TextStyle(color: Colors.white)),
                    )),
                const SizedBox(height: 12),
                _buildAnimatedChild(
                    3,
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Tombol Aksi"),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
