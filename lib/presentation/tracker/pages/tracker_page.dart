import 'package:flutter/material.dart';
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
              height: 250, // Sesuaikan tinggi header
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
                        padding: const EdgeInsets.only(right: 2, left: 10),
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
                                110, 38), // Mengatur lebar minimum tombol
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          child: Text(
                            labels[index],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
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
          const SizedBox(height: 20), // Menambahkan jarak atas
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(31, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
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
                            spreadRadius: 1, // Jarak penyebaran shadow
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
          )
        ],
      ),
    );
  }
}
