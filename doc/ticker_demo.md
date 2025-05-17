#### Contoh Kode yang menunjukkan bagaimana Ticker bekerja secara eksplisit tanpa AnimationController, untuk memperjelas konsep frame-by-frame-nya 

```dart
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
    );
  }
} 
```

#### 🎯 Tujuan:
Menunjukkan cara kerja Ticker secara eksplisit, tanpa bantuan AnimationController.

#### 🧠 Konsep Singkat:
`Ticker` itu seperti jam detak internal, yang:
    - Memanggil callback sekali setiap frame (biasanya 60fps = 16.6ms/frame)
    - Memberikan informasi elapsed time sejak start
    - Harus di-dispose secara manual

#### 🔍 Apa yang Terjadi?
- `Ticker` dipanggil terus setiap frame.

- `elapsed` menunjukkan waktu sejak `_ticker.start()` dipanggil.

- Ukuran kotak (`_boxSize`) berubah mengikuti waktu → animasi manual!

#### ⚠️ Kelemahan Pendekatan Ini:
- Semua logika kita tangani sendiri.

- Harus ingat `dispose()`, atau `Ticker` akan bocor (leak).

- Tidak ada `curve`, `repeat`, `reverse`, dll → semua manual.

##### 🎯 Intinya:
- `AnimationController` = pembungkus `Ticker` + logika interpolasi (`Tween`, `status`, `reverse`, `repeat`, dll).

- Dengan memahami `Ticker` membantu kita mengerti dasar cara kerja Flutter animation engine.

