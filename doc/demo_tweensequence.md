### TweenSequence

`TweenSequence` di Flutter adalah cara untuk menyusun beberapa tween (animasi transisi nilai) secara berurutan dalam satu animasi. Ini sangat berguna ketika kamu ingin membuat animasi kompleks yang berubah-ubah nilainya dalam beberapa tahap, misalnya bergerak dari 0 ke 50, lalu ke 100, masing-masing dengan durasi atau kecepatan berbeda.

- **📌 Struktur Dasar `TweenSequence`**
```dart
TweenSequence<double>([
  TweenSequenceItem(
    tween: Tween(begin: 0.0, end: 50.0),
    weight: 1,
  ),
  TweenSequenceItem(
    tween: Tween(begin: 50.0, end: 100.0),
    weight: 2,
  ),
])
```

- **📘 Penjelasan Properti:**
    - TweenSequenceItem: Bagian dari TweenSequence. Kamu menyusun beberapa item ini.

        - tween: Tween yang mendefinisikan perubahan nilai.

        - weight: Bobot durasi relatif. Semakin besar nilainya, semakin lama durasi relatif dari bagian tersebut terhadap total animasi.

    - TweenSequence: Mengatur transisi nilai antar TweenSequenceItem secara berurutan dan proporsional terhadap total durasi animasi.

- **🛠 Contoh Penggunaan**
    Misalnya kamu ingin membuat animasi yang bergerak dari 0 ke 100 dengan perubahan bertahap:
    ```dart
    Animation<double> animation = TweenSequence([
    TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 50.0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 1,
    ),
    TweenSequenceItem(
        tween: Tween(begin: 50.0, end: 100.0).chain(CurveTween(curve: Curves.easeOut)),
        weight: 2,
    ),
    ]).animate(animationController);
    ```
    Di sini,:

    - Nilai pertama (0→50) akan terjadi selama 1/3 durasi total (weight: 1)

    - Nilai kedua (50→100) akan memakan 2/3 durasi total (weight: 2) 

- **🎯 Kapan digunakan?**
    Gunakan TweenSequence jika kamu:

    - Ingin membuat animasi multi-tahapan

    - Ingin mengontrol durasi relatif tiap tahap

    - Ingin menerapkan curve yang berbeda di tiap bagian

- **Kode Lengkap**
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Animation Flutter',
      debugShowCheckedModeBanner: false,
      home: const DemoTweenSequence(),

    );
  }
}

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

  void playAnimation() {
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
        onPressed: playAnimation,
        child: isOn ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
      ),
    );
  }
}

```

- **🔍 Apa yang Terjadi?**
    - Kotak biru akan bergerak dari left = 0 → 150 (dengan easeIn) lalu 150 → 300 (dengan easeOut)

    - weight 1 dan 2 membuat durasinya masing-masing 1/3 dan 2/3 dari total 4 detik

    - Animasi akan mengulang bolak-balik (reverse: true)