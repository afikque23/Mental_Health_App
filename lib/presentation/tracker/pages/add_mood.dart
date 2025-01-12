import 'package:flutter/material.dart';
import 'package:mental_health_app/common/widgets/appbar/bottom_navbar.dart';
import 'package:mental_health_app/core/configs/assets/app_images.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
import 'package:mental_health_app/services/api_service.dart';
import 'package:mental_health_app/services/mood_services.dart';

class AddMood extends StatefulWidget {
  const AddMood({super.key});

  @override
  _AddMoodState createState() => _AddMoodState();
}

class _AddMoodState extends State<AddMood> {
  String displayedImage = AppImages.tandatanya; // Gambar default
  String selectedMood = ""; // Mood yang dipilih

  final ApiService _apiService = ApiService();
  final TextEditingController _storyController = TextEditingController();
  int _userId = 0;
  String _errorMessage = '';
  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  void updateMood(String mood, String image) {
    setState(() {
      selectedMood = mood;
      displayedImage = image;
    });
  }

  Future<void> fetchUserProfile() async {
    try {
      final result = await _apiService.getProfile();
      if (result['status'] == 'success') {
        setState(() {
          _userId = result['user']['id_user'];
        });
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

  Future<dynamic> saveMood() async {
    final story = _storyController.text.trim();
    if (selectedMood.isEmpty || story.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih mood dan isi cerita sebelum menyimpan!'),
        ),
      );
      return [];
    }
    fetchUserProfile();
    try {
      final response = await MoodService().addMoodTracker(
          storyUser: story, userId: _userId, mood: selectedMood);

      if (response['status'] == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mood berhasil disimpan!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const BottomNavbar(
                    currentIndex: 2,
                  )),
        );
        return response;
      } else if (response[0]['status'] != "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan mood. Coba lagi!')),
        );
        return response;
      }
    } catch (e) {
      return [];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(50)),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      color: AppColors.primary,
                      height: 220,
                      width: double.infinity,
                      child: const SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Hii, Arya Yusufa",
                                style: TextStyle(
                                  fontSize: 29,
                                  fontFamily: 'Coiny',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 0),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Bagaimana kabarmu hari ini ?",
                                style: TextStyle(
                                  fontSize: 29,
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
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 16, top: 23, right: 17),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: List.generate(5, (index) {
                                        final moods = [
                                          'semangat',
                                          'bahagia',
                                          'senang',
                                          'normal',
                                          'bosan',
                                        ];
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
                                            updateMood(
                                                moods[index], images[index]);
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
                                        final moods = [
                                          'cemas',
                                          'stres',
                                          'marah',
                                          'sedih',
                                          'putus asa',
                                        ];
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
                                            updateMood(
                                                moods[index], images[index]);
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
                      const SizedBox(height: 20),
                      Container(
                        width: 360,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 3,
                              spreadRadius: 0,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0, left: 16),
                          child: TextField(
                            controller: _storyController,
                            minLines: 1,
                            maxLines: null,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Ceritakan perasaanmu hari ini',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14, top: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                fixedSize: const Size(110, 39),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Batal',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 14, top: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                saveMood();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                fixedSize: const Size(110, 39),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Simpan',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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
