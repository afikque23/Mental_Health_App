import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_svg/svg.dart';
import 'package:mental_health_app/core/configs/assets/app_images.dart';
import 'package:mental_health_app/core/configs/assets/app_vectors.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
import 'package:mental_health_app/presentation/intro/pages/screening.dart'; // Pastikan ini adalah path yang benar
=======
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mental_health_app/core/configs/assets/app_images.dart';
import 'package:mental_health_app/core/configs/assets/app_vectors.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
import 'package:mental_health_app/presentation/intro/pages/screening.dart';
>>>>>>> master

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DisclaimerScreen(),
<<<<<<< HEAD
=======
      backgroundColor: AppColors.primary,
>>>>>>> master
    );
  }
}

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Stack(
        children: [
          Align(
<<<<<<< HEAD
              alignment: const AlignmentDirectional(-1, -1),
              child: SvgPicture.asset(
                AppVectors.dekorasidisclaim1,
                // ignore: deprecated_member_use
                color: Colors.white,
              )),
          Align(
            alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Image.asset(AppImages.disclaimer),
                      ),
                      const Text(
                        'Disclaimer !',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Poppins'
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Disini Anda akan melakukan proses Screening untuk menentukan bagaimana kondisi mental anda. Perlu diingat juga bahwa hasil Screening ini tidak 100% akurat jadi untuk pemeriksaan lebih lanjut Anda bisa menghubungi Ahli Jiwa terdekat',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'Poppins'
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
                              horizontal: 50, vertical: 15
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15), // Tambahkan border circular
                            side: const BorderSide(
                                color: AppColors.lineColor, width: 2
                            ), // Tambahkan border dengan warna yang sama
                          ),
                        ),
                        child: const Text(
                          'Saya Setuju',
                          style: TextStyle(
                            fontSize: 16, 
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary)
                        ),
                      ),
                    ],
                  ),
                ),
          ),
          Align(
              alignment: const AlignmentDirectional(1, 1),
              child: SvgPicture.asset(
                AppVectors.dekorasidisclaim2,
                // ignore: deprecated_member_use
                color: Colors.white,
              )),
=======
            alignment: Alignment.topLeft,
            child: SvgPicture.asset(
              AppVectors.dekorasidisclaim1,
              color: Colors.white,
              width: 500, // Increased size for the top-left decoration
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
              AppVectors.dekorasidisclaim2,
              color: Colors.white,
              width: 450, // Increased size for the bottom-right decoration
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal:
                        20.0), // Padding to center the content within screen width
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Image.asset(
                      AppImages.disclaimer,
                      width: 180,
                      height: 180,
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
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Disini Anda akan melakukan proses Screening untuk menentukan bagaimana kondisi mental anda. Perlu diingat juga bahwa hasil Screening ini tidak 100% akurat jadi untuk pemeriksaan lebih lanjut Anda bisa menghubungi Ahli Jiwa terdekat.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Poppins',
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(
                              color: AppColors.lineColor, width: 2),
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
                  ],
                ),
              ),
            ),
          ),
>>>>>>> master
        ],
      ),
    );
  }
}
