import 'package:flutter/material.dart';

class ResponsAI extends StatelessWidget {
  final String aiResponse; // Tambahkan properti untuk menerima respons dari AI

  const ResponsAI({super.key, required this.aiResponse});

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
                      color: const Color(0xFF68B39F),
                      height: 220, // Tinggi header
                      width: double.infinity, // Lebar penuh
                      child: const SafeArea(
                        child: Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Terimakasih sudah bercerita :)",
                                  style: TextStyle(
                                    fontSize: 29,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Coiny',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Teks di luar header
              const Padding(
                padding: EdgeInsets.only(top: 24, left: 21),
                child: Text(
                  "Mungkin ini dapat membantu",
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
                padding: const EdgeInsets.only(top: 16, left: 21, right: 21),
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
                  height: 370, // Tinggi container
                  child: SingleChildScrollView(
                    child: Text(
                      aiResponse, // Tampilkan respons dari AI
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
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
                    borderRadius: BorderRadius.circular(10),
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
