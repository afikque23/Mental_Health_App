import 'package:flutter/material.dart';
import 'package:mental_health_app/common/widgets/appbar/bottom_navbar.dart';
import 'package:mental_health_app/core/configs/assets/app_images.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
import 'package:mental_health_app/presentation/intro/pages/screening.dart';
import 'package:mental_health_app/presentation/tracker/pages/add_mood.dart';
import 'package:mental_health_app/presentation/tracker/pages/history_tracker.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({super.key});

  @override
  _TrackerPageState createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  bool isMoodTrackerSelected = true; // Deklarasi variabel state di sini

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Column(
                children: [
                  // Container Utama
                  Container(
                    color: Colors.white,
                    height: 220,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(50)),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        color: AppColors.primary,
                        child: SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  isMoodTrackerSelected
                                      ? "Hii, Arya Yusufa kami ingin"
                                      : "Hii, Apa kabar Arya",
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Coiny',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 0),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  isMoodTrackerSelected
                                      ? "mendengar cerita anda hari ini :)"
                                      : "Yusufa?",
                                  style: const TextStyle(
                                    fontSize: 25,
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
                  ),
                  // Tulisan Moodtracker dan Screening
                  Padding(
                    padding: const EdgeInsets.only(top: 66),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isMoodTrackerSelected = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Moodtracker",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    color: isMoodTrackerSelected
                                        ? const Color(0xFF68B39F)
                                        : const Color(0xFF797A7A)),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                width: 167,
                                height: 2,
                                color: isMoodTrackerSelected
                                    ? const Color(0xFF68B39F)
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 25), // Jarak antar teks
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isMoodTrackerSelected = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Screening",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    color: isMoodTrackerSelected
                                        ? const Color(0xFF797A7A)
                                        : const Color(0xFF68B39F)),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                  width: 167,
                                  height: 2,
                                  color: isMoodTrackerSelected
                                      ? Colors.transparent
                                      : const Color(0xFF68B39F)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 58,
                child: Column(
                  children: [
                    const SizedBox(height: 18),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          final List<String> labels = [
                            'Semua',
                            'Hari Ini',
                            'Minggu Ini',
                            'Bulan Ini',
                            'Tahun Ini'
                          ];

                          return Padding(
                            padding: const EdgeInsets.only(right: 2, left: 8),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(color: Colors.black),
                                ),
                                elevation: 0,
                                minimumSize: const Size(105, 38),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                              child: Text(
                                labels[index],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
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
              const SizedBox(height: 18),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(3652, (index) {
                      // List pasangan warna dan gambar
                      final List<Map<String, dynamic>> colorImagePairs = [
                        {
                          "color": const Color(0xFF46D7B0),
                          "image": AppImages.semangat
                        },
                        {
                          "color": const Color(0xFF46D766),
                          "image": AppImages.bahagia
                        },
                        {
                          "color": const Color(0xFF49D746),
                          "image": AppImages.senang
                        },
                        {
                          "color": const Color(0xFF86D746),
                          "image": AppImages.normal
                        },
                        {
                          "color": const Color(0xFFD7D146),
                          "image": AppImages.bosan
                        },
                        {
                          "color": const Color(0xFFD7AE46),
                          "image": AppImages.stress
                        },
                        {
                          "color": const Color(0xFFD78C46),
                          "image": AppImages.cemas
                        },
                        {
                          "color": const Color(0xFFD74646),
                          "image": AppImages.marah
                        },
                        {
                          "color": const Color(0xFF6647D7),
                          "image": AppImages.sedih
                        },
                        {
                          "color": const Color(0xFF485DD7),
                          "image": AppImages.putusasa
                        },
                      ]..shuffle(); // Acak pasangan warna dan gambar

                      // Pilih pasangan warna dan gambar untuk item saat ini
                      final Map<String, dynamic> pairForThisItem =
                          colorImagePairs[index % colorImagePairs.length];
                      final Color colorForThisItem = pairForThisItem["color"];
                      final String imageForThisItem = pairForThisItem["image"];

                      // Format tanggal
                      DateTime date =
                          DateTime.now().subtract(Duration(days: index));
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
                            vertical: 10.0, horizontal: 22.0),
                        child: GestureDetector(
                          onTap: () {
                            if (isMoodTrackerSelected) {
                              // Navigasi ke HistoryTracker pada halaman MoodTracker
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HistoryTracker(
                                    color: colorForThisItem,
                                    image: imageForThisItem,
                                    selectedDate: formattedDate,
                                  ),
                                ),
                              );
                            } else {
                              // Navigasi ke BottomNavbar pada halaman Screening
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavbar()),
                              );
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: isMoodTrackerSelected
                                  ? colorForThisItem
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius:
                                      5, // Tingkat blur untuk efek timbul
                                  offset: const Offset(0, 3), // Arah bayangan
                                ),
                              ],
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  formattedDate,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    color: isMoodTrackerSelected
                                        ? const Color(0xFFFFFFFF)
                                        : Colors.black,
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
              )
            ],
          ),
          Positioned(
            left: 115,
            top: 135,
            child: Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.trackerimage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 315,
            top: 600,
            child: GestureDetector(
              onTap: () {
                if (isMoodTrackerSelected) {
                  // Jika halaman Moodtracker, arahkan ke AddMood
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddMood(),
                    ),
                  );
                } else {
                  // Jika halaman Screening, arahkan ke SurveyScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SurveyScreen(),
                    ),
                  );
                }
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
