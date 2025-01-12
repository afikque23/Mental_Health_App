import 'package:flutter/material.dart';
import 'package:mental_health_app/services/gemini_services.dart';

class HistoryTracker extends StatefulWidget {
  final Color color;
  final String image;
  final String selectedDate;
  final String storyUser;

  const HistoryTracker({
    super.key,
    required this.color,
    required this.image,
    required this.selectedDate,
    required this.storyUser,
  });

  @override
  _HistoryTrackerState createState() => _HistoryTrackerState();
}

class _HistoryTrackerState extends State<HistoryTracker> {
  final GeminiService _geminiService = GeminiService();
  String _aiResponse = ""; // Untuk menyimpan respons AI
  bool _isLoading = false; // Untuk menampilkan loader saat proses berlangsung

  @override
  void initState() {
    super.initState();
    _getAIResponse(); // Memanggil API saat halaman dimuat
  }

  // Fungsi untuk mendapatkan respons AI
  Future<void> _getAIResponse() async {
    final response = await _geminiService.getResponse(widget.storyUser);
    setState(() {
      _aiResponse = response;
    });
  }

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
                      color:
                          widget.color, // Warna header diambil dari parameter
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

                  Positioned(
                    top: 30,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 35, left: 21),
                child: Text(
                  widget.selectedDate, // Gunakan tanggal dari parameter
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
                  child: SingleChildScrollView(
                    child: Text(
                      widget.storyUser,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
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
                    color: Colors.black,
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
                  height: 300, // Tinggi container
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(), // Loader
                        )
                      : SingleChildScrollView(
                          child: Text(
                            _aiResponse, // Tampilkan respons AI
                            style: const TextStyle(
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
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
              padding: const EdgeInsets.only(left: 18, top: 810),
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
                    fontWeight: FontWeight.w500, // Light weight
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
