import 'package:flutter/material.dart';
import 'package:mental_health_app/core/configs/assets/app_images.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
import 'package:mental_health_app/presentation/intro/pages/screening.dart';

class TrackerPage extends StatelessWidget {
  const TrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Container putih yang mengisi area di atas header
              Container(
                color: Colors.white,
                height: 270, // Tinggi sama dengan header
                width: double.infinity, // Lebar penuh
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Header
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(50)),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        color: AppColors.primary,
                        height: 270, // Tinggi header
                        width: double.infinity, // Lebar penuh
                        child: const SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Hii, Arya Yusufa kami",
                                  style: TextStyle(
                                    fontSize: 25, // Ukuran teks header
                                    fontFamily: 'Coiny',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              SizedBox(height: 0), // Jarak kecil antar teks
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "ingin mendengar cerita anda hari ini :)",
                                  style: TextStyle(
                                    fontSize: 25, // Ukuran teks header
                                    fontFamily: 'Coiny',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
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
              ),

              SizedBox(
                height: 120, // Mengatur tinggi container (40 + 100 jarak atas)
                child: Column(
                  children: [
                    const SizedBox(height: 80), // Menambahkan jarak atas
                    Expanded(
                      // Memastikan ListView menggunakan sisa ruang yang tersedia
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          final List<String> labels = [
                            'Hari Ini',
                            'Minggu Ini',
                            'Bulan Ini',
                            'Tahun Ini'
                          ];

                          return Padding(
                            padding: const EdgeInsets.only(right: 2, left: 8),
                            child: ElevatedButton(
                              onPressed: () {
                                // Aksi untuk tombol
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(color: Colors.black),
                                ),
                                elevation: 0,
                                minimumSize: const Size(
                                    105, 38), // Mengatur lebar minimum tombol
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                              child: Text(
                                labels[index],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600, // SemiBold
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Konten tambahan bisa ditempatkan di sini
              const SizedBox(height: 23), // Menambahkan jarak atas
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(31, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 11.0, horizontal: 22.0),
                        child: Container(
                          height: 54, // Atur sesuai ukuran gambar
                          decoration: BoxDecoration(
                            color: Colors.white, // Warna latar belakang putih
                            borderRadius:
                                BorderRadius.circular(15), // Sesuaikan sudut
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.5), // Warna shadow dengan transparansi
                                spreadRadius: 0, // Jarak penyebaran shadow
                                blurRadius: 3, // Mengatur seberapa blur shadow
                                offset: const Offset(
                                    0, 3), // Mengatur arah shadow (x, y)
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
          // Gambar di luar header hijau, dengan posisi yang bisa diatur
          Positioned(
            left: 113, // Atur posisi gambar dari kiri
            top: 165, // Atur posisi gambar dari atas
            child: Container(
              height: 180, // Tinggi gambar
              width: 180, // Lebar gambar
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.imagetracker),
                  fit: BoxFit.cover, // Atur gambar agar sesuai dengan kontainer
                ),
              ),
            ),
          ),
          Positioned(
            left: 305, // Jarak dari kiri
            top: 595, // Jarak dari atas untuk menjaga jarak dengan header
            child: GestureDetector(
              onTap: () {
                // Aksi saat ikon ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const SurveyScreen()), // Navigasi ke halaman SurveyMood
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 12), // Padding untuk SVG
                child: SizedBox(
                  height: 80, // Tinggi ikon
                  width: 80, // Lebar ikon
                  child: Image.asset(AppImages.plustracker),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
