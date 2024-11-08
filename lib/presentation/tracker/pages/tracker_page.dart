import 'package:flutter/material.dart';
import 'package:mental_health_app/core/configs/assets/app_images.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
import 'package:mental_health_app/presentation/tracker/pages/add_mood.dart';
import 'package:mental_health_app/presentation/tracker/pages/history_tracker.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({super.key});

  @override
  _TrackerPageState createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
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
              const SizedBox(height: 25), // Menambahkan jarak atas
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(3652, (index) {
                      // Daftar warna yang akan digunakan
                      final List<Color> colors = [
                        const Color(0xFF46D7B0),
                        const Color(0xFF46D766),
                        const Color(0xFF49D746),
                        const Color(0xFF86D746),
                        const Color(0xFFD7D146),
                        const Color(0xFFD7AE46),
                        const Color(0xFFD78C46),
                        const Color(0xFFD74646),
                        const Color(0xFF6647D7),
                        const Color(0xFF485DD7),
                      ];

                      // Pilih warna berdasarkan indeks, menggunakan modulus untuk mengulang daftar warna
                      final Color colorForThisItem =
                          colors[index % colors.length];

                      // Hitung tanggal mulai dari hari ini, lalu mundur ke belakang berdasarkan index
                      DateTime date =
                          DateTime.now().subtract(Duration(days: index));

                      // Format tanggal menjadi string "Hari, Tanggal Bulan Tahun"
                      String formattedDate = "${[
                        'Senin',
                        'Selasa',
                        'Rabu',
                        'Kamis',
                        'Jumat',
                        'Sabtu',
                        'Minggu'
                      ][date.weekday - 1]}, "
                          "${date.day} "
                          "${[
                        'Januari',
                        'Februari',
                        'Maret',
                        'April',
                        'Mei',
                        'Juni',
                        'Juli',
                        'Agustus',
                        'September',
                        'Oktober',
                        'November',
                        'Desember'
                      ][date.month - 1]} "
                          "${date.year}";

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 11.0, horizontal: 22.0),
                        child: GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman HistoryTracker ketika diklik
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const HistoryTracker(), // Halaman HistoryTracker
                              ),
                            );
                          },
                          child: Container(
                            height: 54, // Atur sesuai ukuran gambar
                            decoration: BoxDecoration(
                              color:
                                  colorForThisItem, // Warna dipilih berdasarkan indeks
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 3,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Align(
                              alignment:
                                  Alignment.centerLeft, // Mengatur teks di kiri
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0), // Tambahkan padding kiri
                                child: Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFFFFFFF), // Hijau tua
                                  ),
                                ),
                              ),
                            ),
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
            left: 115, // Atur posisi gambar dari kiri
            top: 160, // Atur posisi gambar dari atas
            child: Container(
              height: 180, // Tinggi gambar
              width: 180, // Lebar gambar
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.trackerimage),
                  fit: BoxFit.cover, // Atur gambar agar sesuai dengan kontainer
                ),
              ),
            ),
          ),
          Positioned(
            left: 315, // Jarak dari kiri
            top: 600, // Jarak dari atas untuk menjaga jarak dengan header
            child: GestureDetector(
              onTap: () {
                debugPrint("Icon tapped"); // Cek apakah ikon terdeteksi ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const AddMood(), // Navigasi ke halaman AddMood
                  ),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: SizedBox(
                  height: 50,
                  width: 50,
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
