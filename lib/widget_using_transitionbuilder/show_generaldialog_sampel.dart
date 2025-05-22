import 'dart:ui';

import 'package:flutter/material.dart';

class GeneralDialogDemo extends StatefulWidget {
  const GeneralDialogDemo({super.key});

  @override
  State<GeneralDialogDemo> createState() => _GeneralDialogDemoState();
}

class _GeneralDialogDemoState extends State<GeneralDialogDemo> {
  void _infoSlideModel(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true, // Klik luar untuk tutup
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.5), // Background gelap
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        // Isi dialog
        return Align(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                height: 200,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Konfirmasi',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Apakah Anda yakin ingin melanjutkan aksi ini?',
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                          label: const Text('Batal'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Aksi dikonfirmasi!')),
                            );
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('Lanjut'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      // transitionBuilder: (_, animation, __, child) {
      //   final offsetAnimation = Tween<Offset>(
      //     begin: const Offset(0, 1),
      //     end: Offset.zero,
      //   ).animate(animation);

      //   return SlideTransition(
      //     position: offsetAnimation,
      //     child: FadeTransition(
      //       opacity: animation,
      //       child: child,
      //     ),
      //   );
      // },
      ///? Menggunakan SlideTransition : Perpindahan posisi (dari satu arah ke posisi tujuan).
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1), // Animasi mulai dari atas layar
            end: const Offset(0,
                0), // Berhenti di posisi tengah layar atau (ini juga bisa <Offset.zero>)
          ).animate(animation),
          child: FadeTransition(
            opacity: animation, // Efek fade-in
            child: child,
          ),
        );
      },
    );
  }

  void _infoScaleModel(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: const Color(0xff1d2630).withOpacity(0.5),
      //.withOpacity(0.5), // Background semi-transparan
      transitionDuration: const Duration(milliseconds: 500), // Durasi animasi
      pageBuilder: (context, animation1, animation2) {
        return Align(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.34,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Konfirmasi',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Apakah Anda yakin ingin melanjutkan aksi ini?',
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                            label: const Text('Batal'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                foregroundColor: Colors.black),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Aksi dikonfirmasi!')),
                              );
                            },
                            icon: const Icon(Icons.check),
                            label: const Text(
                              'Lanjut',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade800,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },

      ///? menggunakan ScaleTransition : efek membesar dan mengecil
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack, // Efek zoom dengan pantulan lembut
          ),
          child: child,
        );
      },
      //

      // transitionBuilder: (context, animation, secondaryAnimation, child) {
      //   return SlideTransition(
      //     position: Tween<Offset>(
      //       begin: const Offset(0, -1), // Animasi mulai dari atas layar
      //       end: const Offset(0, 0), // Berhenti di posisi tengah layar
      //     ).animate(animation),
      //     child: FadeTransition(
      //       opacity: animation, // Efek fade-in
      //       child: child,
      //     ),
      //   );
      // },
    );
  }

  void _infoRotatedModel(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        return const SizedBox(); // Harus return kosong karena konten akan ditampilkan di transitionBuilder
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.rotate(
          angle: animation.value * 2 * 3.1415926, // 1 putaran penuh
          child: Opacity(
            opacity: animation.value,
            child: Align(
              alignment: Alignment.center,
              child: Material(
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Konfirmasi',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Apakah Anda yakin ingin melanjutkan aksi ini?',
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close),
                              label: const Text('Batal'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Aksi dikonfirmasi!')),
                                );
                              },
                              icon: const Icon(Icons.check),
                              label: const Text(
                                'Lanjut',
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink.shade400,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo showGeneralDialog')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => //_infoPengembangAnimasi(context),
                  _infoSlideModel(context),
              child: const Text('View info with Slide Model'),
            ),
            ElevatedButton(
              onPressed: () => _infoScaleModel(context),
              // _showCustomDialog(context),
              child: const Text('View info with Scale Model'),
            ),
            ElevatedButton(
              onPressed: () => _infoRotatedModel(context),
              // _showCustomDialog(context),
              child: const Text('View info with Rotated Model'),
            ),
          ],
        ),
      ),
    );
  }
}
