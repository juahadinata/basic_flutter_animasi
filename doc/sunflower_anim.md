#### Penjelasan Code ```sunflower_anim.dart```
Berikut adalah penjelasan baris demi baris dan per bagian dari kode Flutter di atas, yang membentuk tampilan visual pola bunga matahari (sunflower pattern) berbasis *matematika phyllotaxis*. Mari kita bedah satu per satu:

```dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
```
- ```dart:math```: Mengimpor pustaka matematika, digunakan untuk ```pi, sqrt, cos, sin, Random```, dll.
- ```as math```: Supaya bisa dipanggil seperti ```math.pi, math.cos```, dll. (mencegah konflik nama).
```dart
const int maxSeeds = 250;
```
- Menetapkan jumlah maksimum biji atau titik bunga matahari yang akan ditampilkan.
```dart
class Sunflower extends StatefulWidget {
  const Sunflower({super.key});
```
- StatefulWidget: Karena kita ingin interaktivitas (slider mengubah jumlah biji).

```dart
class _SunflowerState extends State<Sunflower> {
  int seeds = maxSeeds ~/ 2;
```
- Menyimpan jumlah biji (```seeds```), diinisialisasi setengah dari ```maxSeeds``` (```~/``` artinya pembagian bulat).

```dart
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
```
- ```Center``` : Menempatkan Column di tengah layar
```dart
            Expanded(child: SunflowerWidget(seeds)),
```
- ```Expanded```: Widget utama yang menampilkan biji-biji bunga (```SunflowerWidget```) disebarkan mengisi ruang.
```dart
            const SizedBox(height: 20),
            Text('Showing ${seeds.round()} seeds'),
```
- Berikan jarak 20px, terhadap ```Text``` yang menampilkan jumlah biji.
```dart
            SizedBox(
              width: 300,
              child: Slider(
                min: 1,
                max: maxSeeds.toDouble(),
                value: seeds.toDouble(),
                onChanged: (val) {
                  setState(() => seeds = val.round());
                },
              ),
            ),
```
- ```Slider```: Mengatur jumlah biji. Nilai diubah dengan ```setState``` supaya UI diperbarui.
#### 🌻 Widget SunflowerWidget (gambar utama)

```dart
class SunflowerWidget extends StatelessWidget {
```
- Widget statis untuk menggambar biji bunga

```dart
  static const tau = math.pi * 2;
  static const scaleFactor = 1 / 40;
  static const size = 600.0;
```
- ```tau```: 2π (satu lingkaran penuh dalam radian).
- ```scaleFactor```: Mengontrol jarak antar biji.
- ```size```: Ukuran area gambar.

```dart
  static final phi = (math.sqrt(5) + 1) / 2;
```
- ```phi```: Rasio emas (golden ratio), digunakan untuk menyebarkan biji dengan estetika alami.

```dart
  static final rng = math.Random();
```
- Generator angka acak untuk variasi animasi.

```dart
  final int seeds;

  const SunflowerWidget(this.seeds, {super.key});
```
- Menyimpan jumlah biji yang ingin di gambar

```dart
  @override
  Widget build(BuildContext context) {
    final seedWidgets = <Widget>[];
```
- Menyimpan semua titik biji dalam list widget

##### 🌼 Loop untuk biji aktif (```Dot(true)```)
```dart
    for (var i = 0; i < seeds; i++) {
      final theta = i * tau / phi;
      final r = math.sqrt(i) * scaleFactor;
```
- Menghitung posisi polar:
    - ```theta```: Sudut berdasarkan rumus phyllotaxis.
    - ```r```: Jarak dari pusat, pakai akar kuadrat agar jarak antar titik alami.

```dart

      seedWidgets.add(
        AnimatedAlign(
          key: ValueKey(i),
          duration: Duration(milliseconds: rng.nextInt(500) + 250),
          curve: Curves.easeInOut,
          alignment: Alignment(r * math.cos(theta), -1 * r * math.sin(theta)),
          child: const Dot(true),
        ),
      );
```
- Membuat titik ```Dot(true)``` (berwarna oranye).
- ```AnimatedAlign```: Memberi animasi posisi.
- ```alignment```: Mengonversi polar (r, θ) ke koordinat Cartesian (x, y).
##### 🌑 Loop untuk biji yang tidak digunakan (```Dot(false)```)
```dart
    for (var j = seeds; j < maxSeeds; j++) {
      final x = math.cos(tau * j / (maxSeeds - 1)) * 0.9;
      final y = math.sin(tau * j / (maxSeeds - 1)) * 0.9;
```
- Untuk sisa biji yang tidak aktif, diletakkan melingkar di pinggir (* 0.9 agar tidak keluar layar).

