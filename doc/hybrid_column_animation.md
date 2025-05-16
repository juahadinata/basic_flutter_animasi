#### Keterangan kode `hybrid_column_aniamation.dart
- **Kode**
    ```dart
            _controller = AnimationController(
            duration: const Duration(seconds: 2),
            vsync: this,
            );

            // Animasi masuk Column (geser dari bawah)
            _columnSlideAnimation = Tween<Offset>(
            begin: const Offset(0, 0.2),
            end: Offset.zero,
                ).animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.easeOut,
            ));

            // Animasi anak-anak (Fade dan Slide satu per satu)
            _fadeAnimations = List.generate(_childCount, (i) {
                return CurvedAnimation(
                    parent: _controller,
                    curve: Interval(0.3 + i * 0.15, 1.0, curve: Curves.easeIn),
                );
            });

            _slideAnimations = List.generate(_childCount, (i) {
                return Tween<Offset>(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                ).animate(CurvedAnimation(
                    parent: _controller,
                    curve: Interval(0.3 + i * 0.15, 1.0, curve: Curves.easeOut),
                ));
            });

            _controller.forward(); // Jalankan animasi
    ```




1. `Tween<Offset>(begin: ..., end: ...)`
    - `Tween<Offset>` adalah interpolator yang menghasilkan nilai `Offset` antara `begin` dan `end`.

    - `Offset(0, 0.2)` artinya posisi awal geser ke bawah 20% dari tinggi elemen.

    - `Offset.zero` (alias `Offset(0, 0)`) artinya elemen berada di posisi normal (tidak bergeser).

2. `.animate(...)`
    - Method `animate(...)` digunakan untuk menghubungkan `Tween` dengan sebuah animation (biasanya`CurvedAnimation`).

    - Hasil dari `.animate(...)` adalah sebuah `Animation<T>` (dalam kasus ini: `Animation<Offset>`).

3. `CurvedAnimation(...)`
    ```dart
    CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
    )
    ```
    - `CurvedAnimation` digunakan untuk membentuk kurva percepatan animasi.

    - `parent`: controller utama yang mengatur waktu (_controller).

    - `curve: Curves.easeOut`:
    
        - Memulai animasi cepat lalu melambat di akhir.

        - Efeknya membuat animasi terasa halus dan natural.

4. `_columnSlideAnimation = ...`
    ```dart
    _columnSlideAnimation = Tween<Offset>(
        begin: const Offset(0, 0.2),
        end: Offset.zero,
            ).animate(CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
    ));
    ```
    - Ini membuat animasi geser (SlideTransition) untuk seluruh Column.

    - begin: Offset(0, 0.2): mulai 20% ke bawah.

    - curve: easeOut: geser masuk dengan efek melambat.

5. `_fadeAnimations = List.generate(...)`
    ```dart
    _fadeAnimations = List.generate(_childCount, (i) {
    return CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3 + i * 0.15, 1.0, curve: Curves.easeIn),
    );
    });
    ```
    `List.generate(...):` membuat daftar animasi fade sebanyak _childCount.

    `Interval(...):`

    Digunakan untuk membuat delay bertahap antar item.

    Contoh:

    i = 0 → Interval(0.3, 1.0)

    i = 1 → Interval(0.45, 1.0)

    i = 2 → Interval(0.6, 1.0)

    curve: Curves.easeIn: animasi dimulai lambat lalu dipercepat (efek "muncul" lembut).

6. `_slideAnimations = List.generate(...)`
    ```dart
    _slideAnimations = List.generate(_childCount, (i) {
    return Tween<Offset>(
        begin: const Offset(0, 0.2),
        end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3 + i * 0.15, 1.0, curve: Curves.easeOut),
        ));
    });
    ```
    - Ini mirip seperti `_fadeAnimations`, tetapi menghasilkan `Animation<Offset>` untuk `SlideTransition`.

    - `begin: Offset(0, 0.2)`: anak-anak akan muncul dari bawah.

    - `Kurva easeOut`: percepatan di awal, melambat di akhir.

    - `Interval`: membuat animasi muncul satu per satu sesuai urutan.

- ** 🔁 Hasil kombinasi**
    - `Column` → geser masuk perlahan (`_columnSlideAnimation`)

    - Setiap child:

        - Fade in + Slide up satu per satu (`_fadeAnimations`, `_slideAnimations`)

        - Dengan jeda 0.15 detik per elemen