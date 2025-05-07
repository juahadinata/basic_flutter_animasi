import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // penting untuk Ticker

class TickerDemo extends StatefulWidget {
  const TickerDemo({super.key});

  @override
  State<TickerDemo> createState() => _TickerDemoState();
}

class _TickerDemoState extends State<TickerDemo>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  double _boxSize = 100.0;
  Duration _elapsed = Duration.zero;
  bool isOn = false;

  @override
  void initState() {
    super.initState();
    _ticker = Ticker((elapsed) {
      setState(() {
        _elapsed = elapsed;
        _boxSize =
            100 + (elapsed.inMilliseconds / 10) % 100; // animasi naik turun
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticker tanpa AnimationController'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: _boxSize,
              height: _boxSize,
              color: Colors.teal,
            ),
            const SizedBox(height: 20),
            Text('Elepasi waktu: ${_elapsed.inMilliseconds} ms')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isOn = !isOn;
          });
          if (_ticker.isTicking) {
            _ticker.stop();
          } else {
            _ticker.start();
          }
        },
        child: Icon(isOn ? Icons.play_arrow : Icons.pause),
      ),
    );
  }
}
