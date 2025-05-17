#### 📦 Apa itu `TweenAnimationBuilder` ?
`TweenAnimationBuilder` adalah widget Flutter bawaan yang memungkinkan kita menganimasikan nilai dari satu titik ke titik lain secara otomatis dan reaktif (tanpa `AnimationController`). Object animation ini akan secara otomatis membuat dan mengelola animasinya sendiri berdasarkan `Tween` yang kita berikan.

**📄 Struktur Dasar**
```dart
TweenAnimationBuilder<T>(
  tween: Tween<T>(begin: ..., end: ...),
  duration: Duration(...),
  builder: (context, value, child) {
    return ...; // Gunakan 'value' untuk membangun UI berdasarkan nilai animasi
  },
)
```
**🧠 Properti Penting**
|Properti	|Keterangan  |
|:----------|:-----------|
|`tween`	|Objek `Tween<T>` yang mendefinisikan dari dan ke nilai.|
|`duration`	|Durasi animasi berlangsung.|
|`builder`	|Fungsi untuk membangun UI berdasarkan nilai animasi `value`.|
|`onEnd` (opsional)	|Callback yang dipanggil setelah animasi selesai.|
|`curve` (opsional)	|Kurva animasi (misalnya: `Curves.easeInOut`).|
|`child` (opsional)	|Widget yang tidak berubah saat animasi berlangsung (untuk optimasi).|

**💡 Contoh Sederhana: Animasi Skala**
```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(begin: 0.5, end: 1.0),
  duration: const Duration(seconds: 1),
  curve: Curves.easeInOut,
  builder: (context, value, child) {
    return Transform.scale(
      scale: value,
      child: child,
    );
  },
  child: Icon(Icons.favorite, color: Colors.red, size: 48),
)
```
*Penjelasan:*
- `Tween<double>(begin: 0.5, end: 1.0)` → Skala animasi dari 50% ke 100%.

- `Transform.scale` → Mengubah ukuran berdasarkan nilai value yang berubah.

- `child` adalah `Icon` yang tidak di-rebuild setiap frame, jadi lebih efisien.

**🎯 Kapan Menggunakan `TweenAnimationBuilder`?**
Gunakan `TweenAnimationBuilder` saat:

- Ingin membuat transisi halus untuk ukuran, warna, posisi, opacity, dsb.

- Tidak perlu kontrol rumit seperti play, pause, reverse.

- Ingin menghindari boilerplate `AnimationController`.

**🧪 Contoh Lain: Warna Background**
```dart
TweenAnimationBuilder<Color?>(
  tween: ColorTween(begin: Colors.blue, end: Colors.green),
  duration: Duration(seconds: 2),
  builder: (context, color, _) {
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  },
)
```
**📌 Catatan Penting**
- Setiap kali `tween.end` berubah, animasi akan berjalan dari `current value` ke `tween.end`.

- Jika kamu ingin animasi hanya dijalankan sekali, pastikan tidak memicu rebuild `TweenAnimationBuilder` dengan `tween.end` baru setiap waktu.

- Gunakan `child:` untuk bagian UI yang tidak berubah selama animasi agar performa lebih baik.