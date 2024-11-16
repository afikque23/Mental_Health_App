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
              Container(
                color: Colors.white,
                height: 270,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(50)),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        color: AppColors.primary,
                        height: 270,
                        width: double.infinity,
                        child: const SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Hii, Arya Yusufa kami",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Coiny',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              SizedBox(height: 0),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "ingin mendengar cerita anda hari ini :)",
                                  style: TextStyle(
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
                  ],
                ),
              ),
              SizedBox(
                height: 120,
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Expanded(
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
              const SizedBox(height: 25),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(3652, (index) {
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

                      final Color colorForThisItem =
                          colors[index % colors.length];

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

                      final List<String> images = [
                        AppImages.semangat,
                        AppImages.bahagia,
                        AppImages.senang,
                        AppImages.normal,
                        AppImages.bosan,
                        AppImages.stress,
                        AppImages.cemas,
                        AppImages.marah,
                        AppImages.sedih,
                        AppImages.putusasa,
                      ];
                      final imageForThisItem = images[index % images.length];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 11.0, horizontal: 22.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoryTracker(
                                  color: colorForThisItem,
                                  image: imageForThisItem,
                                  selectedDate:
                                      formattedDate, // Tambahkan parameter
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 54,
                            decoration: BoxDecoration(
                              color:
                                  colorForThisItem, // Perbaikan jika properti 'color' salah
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
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFFFFFFF),
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
          Positioned(
            left: 115,
            top: 160,
            child: Container(
              height: 180,
              width: 180,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMood(),
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
