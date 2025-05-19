import 'package:flutter/material.dart';

class FractionalTranslationExample extends StatefulWidget {
  const FractionalTranslationExample({super.key});

  @override
  State<FractionalTranslationExample> createState() =>
      _FractionalTranslationExampleState();
}

class _FractionalTranslationExampleState
    extends State<FractionalTranslationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    // Inisialisasi controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Tween animasi Offset relatif
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.5, -1), // geser 50% dari ukuran widget
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose(); // penting untuk menghindari memory leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FractionalTranslation + Animation")),
      body: Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    SizedBox(width: 200, child: Text('Tanpa AnimatedBuilder')),
              ),
              Center(
                child: Center(
                  child: Container(
                    color: Colors.grey[300],
                    width: 100,
                    height: 100,
                    child: FractionalTranslation(
                      transformHitTests: false,
                      translation: const Offset(0.5, 0.5),
                      child: Container(
                        // ukuran widget child tidak berpengaruh
                        // artinya tidak perlu membuat ukuran child
                        // karena ukurannya tetap menyesuaikan
                        // ke ukuran iduknya yaitu 100 X 100
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 200,
                  child: Text('Dengan AnimatedBuilder'),
                ),
              ),
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: AnimatedBuilder(
                    animation: _offsetAnimation,
                    builder: (context, child) {
                      return FractionalTranslation(
                        translation: _offsetAnimation.value,
                        child: child,
                      );
                    },
                    child: Container(
                      // width: 50,
                      // height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          SizedBox(
            child: Center(
              child: Container(
                width: 200,
                height: 200,
                color: Colors.grey.shade300,
                child: Stack(
                  children: [
                    // Garis bantu menunjukkan posisi awal (kiri atas)
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 2),
                        ),
                        child: const Center(child: Text("Area Klik")),
                      ),
                    ),

                    // Tombol yang digeser
                    FractionalTranslation(
                      translation:
                          const Offset(1.0, 0.5), // geser ke kanan dan tengah
                      transformHitTests:
                          // jika false: tetap bisa ditekan di posisi aslinya
                          // jika true: tombol bisa ditekan diposisi baru
                          false,
                      child: SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Tombol ditekan!'),
                                backgroundColor: Colors.red,
                                duration: Duration(milliseconds: 500),
                              ),
                            );
                          },
                          child: const Text('Tombol'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
