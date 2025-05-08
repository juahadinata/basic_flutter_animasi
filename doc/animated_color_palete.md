#### Deskripsi Kode
Aplikasi ini terdiri dari sebuah widget utama bernama ```AnimatedColorPalette```, yang menampilkan lima kotak warna (color blocks) yang dapat berubah secara animatif setiap kali tombol ditekan. Fungsionalitas utamanya adalah:

- Menghasilkan 5 warna secara acak.

- Menampilkan warna dalam AnimatedContainer.

- Memberikan transisi animasi ketika warna diperbarui.

- Memungkinkan pengguna menghasilkan warna baru dengan satu tombol.

#### Penjelasan Kode
- Struktur Utama
    ```class AnimatedColorPalette extends StatefulWidget```
    
    Widget ini menggunakan ```StatefulWidget``` karena perlu memperbarui tampilan saat pengguna menghasilkan warna baru.

- Palet Warna Acak

    ```static List<Color> generateRandomPalette()```
    Fungsi ini menggunakan ```dart:math``` untuk menghasilkan lima objek Color dengan nilai RGB acak, dan nilai alpha konstan 1 (100% opasitas).

- Widget **AnimatedContainer**
       ```AnimatedContainer(duration: const Duration(microseconds: 500),...)```

    Setiap Color ditampilkan dalam kotak persegi dengan animasi transisi saat warnanya berubah. Penggunaan AnimatedContainer memberikan efek visual halus tanpa harus menulis kode animasi manual.

- Interaksi Pengguna
        ```ElevatedButton(onPressed: regeneratePalette,child: const Text('Generate New Palette'), ...)```
    Tombol ini memanggil ```regeneratePalette()``` yang melakukan ```setState``` untuk memperbarui UI dengan warna-warna baru.

#### Kelebihan Implementasi
- Interaktif dan Dinamis: Memberikan pengalaman pengguna yang menyenangkan melalui efek animasi.

- Koding Modular: Fungsi generateRandomPalette() terpisah, memudahkan pengelolaan logika.

- Responsif: Tampilan bisa diperluas dengan mudah untuk menyesuaikan berbagai ukuran layar.

#### Potensi Pengembangan
- Menambahkan label kode warna (hex).

- Menyimpan palet yang disukai.

- Mengubah jumlah warna yang dihasilkan.

- Ekspor palet ke format digital (misalnya JSON atau PNG).

#### Kode Lengkap
```dart
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedColorPalette extends StatefulWidget {
  const AnimatedColorPalette({super.key});

  @override
  State<AnimatedColorPalette> createState() => _AnimatedColorPaletteState();
}

class _AnimatedColorPaletteState extends State<AnimatedColorPalette> {
  List<Color> currentPalette = generateRandomPalette();

  static List<Color> generateRandomPalette() {
    final random = Random();
    return List.generate(
        5,
        (_) => Color.fromRGBO(
              random.nextInt(256),
              random.nextInt(256),
              random.nextInt(256),
              1,
            ));
  }

  void regeneratePalette() {
    setState(() {
      currentPalette = generateRandomPalette();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Palette Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (Color color in currentPalette)
              AnimatedContainer(
                duration: const Duration(microseconds: 500),
                width: 100,
                height: 100,
                color: color,
                margin: const EdgeInsets.all(8),
              ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: regeneratePalette,
                child: const Text('Generate New Palette'))
          ],
        ),
      ),
    );
  }
}

```