import 'package:flutter/material.dart';

class FadeRouteSampel extends StatelessWidget {
  const FadeRouteSampel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MyFadeRoute(
                page: const DetailPage(),
                arguments: 'Hello from HomePage!',
              ),
            );
          },
          child: const Text('Go to Detail Page'),
        ),
      ),
    );
  }
}

// Custom Route dengan Fade Transition dan arguments
class MyFadeRoute extends PageRouteBuilder {
  final Widget page;
  final Object? arguments;

  MyFadeRoute({required this.page, this.arguments})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          settings: RouteSettings(arguments: arguments),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil arguments dari route yang dikirim
    final args = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Page')),
      body: Center(
        child: Text(
          args ?? 'No message received',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
