import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mental_health_app/core/configs/assets/app_vectors.dart';
import 'package:mental_health_app/presentation/intro/pages/screening.dart'; // Pastikan ini adalah path yang benar

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DisclaimerScreen(),
    );
  }
}

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color(0xFF74CDAE), // Mint green background
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 12), // Padding untuk SVG
                    child: SvgPicture.asset(
                      AppVectors.dekorasidisclaim1,
                      // ignore: deprecated_member_use
                      color:
                          Colors.white.withOpacity(0.8), // Mengubah warna SVG
                      width: 60, // Atur lebar SVG
                      height: 60, // Atur tinggi SVG
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Disclaimer !',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Disini Anda akan melakukan proses Screening untuk menentukan bagaimana kondisi mental anda. Perlu diingat juga bahwa hasil Screening ini tidak 100% akurat jadi untuk pemeriksaan lebih lanjut Anda bisa menghubungi Ahli Jiwa terdekat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SurveyScreen(), // Ganti dengan nama halaman yang sesuai
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xFF74CDAE),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Tambahkan border circular
                        side: const BorderSide(
                            color: Color(
                                0xFF74CDAE)), // Tambahkan border dengan warna yang sama
                      ),
                    ),
                    child: const Text('Saya Setuju'),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 12), // Padding untuk SVG
            child: SvgPicture.asset(
              AppVectors.dekorasidisclaim2,
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.8), // Mengubah warna SVG
              width: 60, // Atur lebar SVG
              height: 60, // Atur tinggi SVG
            ),
          ),
        ),
      ],
    );
  }
}
