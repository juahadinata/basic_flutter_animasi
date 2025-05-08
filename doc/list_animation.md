#### Mari kita ulas sedikit tentang kode ini :
```dart
import 'package:flutter/material.dart';

class ListAnimation extends StatefulWidget {
  const ListAnimation({super.key});

  @override
  State<ListAnimation> createState() => _ListAnimationState();
}

class _ListAnimationState extends State<ListAnimation>
    with SingleTickerProviderStateMixin {
  //
  late AnimationController controller;
  late List<Animation<Offset>> animations = [];
  final int itemCount = 10;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animations = List.generate(
      itemCount,
      (index) => Tween(begin: const Offset(-1, 0), end: Offset.zero).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(
            index * (1 / itemCount),
            1,
          ), // 0.2 s interval between all the list tiles
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade200,
      appBar: AppBar(
        title: const Text('List Animation'),
      ),
      body: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return SlideTransition(
              position: animations[index],
              child: Card(
                child: ListTile(
                  title: Text('Title ${index.toString()}'),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.isCompleted) {
            controller.reverse();
          } else {
            controller.forward();
          }
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}

```
##### Animation Mixin
- ```SingleTickerProviderStateMixin``` dipakai karena kita hanya memakai satu animasi controller.
- ```Ticker``` dibutuhkan oleh ```AnimationController``` untuk sinkronisasi waktu frame animasi.

##### Properti
- ```controller```: mengontrol waktu dan status animasi.
- ```animations```: daftar animasi geser untuk setiap item di list.
- ```itemCount```: jumlah item dalam daftar, digunakan untuk looping.

##### Setup AnimationController
```dart
  controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 1));
```
- Membuat animasi dengan durasi 1 detik.
- ```vsync: this``` agar animasi tidak berjalan saat tidak terlihat (hemat resource).

##### Generate Animasi List Item
```dart
  animations = List.generate(
    itemCount,
    (index) => Tween(begin: const Offset(-1, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          index * (1 / itemCount),
          1,
        ),
      ),
    ),
  );
```
- Membuat 10 animasi offset berbeda-beda menggunakan Tween<Offset> dari kiri ke posisi semula.
- ```CurvedAnimation``` membungkus ```AnimationController (parent)```.
- ```curve``` diatur dengan ```Interval(...)```, yang:
    - Membagi durasi 1 detik ke dalam potongan-potongan.
    - Misalnya: item ke-0 mulai dari 0.0–1.0, item ke-1 mulai dari 0.1–1.0, dst.
    - Ini menciptakan staggered animation: setiap item muncul sedikit demi sedikit, bukan bersamaan.
- ```Interval```: memberikan efek bertahap (staggered animation), jadi item ke-1, ke-2, dst muncul bergiliran dalam durasi total 1 detik.
##### Kenapa ```CurvedAnimation``` ?
Penggunaan CurvedAnimation dalam kode bertujuan untuk menghaluskan atau mengubah laju animasi dari AnimationController. Tanpa CurvedAnimation, animasi akan berjalan dengan kecepatan konstan (linear) dari awal hingga akhir — yang seringkali terasa kaku atau tidak natural.

##### Apa yang terjadi jika ```Interval(...)``` tidak dipasang ?
Jika Interval tidak dibuat, maka setiap animasi dalam list akan bergerak secara bersamaan (serempak), tanpa adanya delay atau urutan — sehingga efek staggered animation yang bertahap *tidak akan terjadi*.
* **Contoh kode tanpa Interval:**
```dart
Tween(begin: const Offset(-1, 0), end: Offset.zero).animate(
  CurvedAnimation(
    parent: controller,
    curve: Curves.easeIn, // tanpa interval
  ),
),
```

* 🔍 **Apa yang terjadi?**
    - Semua item memakai curve yang sama dan dimulai pada waktu yang sama.

    - Saat ```controller.forward()``` dijalankan, semua ```SlideTransition``` bergerak secara bersamaan dari kiri ke kanan.

    - Tidak ada efek delay bertahap antar elemen Card.

```Interval``` dipakai untuk mengatur timing bagian animasi (misalnya: animasi ke-1 mulai dari 0.0–0.2, ke-2 dari 0.2–0.4, dst). Tanpa ```Interval```, semua animasi akan dipicu dan dijalankan pada waktu yang sama, sehingga efek animasi berurutan tidak terjadi.

* **Penjelasan Teknis**
    ```Interval``` bisa diasign ke parameter ```curve``` dalam ```CurvedAnimation``` karena ```Interval``` adalah subclass dari ```Curve``` di Flutter.
    - Pada Flutter, semua jenis kurva animasi (seperti ```Curves.easeIn```, ```Curves.linear```, ```Interval```, dll) adalah turunan dari kelas abstrak bernama ```Curve```.
    - Karena ```Interval``` mewarisi dari ```Curve```, maka ia boleh dan bisa digunakan di tempat yang membutuhkan ```Curve```.

    - ```Interval``` adalah ```Curve``` spesial yang digunakan untuk mengatur bagian durasi dari total waktu animasi. 
        - Misalnya ```Interval(0.3, 0.7)``` Artinya: bagian animasi ini hanya aktif dari 30% sampai 70% durasi animasi.
    - Contoh implementasi :
        - Misalnya :
        ``` dart
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.2, 0.6, curve: Curves.easeIn),
        )
        ```
        - Di sini, Interval membatasi kapan animasi terjadi (hanya dari 20% hingga 60% waktu).
        - Di dalamnya, animasi juga bisa dibentuk dengan curve: ```Curves.easeIn```.