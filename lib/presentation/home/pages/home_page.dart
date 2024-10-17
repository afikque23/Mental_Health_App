import 'package:flutter/material.dart';
import 'package:mental_health_app/core/configs/assets/app_images.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: CircleAvatar(
                            //bagian tompol profil masih unfungsi
                            backgroundColor: Colors.grey,
                            radius: 24,
                          ),
                        ),
                        Expanded(
                          //BAGIAN SEARCH COY
                          child: Container(
                            width: 276,
                            height: 34,
                            margin: const EdgeInsets.symmetric(horizontal: 18),
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.search, color: Colors.black),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Cari artikel disini...',
                                        hintStyle: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: 12
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(0.0),
                          child: const Icon(
                            size: 27,
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ), //Tombol Notif AppBar, masih unfungsi
                      ],
                    ),
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
                              'Hello, Arya Yusufa :)',
                              style: TextStyle(
                                  fontFamily: 'Coiny',
                                  fontSize: 30,
                                  color: AppColors.primaryBackground),
                            )),
                        const SizedBox(width: 8),
                        Image.asset(
                          AppImages.homeAppbar,
                          width: 150,
                          height: 139,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          // Main Content
          Expanded(
            child: Container(
              color: Colors.green[50],
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Artikel untuk anda',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  for (int i = 0; i < 2; i++)
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Judul Artikel',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
