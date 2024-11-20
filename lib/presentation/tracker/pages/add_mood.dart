import 'package:flutter/material.dart';
import 'package:mental_health_app/core/configs/assets/app_images.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
import 'package:mental_health_app/presentation/tracker/pages/respons_ai.dart';

class AddMood extends StatefulWidget {
  const AddMood({super.key});

  @override
  _AddMoodState createState() => _AddMoodState();
}

class _AddMoodState extends State<AddMood> {
  String displayedImage = AppImages.tandatanya; // Gambar default

  void updateImage(String newImage) {
    setState(() {
      displayedImage = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Container putih yang mengisi area di atas header
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Header
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(50)),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      color: AppColors.primary,
                      height: 220, // Tinggi header
                      width: double.infinity, // Lebar penuh
                      child: const SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Hii, Arya Yusufa",
                                style: TextStyle(
                                  fontSize: 29, // Ukuran teks header
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
                                "Bagaimana kabarmu hari ini ?",
                                style: TextStyle(
                                  fontSize: 29, // Ukuran teks header
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

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Tulisan tambahan "Bagaimana perasaanmu hari ini?"
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, right: 36.0),
                        child: Text(
                          "Bagaimana perasaanmu hari ini?",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // Container tambahan di bawah teks
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 13.0, left: 18.0, right: 19.0),
                        child: Container(
                          width: 360,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Kotak kecil dengan margin khusus
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 16, top: 23, right: 17),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Baris atas
                                    Row(
                                      children: List.generate(5, (index) {
                                        final colors = [
                                          const Color(0xFF46D7B0),
                                          const Color(0xFF46D766),
                                          const Color(0xFF49D746),
                                          const Color(0xFF86D746),
                                          const Color(0xFFD7D146),
                                        ];
                                        final images = [
                                          AppImages.semangat,
                                          AppImages.bahagia,
                                          AppImages.senang,
                                          AppImages.normal,
                                          AppImages.bosan,
                                        ];
                                        return GestureDetector(
                                          onTap: () {
                                            updateImage(images[index]);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(4.0),
                                            width: 33,
                                            height: 33,
                                            decoration: BoxDecoration(
                                              color: colors[index],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                    const SizedBox(height: 5),
                                    // Baris bawah
                                    Row(
                                      children: List.generate(5, (index) {
                                        final colors = [
                                          const Color(0xFFD7AE46),
                                          const Color(0xFFD78C46),
                                          const Color(0xFFD74646),
                                          const Color(0xFF6647D7),
                                          const Color(0xFF485DD7),
                                        ];
                                        final images = [
                                          AppImages.cemas,
                                          AppImages.stress,
                                          AppImages.marah,
                                          AppImages.sedih,
                                          AppImages.putusasa,
                                        ];
                                        return GestureDetector(
                                          onTap: () {
                                            updateImage(images[index]);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(4.0),
                                            width: 33,
                                            height: 33,
                                            decoration: BoxDecoration(
                                              color: colors[index],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                              // Kotak besar
                              Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: AssetImage(displayedImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, right: 45.0),
                        child: Text(
                          "Ada yang ingin kamu ceritakan?",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 20), // Jarak antara teks dan container
                      Column(
                        children: [
                          // Container utama dengan TextField
                          Container(
                            width: 360,
                            height: 200, // Sesuaikan tinggi sesuai kebutuhan
                            decoration: BoxDecoration(
                              color: Colors.white, // Warna latar belakang kotak
                              borderRadius:
                                  BorderRadius.circular(20), // Sudut melengkung
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.2), // Warna shadow dengan transparansi
                                  blurRadius: 3, // Blur radius
                                  spreadRadius: 0, // Spread radius
                                  offset: const Offset(
                                      0, 1), // Posisi shadow (x: 0, y: 1)
                                ),
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 0, left: 16),
                              child: SingleChildScrollView(
                                child: TextField(
                                  minLines: 1, // Minimal 1 baris
                                  maxLines:
                                      null, // Tidak ada batas maksimal baris
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black, // Warna teks
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Ceritakan perasaanmu hari ini',
                                    hintStyle: TextStyle(
                                      color:
                                          Colors.grey, // Warna teks placeholder
                                      fontFamily:
                                          'Poppins', // Font family Poppins
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                              height: 20), // Spasi antara Container dan tombol

                          // Row untuk tombol kembali dan simpan di luar Column utama
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Tombol kembali
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 14, top: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Kembali ke halaman sebelumnya
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .white, // Warna latar belakang putih
                                    fixedSize: const Size(110, 39),
                                    elevation: 3, // Drop shadow
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Batal',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight:
                                          FontWeight.w300, // Light weight
                                      color: Colors.black, // Warna teks hitam
                                      fontFamily:
                                          'Poppins', // Font family Poppins
                                    ),
                                  ),
                                ),
                              ),

                              // Tombol simpan
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 16, top: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const ResponsAI(
                                            aiResponse:
                                                'Your AI response here'),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(
                                        0xFF68B39F), // Ganti warna sesuai keinginan
                                    fixedSize: const Size(110, 39),
                                    elevation: 3, // Drop shadow
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Simpan',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