```dart

      seedWidgets.add(
        AnimatedAlign(
          key: ValueKey(j),
          duration: Duration(milliseconds: rng.nextInt(500) + 250),
          curve: Curves.easeInOut,
          alignment: Alignment(x, y),
          child: const Dot(false),
        ),
      );
```
- Menambahkan Dot(false) (abu-abu) dengan animasi yang sama.
##### 🎯 Hasil Ditampilkan di ```Stack``` dalam ```SizedBox``` dan ```FittedBox```
```dart
    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
        height: size,
        width: size,
        child: Stack(children: seedWidgets),
      ),
    );
  }
}
```
- FittedBox: Supaya area menggambar bisa menyesuaikan ukuran layar.
- SizedBox: Ukuran kanvas tetap 600x600.
- Stack: Menumpuk semua Dot di atas satu sama lain sesuai alignment.

##### ⚫ Widget Dot

```dart
class Dot extends StatelessWidget {
  static const size = 5.0;
  static const radius = 3.0;

  final bool lit;

  const Dot(this.lit, {super.key});
```
- ```lit```: Menentukan apakah titik ini aktif (oranye) atau tidak (abu-abu).

```dart
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: lit ? Colors.orange : Colors.grey.shade700,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: const SizedBox(height: size, width: size),
    );
  }
}
```
- Dot divisualisasikan sebagai kotak kecil berwarna, dengan sudut membulat.

##### ✅ Kesimpulan
* Kode ini:
    - Menampilkan visualisasi pola bunga matahari berdasarkan phyllotaxis.
    - Jumlah biji bisa diubah dengan slider.
    - Menggunakan animasi AnimatedAlign agar transisinya halus.
    - Membedakan antara biji aktif (Dot(true)) dan biji tidak aktif (Dot(false)).

##### Keterangan Tambahan 
**Susunan spiral dalam pola bunga matahari ini dibentuk oleh baris berikut di dalam loop pertama pada SunflowerWidget:**
```dart
final theta = i * tau / phi;
final r = math.sqrt(i) * scaleFactor;
```
Kemudian posisi titik (Dot) ditentukan oleh:
```dart
alignment: Alignment(r * math.cos(theta), -1 * r * math.sin(theta)),
```
📌 Penjelasan Detail:
1. theta = i * tau / phi

    - theta adalah sudut (dalam radian) untuk titik ke-i.

    - phi adalah rasio emas (≈ 1.618).

    - Membagi lingkaran (tau = 2π) dengan rasio emas menghasilkan pola spiral alami, dikenal sebagai golden angle.

    - Ini yang menciptakan susunan spiral unik dan seimbang, karena jarak sudut antar biji selalu konstan tapi tidak pernah sejajar (tidak tumpang tindih).

2. r = sqrt(i) * scaleFactor

    - r adalah jarak dari pusat ke biji ke-i.

    - Fungsi akar kuadrat menciptakan efek menyebar perlahan dari pusat ke luar.

3. x = r * cos(theta) dan y = r * sin(theta)

    - Mengubah dari koordinat polar ke Cartesian agar bisa ditampilkan di layar.

📐 Visualisasi Sederhana:
- Titik-titik diletakkan dengan jarak radial bertambah pelan (akar kuadrat),

- Sudut antar titik meningkat stabil dengan sudut golden angle,

- Hasilnya membentuk pola spiral Fibonacci seperti di bunga matahari sungguhan.

