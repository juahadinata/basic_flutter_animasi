## Penerapan Animasi pada Widget Flutter

#### 🔹 Level Dasar – Implicit Animations
- `AnimatedContainer` : `animated_color_palete.dart`[lihat contoh](https://github.com/juahadinata/basic_flutter_animasi/blob/main/doc/animated_color_palete.md)

- `TweenAnimationBuilder` : `tween_animation_builder.dart` [baca penjelasan](https://github.com/juahadinata/basic_flutter_animasi/blob/main/doc/tween_animation_builder.md)


- `AnimatedAlign` : `sunflower_anim.dart` [baca penjelasan](https://github.com/juahadinata/basic_flutter_animasi/blob/main/doc/sunflower_anim.md)

Cocok untuk animasi ringan tanpa kontrol manual

#### 🔹 Level Menengah – Explicit Animations

- AnimationController, TickerProviderStateMixin

- Tween, CurvedAnimation

- AnimatedBuilder

- FadeTransition, ScaleTransition, SlideTransition

Memberi kontrol penuh atas proses animasi.

#### 🔹 Level Lanjutan – Hero & Page Transitions
- Hero widget untuk animasi antar halaman

- PageRouteBuilder untuk membuat transisi halaman kustom

- ModalRoute.of(context) untuk mengatur durasi dan animasi keluar-masuk

#### 🔹 Ticker tanpa AnimationController
- `ticker_demo.dart` : [baca penjelasan](https://github.com/juahadinata/basic_flutter_animasi/blob/main/doc/ticker_demo.md)

##### ✅ Method Utama ```AnimationController```

| Method                | Penjelasan              | 
| :-------------------- | :---------------------- | 
|```forward({double? from})``` |	Menjalankan animasi maju dari posisi sekarang atau dari nilai ```from``` jika diberikan.|
```reverse({double? from})```| Menjalankan animasi mundur dari posisi sekarang atau dari nilai ```from``` jika diberikan.|
```repeat({double? min, double? max, bool reverse = false, Duration? period})``` |	Menjalankan animasi berulang kali, bisa maju mundur jika ```reverse``` bernilai ```true```. |
```fling({double velocity = 1.0, SpringDescription? springDescription})``` |Memberikan efek pegas dengan kecepatan tertentu. Cocok untuk gestur swipe atau scroll. |
```stop({bool canceled = true})``` | Menghentikan animasi secara manual, bisa membatalkan callback jika ```canceled = true```. |
```reset()``` |	Mengatur ulang nilai animasi ke awal (```value = lowerBound```). Tidak memicu animasi. |
```dispose()``` |	Membersihkan controller dari memori. Harus dipanggil di ```dispose()``` lifecycle.
 
##### 🔍 Method Tambahan & Properti Relevan
|Nama	|Jenis	|Penjelasan |
| :---- |:----- | :----- |
```addListener(VoidCallback listener)```	|Method	|Menambahkan listener yang dipanggil setiap kali nilai animasi berubah.|
```addStatusListener(AnimationStatusListener listener)```	|Method	|Menambahkan listener untuk memantau status animasi ```(forward, completed, dismissed, dll)```.|
```value```	|Property	|Nilai saat ini dari animasi (```double```, antara 0.0 dan 1.0 secara default).|
```duration / reverseDuration```	|Property	|Durasi default animasi maju/mundur.|
```isAnimating```	|Property	|Mengembalikan ```true``` jika animasi sedang berjalan.|
```isCompleted```	|Property	|Mengembalikan ```true``` jika animasi sudah selesai.|
```isDismissed```	|Property	|```true``` jika nilai animasi berada di titik awal (```lowerBound```).|