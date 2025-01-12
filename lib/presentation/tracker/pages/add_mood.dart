import 'package:flutter/material.dart';
import 'package:mental_health_app/common/widgets/appbar/bottom_navbar.dart';
import 'package:mental_health_app/core/configs/assets/app_images.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
<<<<<<< HEAD

class AddMood extends StatelessWidget {
  const AddMood({super.key});

  @override
=======
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
>>>>>>> master
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
<<<<<<< HEAD
              // Container putih yang mengisi area di atas header
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Header
=======
              Stack(
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
                      height: 220, // Tinggi header
                      width: double.infinity, // Lebar penuh
=======
                      height: 220,
                      width: double.infinity,
>>>>>>> master
                      child: const SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Hii, Arya Yusufa",
                                style: TextStyle(
<<<<<<< HEAD
                                  fontSize: 29, // Ukuran teks header
                                  fontFamily: 'Coiny',
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(height: 0), // Jarak kecil antar teks
=======
                                  fontSize: 29,
                                  fontFamily: 'Coiny',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 0),
>>>>>>> master
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Bagaimana kabarmu hari ini ?",
                                style: TextStyle(
<<<<<<< HEAD
                                  fontSize: 29, // Ukuran teks header
                                  fontFamily: 'Coiny',
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
=======
                                  fontSize: 29,
                                  fontFamily: 'Coiny',
                                  color: Colors.white,
>>>>>>> master
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
<<<<<<< HEAD

=======
>>>>>>> master
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
<<<<<<< HEAD
                      // Tulisan tambahan "Bagaimana perasaanmu hari ini?"
=======
>>>>>>> master
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
<<<<<<< HEAD
                      // Container tambahan di bawah teks
=======
>>>>>>> master
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 13.0, left: 18.0, right: 19.0),
                        child: Container(
<<<<<<< HEAD
                          width: 360, // Lebar 360
                          height: 130, // Tinggi sesuai keinginan
                          decoration: BoxDecoration(
                            color: Colors.white, // Warna latar belakang putih
                            borderRadius:
                                BorderRadius.circular(20), // Radius membulat
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Bayangan abu-abu
=======
                          width: 360,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
>>>>>>> master
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
<<<<<<< HEAD
                          // Menambahkan persegi-persegi secara manual
                          child: Padding(
                            padding: const EdgeInsets.all(
                                12.0), // Padding untuk container utama
                            child: Row(
                              children: [
                                // Baris pertama, 5 persegi kecil
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            const Text(
                                              "Semangat",
                                              style: TextStyle(
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0,
                                                  right: 4.0,
                                                  top: 5.0),
                                              child: InkWell(
                                                onTap: () {
                                                  // Aksi saat diklik, misalnya print
                                                  // ignore: avoid_print
                                                  print("Semangat dipilih");
                                                },
                                                child: Container(
                                                  width: 33,
                                                  height: 33,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF46D7B0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Text(
                                              "Bahagia",
                                              style: TextStyle(
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0,
                                                  right: 4.0,
                                                  top: 5.0),
                                              child: InkWell(
                                                onTap: () {
                                                  // Aksi saat diklik
                                                  // ignore: avoid_print
                                                  print("Bahagia dipilih");
                                                },
                                                child: Container(
                                                  width: 33,
                                                  height: 33,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF46D766),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Text(
                                              "Senang",
                                              style: TextStyle(
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0,
                                                  right: 4.0,
                                                  top: 5.0),
                                              child: InkWell(
                                                onTap: () {
                                                  // Aksi saat diklik
                                                  // ignore: avoid_print
                                                  print("Senang dipilih");
                                                },
                                                child: Container(
                                                  width: 33,
                                                  height: 33,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF49D746),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Text(
                                              "Normal",
                                              style: TextStyle(
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0,
                                                  right: 4.0,
                                                  top: 5.0),
                                              child: InkWell(
                                                onTap: () {
                                                  // Aksi saat diklik
                                                  // ignore: avoid_print
                                                  print("Normal dipilih");
                                                },
                                                child: Container(
                                                  width: 33,
                                                  height: 33,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF86D746),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Text(
                                              "Bosan",
                                              style: TextStyle(
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0,
                                                  right: 4.0,
                                                  top: 5.0),
                                              child: InkWell(
                                                onTap: () {
                                                  // Aksi saat diklik
                                                  // ignore: avoid_print
                                                  print("Bosan dipilih");
                                                },
                                                child: Container(
                                                  width: 33,
                                                  height: 33,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFD7D146),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: 0), // Jarak antara dua baris
                                    // Baris kedua, 5 persegi kecil
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0,
                                                  right: 4.0,
                                                  top: 8.0,
                                                  bottom: 2.0),
                                              child: InkWell(
                                                onTap: () {
                                                  // ignore: avoid_print
                                                  print("Cemas dipilih");
                                                },
                                                child: Container(
                                                  width: 33,
                                                  height: 33,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFD7AE46),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            const Text(
                                              "Cemas",
                                              style: TextStyle(
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0,
                                                  right: 4.0,
                                                  top: 8.0,
                                                  bottom: 2.0),
                                              child: InkWell(
                                                onTap: () {
                                                  // ignore: avoid_print
                                                  print("Stress dipilih");
                                                },
                                                child: Container(
                                                  width: 33,
                                                  height: 33,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFD78C46),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            const Text(
                                              "Stress",
                                              style: TextStyle(
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0,
                                                  right: 4.0,
                                                  top: 8.0,
                                                  bottom: 2.0),
                                              child: InkWell(
                                                onTap: () {
                                                  // ignore: avoid_print
                                                  print("Marah dipilih");
                                                },
                                                child: Container(
                                                  width: 33,
                                                  height: 33,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFD74646),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            const Text(
                                              "Marah",
                                              style: TextStyle(
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0,
                                                  right: 4.0,
                                                  top: 8.0,
                                                  bottom: 2.0),
                                              child: InkWell(
                                                onTap: () {
                                                  // ignore: avoid_print
                                                  print("Sedih dipilih");
                                                },
                                                child: Container(
                                                  width: 33,
                                                  height: 33,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF6647D7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            const Text(
                                              "Sedih",
                                              style: TextStyle(
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0,
                                                  right: 4.0,
                                                  top: 8.0,
                                                  bottom: 2.0),
                                              child: InkWell(
                                                onTap: () {
                                                  // ignore: avoid_print
                                                  print("Putus asa dipilih");
                                                },
                                                child: Container(
                                                  width: 33,
                                                  height: 33,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF485DD7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            const Text(
                                              "Putus asa",
                                              style: TextStyle(
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                    width:
                                        10), // Jarak antara persegi kecil dan besar
                                // Persegi besar
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 6.0, left: 6.0),
                                  child: Container(
                                    width: 90, // 4 kali persegi kecil (30 * 2)
                                    height: 90, // 4 kali persegi kecil (30 * 2)
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD9D9D9),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4,
                                          right: 4,
                                          top: 0,
                                          bottom:
                                              10), // Padding untuk gambar, bottom ditambahkan
                                      child: SizedBox(
                                        height: 80, // Tinggi ikon
                                        width: 80, // Lebar ikon
                                        child: Image.asset(AppImages.tandaTanya), // Gambar ditambahkan di sini
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
=======
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
>>>>>>> master
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
<<<<<<< HEAD
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
                                    // Navigasi ke halaman TrackerPage
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavbar()),
                                    );
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
                                    // Navigasi ke halaman TrackerPage
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BottomNavbar()),
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
                          ),
                        ],
                      )
=======
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
>>>>>>> master
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
<<<<<<< HEAD
}
=======
}
>>>>>>> master
