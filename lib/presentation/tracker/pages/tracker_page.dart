import 'package:flutter/material.dart';
import 'package:mental_health_app/core/configs/assets/app_images.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
<<<<<<< HEAD

class TrackerPage extends StatelessWidget {
  const TrackerPage({super.key});

  @override
=======
import 'package:mental_health_app/presentation/intro/pages/screening.dart';
import 'package:mental_health_app/presentation/tracker/pages/add_mood.dart';
import 'package:mental_health_app/presentation/tracker/pages/history_tracker.dart';
import 'package:mental_health_app/services/api_service.dart';
import 'package:mental_health_app/services/mood_services.dart';
import 'package:mental_health_app/services/screening_services.dart';
import 'package:intl/intl.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({super.key});

  @override
  _TrackerPageState createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  final ApiService _apiService = ApiService();
  final MoodService _moodService = MoodService();
  final ScreeningService _screeningService = ScreeningService();
  bool isMoodTrackerSelected = true;

  List<dynamic> _moodTrackers = [];
  List<dynamic> _screeningResults = [];

  int userId = 0;
  String _username = '';
  bool _isLoading = false;
  String _selectedFilter = 'hari_ini';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  TrackerPageItem _getMoodAttributes(String mood) {
    final moodMap = {
      'semangat': TrackerPageItem(
          color: const Color(0xFF46D7B0), image: AppImages.semangat),
      'bahagia': TrackerPageItem(
          color: const Color(0xFF46D766), image: AppImages.bahagia),
      'senang': TrackerPageItem(
          color: const Color(0xFF49D746), image: AppImages.senang),
      'normal': TrackerPageItem(
          color: const Color(0xFF86D746), image: AppImages.normal),
      'bosan': TrackerPageItem(
          color: const Color(0xFFD7D146), image: AppImages.bosan),
      'stress': TrackerPageItem(
          color: const Color(0xFFD7AE46), image: AppImages.stress),
      'cemas': TrackerPageItem(
          color: const Color(0xFFD78C46), image: AppImages.cemas),
      'marah': TrackerPageItem(
          color: const Color(0xFFD74646), image: AppImages.marah),
      'sedih': TrackerPageItem(
          color: const Color(0xFF6647D7), image: AppImages.sedih),
      'putus asa': TrackerPageItem(
          color: const Color(0xFF485DD7), image: AppImages.putusasa),
    };

    return moodMap[mood] ??
        TrackerPageItem(
            color: Colors.white, image: 'assets/images/default.png');
  }

