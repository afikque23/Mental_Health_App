import 'package:flutter/material.dart';

class HistoryTracker extends StatelessWidget {
  final Color color;
  final String image;
  final String selectedDate; // Tambahkan parameter

  const HistoryTracker({
    super.key,
    required this.color,
    required this.image,
    required this.selectedDate, // Tambahkan parameter
  });

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
                      color: color, // Warna header diambil dari parameter
                      height: 220, // Tinggi header
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
                      height: 200, // Tinggi gambar
                      width: 200, // Lebar gambar
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(image), // Gambar dari parameter
                          fit: BoxFit
                              .cover, // Agar gambar menyesuaikan ukuran kontainer
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Teks di luar header
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 21),
                child: Text(
                  selectedDate, // Gunakan tanggal dari parameter
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                ),
              ),

              // Container dengan drop shadow di bawah teks
              Padding(
                padding: const EdgeInsets.only(top: 14, left: 21, right: 21),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
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
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),

              // Menambahkan tulisan "Mungkin ini dapat membantu"
              const Padding(
                padding: EdgeInsets.only(top: 18, left: 21, right: 21),
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
                padding: const EdgeInsets.only(top: 14, left: 21, right: 21),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
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
                      textAlign: TextAlign.justify,
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
              padding: const EdgeInsets.only(left: 18, top: 695),
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
