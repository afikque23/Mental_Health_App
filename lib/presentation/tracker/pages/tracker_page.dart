import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:mental_health_app/core/configs/assets/app_images.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';

class TrackerPage extends StatelessWidget {
  const TrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // App Bar
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(50)),
            child: Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.primary,
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
                            width: 210,
                            height: 100,
                            child: const Text(
                              'Hii, Arya Yusufa kami ingin mendengar cerita anda hari ini :)',
                              style: TextStyle(
                                  fontFamily: 'Coiny',
                                  fontSize: 30,
                                  color: AppColors.primaryBackground),
                            )),
                      ],
                    )
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