**Susunan melingkar dibentuk oleh baris berikut di dalam loop kedua pada SunflowerWidget:**
```dart
final x = math.cos(tau * j / (maxSeeds - 1)) * 0.9;
final y = math.sin(tau * j / (maxSeeds - 1)) * 0.9;
```
1. ```tau * j / (maxSeeds - 1)```
    - ```tau``` adalah konstanta ```2π``` (≈ 6.283), yaitu satu putaran penuh dalam radian.

    - Jika ```j``` berjalan dari ```seeds``` hingga ```maxSeeds - 1```, maka nilai sudut akan:

        - Berkisar dari sebagian kecil hingga mendekati 2π (360°),

        - Membuat posisi menyebar secara merata di lingkaran penuh.

2. ```math.cos(...) dan math.sin(...)```
    - Mengubah sudut tersebut ke koordinat x dan y menggunakan fungsi trigonometri:

        - ```cos(θ)``` → posisi horizontal

        - ```sin(θ)``` → posisi vertikal

3. Dikalikan ```* 0.9```
    - Untuk mengecilkan radius agar titik tidak berada di pinggir banget.

    - Alignment menerima nilai antara -1 sampai 1, jadi 0.9 menjaga agar titik tetap dalam batas tampilan.

🔄 Tujuannya:
- Menampilkan sisa titik (dari seeds sampai maxSeeds) dalam bentuk lingkaran di sekitar spiral.

- Titik-titik ini bukan bagian dari spiral utama, tetapi sebagai "latar" atau "referensi" untuk menunjukkan sisa kapasitas biji yang tidak sedang ditampilkan.

🌀 Kesimpulan:
- Variabel x dan y menyusun titik-titik di tepi lingkaran, membentuk cincin luar.

- Spiral utama dihasilkan dari perhitungan r dan theta di loop pertama.

- Perhitungan ini membuat antarmuka tampak interaktif dan kontras antara biji yang aktif (spiral) dan yang tidak aktif (lingkaran).

#### Kode Lengkap
```dart
import 'dart:math' as math;

import 'package:flutter/material.dart';

const int maxSeeds = 250;

class Sunflower extends StatefulWidget {
  const Sunflower({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SunflowerState();
  }
}

class _SunflowerState extends State<Sunflower> {
  int seeds = maxSeeds ~/ 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(title: const Text('Sunflower')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: SunflowerWidget(seeds)),
            const SizedBox(height: 20),
            Text(
              'Showing ${seeds.round()} seeds',
              style: const TextStyle(color: Colors.amber),
            ),
            SizedBox(
              width: 300,
              child: Slider(
                min: 1,
                max: maxSeeds.toDouble(),
                value: seeds.toDouble(),
                onChanged: (val) {
                  setState(() => seeds = val.round());
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SunflowerWidget extends StatelessWidget {
  static const tau = math.pi * 2;
  static const scaleFactor = 1 / 40;
  static const size = 600.0;
  static final phi = (math.sqrt(5) + 1) / 2;
  static final rng = math.Random();

  final int seeds;

  const SunflowerWidget(this.seeds, {super.key});

  @override
  Widget build(BuildContext context) {
    final seedWidgets = <Widget>[];

    for (var i = 0; i < seeds; i++) {
      final theta = i * tau / phi;
      final r = math.sqrt(i) * scaleFactor;
      //
      final x = r * math.cos(theta);
      final y = -1 * r * math.sin(theta);

      seedWidgets.add(
        AnimatedAlign(
          key: ValueKey(i),
          duration: Duration(milliseconds: rng.nextInt(500) + 250),
          curve: Curves.easeInOut,
          alignment: Alignment(x, y),
          child: const Dot(true),
        ),
      );
    }

    for (var j = seeds; j < maxSeeds; j++) {
      final x = math.cos(tau * j / (maxSeeds - 1)) * 0.9;
      final y = math.sin(tau * j / (maxSeeds - 1)) * 0.9;

      seedWidgets.add(
        AnimatedAlign(
          key: ValueKey(j),
          duration: Duration(milliseconds: rng.nextInt(500) + 250),
          curve: Curves.easeInOut,
          alignment: Alignment(x, y),
          child: const Dot(false),
        ),
      );
    }

    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
        height: size,
        width: size,
        child: Stack(children: seedWidgets),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  static const size = 8.0;
  static const radius = 4.0;

  final bool lit;

  const Dot(this.lit, {super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: lit ? Colors.orange : Colors.grey.shade700,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: const SizedBox(height: size, width: size),
    );
  }
}

```