import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mental_health_app/core/configs/assets/app_images.dart';
import 'package:mental_health_app/core/configs/assets/app_vectors.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
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
    return Container(
      color: AppColors.primary,
      child: SingleChildScrollView(
        // Menggunakan SingleChildScrollView
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            SvgPicture.asset(
              AppVectors.dekorasidisclaim1,
              // ignore: deprecated_member_use
              color: Colors.white,
              width: 120, // Ukuran dekorasi
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                AppImages.disclaimer,
                width: 180,
                height: 180,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Disclaimer !',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Disini Anda akan melakukan proses Screening untuk menentukan bagaimana kondisi mental anda. Perlu diingat juga bahwa hasil Screening ini tidak 100% akurat jadi untuk pemeriksaan lebih lanjut Anda bisa menghubungi Ahli Jiwa terdekat.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SurveyScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF74CDAE),
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(color: AppColors.lineColor, width: 2),
                ),
              ),
              child: const Text(
                'Saya Setuju',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 40),
            SvgPicture.asset(
              AppVectors.dekorasidisclaim2,
              // ignore: deprecated_member_use
              color: Colors.white,
              width: 120, // Ukuran dekorasi
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
