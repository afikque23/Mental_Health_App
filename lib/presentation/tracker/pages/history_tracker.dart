import 'package:flutter/material.dart';
import 'package:mental_health_app/core/configs/assets/app_images.dart';

class HistoryTracker extends StatelessWidget {
  const HistoryTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Header
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(50),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      color: const Color(0xFFD74646),
                      height: 240, // Tinggi header
                      width: double.infinity, // Lebar penuh
                      child: const SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Removed Text widgets
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Gambar di tengah header
                  Positioned(
                    top:
                        30, // Mengatur jarak dari atas agar gambar berada di tengah
                    child: Container(
                      height: 220, // Tinggi gambar
                      width: 220, // Lebar gambar
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              AppImages.marah), // Pastikan nama gambar sesuai
                          fit: BoxFit
                              .cover, // Agar gambar menyesuaikan ukuran kontainer
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Teks di luar header
              const Padding(
                padding: EdgeInsets.only(top: 34, left: 21),
                child: Text(
                  "Rabu, 14 September 2005",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    color: Colors.black, // Sesuaikan warna teks sesuai desain
                  ),
                ),
              ),

              // Container dengan drop shadow di bawah teks
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 21, right: 21),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Warna bayangan
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 4), // Offset bayangan
                      ),
                    ],
                  ),
                  width: 387, // Lebar container
                  height: 150, // Tinggi container
                  child: const SingleChildScrollView(
                    child: Text(
                      "Hari ini benar-benar bikin aku kesal! Rasanya sudah cukup sabarku diuji, tapi mereka masih terus saja cari masalah. Sudah berulang kali kuingatkan, tapi seperti nggak ada yang peduli dengan pendapatku. Kenapa harus aku terus yang mengalah? Setiap kali aku coba bicara, mereka anggap enteng seakan-akan aku cuma numpang lewat. Rasanya sudah nggak tahan! Sampai kapan aku harus tahan sama sikap seperti ini?",
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),

              // Menambahkan tulisan "Mungkin ini dapat membantu"
              const Padding(
                padding: EdgeInsets.only(top: 16, left: 21, right: 21),
                child: Text(
                  "Mungkin ini dapat membantu",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    color: Colors.black87,
                  ),
                ),
              ),

              // Menambahkan Container dengan drop shadow di bawah "Mungkin ini dapat membantu"
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 21, right: 21),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Warna bayangan
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 4), // Offset bayangan
                      ),
                    ],
                  ),
                  width: 387, // Lebar container
                  height: 150, // Tinggi container
                  child: const SingleChildScrollView(
                    child: Text(
                      "Terdengar seperti kamu sedang menghadapi banyak hal, dan pasti sangat melelahkan rasanya tidak didengar dan tidak dihargai. Berulang kali mencoba bicara tanpa tanggapan itu pasti bikin capek. Tapi Ingat, kamu nggak sendiri, dan kamu kuat menghadapi ini. Percaya, keadaan ini akan membaik seiring waktu.",
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 0), // Spasi antara Container dan tombol
            ],
          ),
          // Row untuk tombol kembali dan simpan di luar Column utama
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            // Tombol kembali
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 690),
              child: ElevatedButton(
                onPressed: () {
                  // Kembali ke halaman sebelumnya
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Warna latar belakang putih
                  fixedSize: const Size(127, 39),
                  elevation: 3, // Drop shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Kembali',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300, // Light weight
                    color: Colors.black, // Warna teks hitam
                    fontFamily: 'Poppins', // Font family Poppins
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
