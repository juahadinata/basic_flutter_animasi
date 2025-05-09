import 'package:flutter/material.dart';

class SplashAnimation extends StatefulWidget {
  const SplashAnimation({super.key});

  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Inisialisasi controller
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Inisialisasi animasi skala
    scaleAnimation = Tween<double>(begin: 1.0, end: 4.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    // Dengarkan status animasi
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).push(
          MyCustomRouteTransition(route: const Destination()),
        );
        controller.reset(); // Reset agar bisa diputar ulang
      }
    });
  }

  @override
  void dispose() {
    controller.dispose(); // Penting untuk menghindari memory leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => controller.forward(),
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Halaman tujuan setelah animasi selesai
class Destination extends StatelessWidget {
  const Destination({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Go Back'),
      ),
      body: const Center(
        child: Text(
          'Welcome to Destination!',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

// Kelas transisi kustom dengan efek SlideTransition dari atas
class MyCustomRouteTransition extends PageRouteBuilder {
  final Widget route;

  MyCustomRouteTransition({required this.route})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => route,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            );
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
}
