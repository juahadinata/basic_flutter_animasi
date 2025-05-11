Berikut adalah penjabaran dan penjelasan dari kode TweenSequenceModified, yang mendemonstrasikan animasi bergerak ke kanan lalu turun ke bawah menggunakan TweenSequence di Flutter:

- **🧱 Struktur Kelas**
    ```dart
    class TweenSequenceModified extends StatefulWidget
    ```
    - Kelas ini merupakan `StatefulWidget` karena memerlukan perubahan tampilan berdasarkan animasi.

    - State-nya adalah `_TweenSequenceModifiedState`.

- **🔄 Kelas State: _TweenSequenceModifiedState**
    ```dart
    with SingleTickerProviderStateMixin
    ```
    - Mixin ini digunakan agar `AnimationController` bisa mendapatkan sinkronisasi frame dari `vsync`.

- **🔧 Inisialisasi Animasi**
    ```dart
    late AnimationController _controller;
    late Animation<double> _leftAnimation;
    late Animation<double> _topAnimation;
    ```
    - `_controller`: Mengontrol waktu animasi.

    - `_leftAnimation`: Untuk posisi horizontal.

    - `_topAnimation`: Untuk posisi vertikal.

#### 🧠 `initState()`
- **🔁 Membuat AnimationController**
    ```dart
    _controller = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
    );
    ```
    - Durasi animasi adalah 4 detik.

    - `vsync`: this mengoptimalkan performa animasi.

- **👉 `TweenSequence` untuk Gerakan Horizontal**
    ```dart
      _leftAnimation = TweenSequence<double>([
    TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 150.0).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
    ),
    TweenSequenceItem(
        tween: ConstantTween(150.0), // tetap di 150
        weight: 2,
    ),
    ]).animate(_controller);
    ```
    - Total durasi dibagi menjadi 3 bagian (berdasarkan weight 1:2).

    - Tahap 1 (1/3 durasi): Bergerak dari kiri ke kanan (0 → 150), melengkung dengan `easeInOut`.

    - Tahap 2 (2/3 durasi): Diam di posisi horizontal 150.0.

- **👇 TweenSequence untuk Gerakan Vertikal**
    ```dart
    _topAnimation = TweenSequence<double>([
    TweenSequenceItem(
        tween: ConstantTween(100.0), // tetap di 100
        weight: 1,
    ),
    TweenSequenceItem(
        tween: Tween(begin: 100.0, end: 300.0).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2,
    ),
    ]).animate(_controller);
    ```
    - Tahap 1 (1/3 durasi): Posisi vertikal tetap di 100.

    - Tahap 2 (2/3 durasi): Bergerak turun ke 300 dengan animasi melengkung.

- **🔁 Ulangi animasi secara bolak-balik**
    ```dart
    _controller.repeat(reverse: true);
    ```
    Setelah selesai satu siklus (maju), animasi akan kembali ke posisi semula (mundur).

- **🧹 dispose()**
    ```dart
    _controller.dispose();
    ```
    Penting untuk menghentikan animasi dan menghindari memory leak saat widget dihapus dari tree.

- **🧱 build()**
    ```dart
    return Scaffold(
    appBar: AppBar(title: Text('Kotak Bergerak & Turun')),
    body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
        return Stack(
            children: [
            Positioned(
                left: _leftAnimation.value,
                top: _topAnimation.value,
                child: Container(
                width: 50,
                height: 50,
                color: Colors.green,
                ),
            ),
            ],
        );
        },
    ),
    );
    ```
    - `AnimatedBuilder`: Memastikan UI diperbarui setiap kali nilai animasi berubah.

    - `Stack` dan `Positioned` digunakan untuk memanipulasi posisi Container.

    - Posisi `left` dan `top` diatur berdasarkan nilai animasi.

- **📌 Ringkasan Alur Animasi**
    - Durasi total: 4 detik.

    - Detik 0–1.33: kotak bergerak ke kanan.

    - Detik 1.33–4: kotak turun ke bawah.

    - Lalu animasi dibalik (kotak kembali ke posisi awal), dan berulang terus.

#### Kode Lengkap

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
      home: const TweenSequenceModified(),

    );
  }
}

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

```