  Future<void> fetchUserProfile() async {
    try {
      final result = await _apiService.getProfile();
      if (result['status'] == 'success') {
        setState(() {
          userId = result['user']['id_user'];
          _username = result['user']['nama'];
        });
        _fetchMoodTrackers();
        _fetchScreeningResults();
      } else {
        setState(() {
          _errorMessage = result['message'] ?? 'Error loading profile';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch user profile: $e';
      });
    }
  }

  Future<void> _fetchMoodTrackers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data =
          await _moodService.getFilteredMoodTrackers(_selectedFilter, userId);
      setState(() {
        _moodTrackers = data;
      });
    } catch (e) {
      _showErrorSnackBar('Gagal memuat data mood tracker: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchScreeningResults() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data =
          await _screeningService.getFilteredScreening(_selectedFilter, userId);
      setState(() {
        _screeningResults = data;
      });
    } catch (e) {
      _showErrorSnackBar('Gagal memuat data screening: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  String _getFormattedDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('EEEE, dd MMMM yyyy');
    return formatter.format(parsedDate);
  }

  String _getMentalStateMessage(Map<String, dynamic> screening) {
    final int depressionScore = screening['depresion_score'] ?? 0;
    final int anxietyScore = screening['anxiety_score'] ?? 0;
    final int stressScore = screening['stress_score'] ?? 0;

    if (depressionScore <= 5 && anxietyScore <= 5 && stressScore <= 5) {
      return "Hari ini Anda tidak mengalami gangguan mental yang signifikan.";
    }
    // Jika semua skor sama tinggi
    if (depressionScore == anxietyScore && depressionScore == stressScore) {
      if (depressionScore >= 15) {
        return "Hari ini Anda mengalami gangguan mental yang berat dengan skor yang sangat tinggi di semua aspek.";
      } else if (depressionScore >= 10) {
        return "Hari ini Anda mengalami gangguan mental yang cukup berat di semua aspek.";
      } else {
        return "Hari ini Anda mengalami gangguan mental ringan di semua aspek.";
      }
    }

    // Jika salah satu skor lebih tinggi dari yang lain
    if (depressionScore > anxietyScore && depressionScore > stressScore) {
      return "Pada hari ini sepertinya Anda mengalami depresi.";
    } else if (anxietyScore > depressionScore && anxietyScore > stressScore) {
      return "Pada hari ini sepertinya Anda mengalami kecemasan.";
    } else if (stressScore > depressionScore && stressScore > anxietyScore) {
      return "Pada hari ini sepertinya Anda mengalami stres.";
    }

    // Jika dua skor sama tinggi dan tinggi, serta skor ketiga juga tinggi
    if (depressionScore == anxietyScore &&
        depressionScore >= 15 &&
        stressScore >= 15) {
      return "Pada hari ini Anda mengalami kombinasi depresi dan kecemasan, namun saya mengkhawatirkan jika Anda juga mengalami stres.";
    } else if (depressionScore == stressScore &&
        depressionScore >= 15 &&
        anxietyScore >= 15) {
      return "Pada hari ini Anda mengalami kombinasi depresi dan stres, namun saya mengkhawatirkan jika Anda juga mengalami kecemasan.";
    } else if (anxietyScore == stressScore &&
        anxietyScore >= 15 &&
        depressionScore >= 15) {
      return "Pada hari ini Anda mengalami kombinasi kecemasan dan stres, namun saya mengkhawatirkan jika Anda juga mengalami depresi.";
    }

    // Jika dua skor sama tinggi dan tinggi tanpa skor ketiga yang tinggi
    if (depressionScore == anxietyScore && depressionScore > stressScore) {
      return "Pada hari ini sepertinya Anda mengalami kombinasi depresi dan kecemasan.";
    } else if (depressionScore == stressScore &&
        depressionScore > anxietyScore) {
      return "Pada hari ini sepertinya Anda mengalami kombinasi depresi dan stres.";
    } else if (anxietyScore == stressScore && anxietyScore > depressionScore) {
      return "Pada hari ini sepertinya Anda mengalami kombinasi kecemasan dan stres.";
    }

    return "Kondisi mental Anda seimbang hari ini";
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isMoodTrackerSelected) {
      if (_moodTrackers.isEmpty) {
        return const Center(child: Text('Belum ada data mood tracker'));
      }

      return ListView.builder(
        itemCount: _moodTrackers.length,
        itemBuilder: (context, index) {
          final tracker = _moodTrackers[index];
          final moodAttributes = _getMoodAttributes(tracker['mood']);
          final formattedDate = _getFormattedDate(tracker['created_at']);

          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 11.0, horizontal: 22.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryTracker(
                      color: moodAttributes.color,
                      image: moodAttributes.image,
                      selectedDate: formattedDate,
                      storyUser: tracker['story_user'] ?? 'Tidak ada cerita',
                    ),
                  ),
                );
              },
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                  color: moodAttributes.color,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      if (_screeningResults.isEmpty) {
        return const Center(child: Text('Belum ada data screening'));
      }

      return ListView.builder(
        itemCount: _screeningResults.length,
        itemBuilder: (context, index) {
          final screening = _screeningResults[index];
          final formattedDate = _getFormattedDate(screening['created_at']);
          final mentalStateMessage = _getMentalStateMessage(screening);

          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 11.0, horizontal: 22.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                constraints: const BoxConstraints(
                    minHeight: 0,
                    maxHeight: double.infinity,
                    minWidth: 0,
                    maxWidth: double.infinity),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '${formattedDate ?? 'N/A'}',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.teal,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      // Depression Score
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Depression Score:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${screening['depresion_score'] ?? 0}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.teal),
                            ),
                          ],
                        ),
                      ),
                      // Anxiety Score
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Anxiety Score:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${screening['anxiety_score'] ?? 0}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.teal),
                            ),
                          ],
                        ),
                      ),
                      // Stress Score
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Stress Score:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${screening['stress_score'] ?? 0}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.teal),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Diagnosa:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 11),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  mentalStateMessage,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          )),

                      // Screening Date
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  @override
>>>>>>> master
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
<<<<<<< HEAD
              // Container putih yang mengisi area di atas header
              Container(
                color: Colors.white,
                height: 270, // Tinggi sama dengan header
                width: double.infinity, // Lebar penuh
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Header
=======
              Container(
                color: Colors.white,
                height: 270,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
>>>>>>> master
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(50)),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        color: AppColors.primary,
<<<<<<< HEAD
                        height: 270, // Tinggi header
                        width: double.infinity, // Lebar penuh
                        child: const SafeArea(
=======
                        height: 270,
                        width: double.infinity,
                        child: SafeArea(
>>>>>>> master
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
<<<<<<< HEAD
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
=======
                                  _username.isNotEmpty
                                      ? 'Halo, $_username'
                                      : 'Memuat...',
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'RobotoSlab',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 0),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Bagaimana perasaan anda hari ini :)",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'RobotoSlab',
>>>>>>> master
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
<<<<<<< HEAD

              SizedBox(
                height: 120, // Mengatur tinggi container (40 + 100 jarak atas)
                child: Column(
                  children: [
                    const SizedBox(height: 80), // Menambahkan jarak atas
                    Expanded(
                      // Memastikan ListView menggunakan sisa ruang yang tersedia
=======
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 80),
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
              SizedBox(
                height: 58,
                child: Column(
                  children: [
                    const SizedBox(height: 18),
                    Expanded(
>>>>>>> master
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

<<<<<<< HEAD
=======
                          final List<String> filters = [
                            'hari_ini',
                            'minggu_ini',
                            'bulan_ini',
                            'tahun_ini'
                          ];

>>>>>>> master
                          return Padding(
                            padding: const EdgeInsets.only(right: 2, left: 8),
                            child: ElevatedButton(
                              onPressed: () {
<<<<<<< HEAD
                                // Aksi untuk tombol
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
=======
                                setState(() {
                                  _selectedFilter = filters[index];
                                });
                                _fetchMoodTrackers();
                                _fetchScreeningResults();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    _selectedFilter == filters[index]
                                        ? AppColors.primary
                                        : Colors.white,
>>>>>>> master
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(color: Colors.black),
                                ),
                                elevation: 0,
<<<<<<< HEAD
                                minimumSize: const Size(
                                    105, 38), // Mengatur lebar minimum tombol
=======
                                minimumSize: const Size(105, 38),
>>>>>>> master
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                              child: Text(
                                labels[index],
<<<<<<< HEAD
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600, // SemiBold
=======
                                style: TextStyle(
                                  color: _selectedFilter == filters[index]
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
>>>>>>> master
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

<<<<<<< HEAD
              // Konten tambahan bisa ditempatkan di sini
              const SizedBox(height: 23), // Menambahkan jarak atas
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(1195, (index) {
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
            left: 115, // Atur posisi gambar dari kiri
            top: 160, // Atur posisi gambar dari atas
            child: Container(
              height: 180, // Tinggi gambar
              width: 180, // Lebar gambar
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.trackerimage),
                  fit: BoxFit.cover, // Atur gambar agar sesuai dengan kontainer
=======
              Expanded(child: _buildContent()),
              // Expanded(
              //   child: _isLoading
              //       ? const Center(child: CircularProgressIndicator())
              //       : _moodTrackers.isEmpty
              //           ? const Center(
              //               child: Text('Belum ada data mood tracker'),
              //             )
              //           : SingleChildScrollView(
              //               child: Column(
              //                 children:
              //                     List.generate(_moodTrackers.length, (index) {
              //                   final tracker = _moodTrackers[index];
              //                   final String mood = tracker['mood'];
              //                   final moodAttributes = _getMoodAttributes(mood);
              //                   print(tracker);

              //                   // Data untuk UI
              //                   final Color colorForThisItem =
              //                       moodAttributes.color;
              //                   final String imageForThisItem =
              //                       moodAttributes.image;
              //                   final String story =
              //                       tracker['story_user'] ?? 'Tidak ada cerita';
              //                   final String date = tracker['created_at'];
              //                   final String formattedDate =
              //                       _getFormattedDate(date);

              //                   return Padding(
              //                     padding: const EdgeInsets.symmetric(
              //                         vertical: 11.0, horizontal: 22.0),
              //                     child: GestureDetector(
              //                       onTap: () {
              //                         Navigator.push(
              //                           context,
              //                           MaterialPageRoute(
              //                             builder: (context) => HistoryTracker(
              //                               color: colorForThisItem,
              //                               image: imageForThisItem,
              //                               selectedDate: formattedDate,
              //                               storyUser: story,
              //                             ),
              //                           ),
              //                         );
              //                       },
              //                       child: Container(
              //                         height: 54,
              //                         decoration: BoxDecoration(
              //                           color: colorForThisItem,
              //                           borderRadius: BorderRadius.circular(15),
              //                           boxShadow: [
              //                             BoxShadow(
              //                               color: Colors.grey.withOpacity(0.5),
              //                               spreadRadius: 0,
              //                               blurRadius: 3,
              //                               offset: const Offset(0, 3),
              //                             ),
              //                           ],
              //                         ),
              //                         child: Align(
              //                           alignment: Alignment.center,
              //                           child: Padding(
              //                             padding:
              //                                 const EdgeInsets.only(left: 0),
              //                             child: Text(
              //                               formattedDate,
              //                               style: const TextStyle(
              //                                 fontSize: 16,
              //                                 fontFamily: 'Inter',
              //                                 fontWeight: FontWeight.w600,
              //                                 color: Color(0xFFFFFFFF),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   );
              //                 }),
              //               ),
              //             ),
              // ),
            ],
          ),
          Positioned(
            left: 115,
            top: 160,
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.trackerimage),
                  fit: BoxFit.cover,
>>>>>>> master
                ),
              ),
            ),
          ),
          Positioned(
<<<<<<< HEAD
            left: 315, // Jarak dari kiri
            top: 600, // Jarak dari atas untuk menjaga jarak dengan header
            child: GestureDetector(
              onTap: () {
                // Aksi saat ikon ditekan
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) =>
                //           const AddMood()), // Navigasi ke halaman SurveyMood
                // );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 12), // Padding untuk SVG
                child: SizedBox(
                  height: 50, // Tinggi ikon
                  width: 50, // Lebar ikon
=======
            left: 315,
            top: 735,
            child: GestureDetector(
              onTap: () {
                if (isMoodTrackerSelected) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddMood(),
                    ),
                  ).then((_) {
                    _fetchMoodTrackers();
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SurveyScreen(),
                    ),
                  ).then((_) {
                    _fetchScreeningResults();
                  });
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: SizedBox(
                  height: 50,
                  width: 50,
>>>>>>> master
                  child: Image.asset(AppImages.plustracker),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
<<<<<<< HEAD
}
=======
}

class TrackerPageItem {
  final Color color;
  final String image;

  TrackerPageItem({required this.color, required this.image});
}
>>>>>>> master
