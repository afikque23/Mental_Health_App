import 'package:flutter/material.dart';
import 'package:mental_health_app/common/widgets/appbar/bottom_navbar.dart';
<<<<<<< HEAD

class ScreeningPage extends StatelessWidget {
  final Widget body;
  final Color headerColor;
  final Color bodyColor;

  const ScreeningPage({
    super.key,
    required this.body,
    this.headerColor = const Color(0xFF8FD7C1),
    this.bodyColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    List<double> sizes = [110, 140, 150, 160, 170, 180];
    List<Offset> positions = [
      const Offset(-60, 30),
      const Offset(130, -90),
      const Offset(250, 130),
      const Offset(140, 180),
      const Offset(330, -110),
      const Offset(220, 280),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: bodyColor,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 233,
              decoration: BoxDecoration(
                color: headerColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: List.generate(6, (index) {
                  return Positioned(
                    top: positions[index].dy,
                    left: positions[index].dx,
                    child: Container(
                      width: sizes[index],
                      height: sizes[index],
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.14),
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          SafeArea(
            child: body,
          ),
        ],
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final String questionText;
  final int currentQuestionIndex;
  final int totalQuestions;

  const QuestionCard({
    super.key,
    required this.questionText,
    required this.currentQuestionIndex,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 16.0, top: 30.0, right: 16.0, bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        width: 300,
        height: 180,
        margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 5), // Menambahkan SizedBox untuk jarak atas
            Text(
              'Question ${currentQuestionIndex + 1}/$totalQuestions',
              style: const TextStyle(
                color: Colors.teal,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              questionText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.teal,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRadio extends StatefulWidget {
  final String label;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const CustomRadio({
    super.key,
    required this.label,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.groupValue == widget.label;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      width: 240,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.teal,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: const TextStyle(fontSize: 16.0),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Radio<String>(
                value: widget.label,
                groupValue: widget.groupValue,
                onChanged: (value) {
                  widget.onChanged(value!);
                },
              ),
              if (isSelected)
                const Icon(
                  Icons.radio_button_checked,
                  color: Colors.teal,
                  size: 24,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SurveyScreen(),
    );
  }
}
=======
import 'package:mental_health_app/services/api_service.dart';
import 'package:mental_health_app/data/models/ScreeningQuestion.dart';
import 'package:mental_health_app/common/widgets/customRadio/custom_radio.dart';
import 'package:mental_health_app/common/widgets/questionCard/question_card.dart';
>>>>>>> master

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
<<<<<<< HEAD
  // ignore: library_private_types_in_public_api
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  int currentQuestionIndex = 0;
  // List untuk menyimpan jawaban dari setiap pertanyaan
  List<String> selectedOptions = List.filled(16, ''); // Ganti 16 dengan jumlah pertanyaan

  final List<String> questions = [
    "Seberapa sering Anda merasa sedih, tertekan, atau putus asa?",
    "Seberapa sering Anda mengalami kesulitan untuk tertidur, sulit tertidur, atau terlalu banyak tidur?",
    "Seberapa sering Anda merasa lelah atau kekurangan energi?",
    "Seberapa sering Anda merasa gugup, cemas, atau gelisah?",
    "Seberapa sering Anda tidak mampu menghentikan atau mengendalikan rasa khawatir?",
    "Seberapa sering Anda mengalami kesulitan bersantai?",
    "Seberapa sering Anda merasa gelisah sehingga sulit untuk duduk diam?",
    "Seberapa sering Anda menyadari bahwa Anda tidak mampu mengatasi semua hal yang harus Anda lakukan?",
    "Seberapa sering Anda marah karena hal-hal di luar kendali Anda?",
    "Seberapa sering Anda merasakan kesulitan yang menumpuk begitu tinggi sampai Anda tidak dapat mengatasinya?",
    "Seberapa sering Anda merasa yakin dengan kemampuan Anda?",
    "Seberapa sering Anda merasa puas dengan diri sendiri?",
    "Seberapa sering Anda merasa bahwa Anda memiliki sejumlah sifat baik?",
    "Seberapa sering Anda merasa bahwa Anda memiliki seseorang yang dapat Anda mintai dukungan emosional?",
    "Seberapa sering Anda merasa menjadi bagian dari suatu komunitas atau kelompok sosial?",
    "Seberapa sering kamu merasa ada orang yang benar-benar memahamimu?",
    // Tambahkan semua 16 pertanyaan
  ];

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
=======
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen>
    with SingleTickerProviderStateMixin {
  int currentQuestionIndex = 0;
  List<ScreeningQuestion> questions = [];
  List<int> selectedOptions = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';
  final ApiService _apiService = ApiService();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    loadQuestions();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Define fade animation
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Define slide animation for question transition
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start from right
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the fade-in effect initially
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> loadQuestions() async {
    setState(() {
      isLoading = true;
      hasError = false;
      errorMessage = '';
    });

    try {
      final fetchedQuestions = await _apiService.getScreeningQuestions();

      setState(() {
        questions = fetchedQuestions;
        selectedOptions =
            List.filled(questions.length, -1); // Initialize with -1
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = 'Gagal memuat pertanyaan. Silakan coba lagi nanti.';
      });
    }
  }

  void nextQuestion() {
    if (selectedOptions[currentQuestionIndex] == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih salah satu jawaban terlebih dahulu'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        _controller.reverse().then((_) {
          setState(() {
            currentQuestionIndex++;
          });
          _controller.forward();
        });
>>>>>>> master
      }
    });
  }

  void previousQuestion() {
    setState(() {
      if (currentQuestionIndex > 0) {
<<<<<<< HEAD
        currentQuestionIndex--;
=======
        _controller.reverse().then((_) {
          setState(() {
            currentQuestionIndex--;
          });
          _controller.forward();
        });
>>>>>>> master
      }
    });
  }

<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return ScreeningPage(
      body: Column(
        children: [
          const SizedBox(height: 22),
          QuestionCard(
            questionText: questions[currentQuestionIndex],
            currentQuestionIndex: currentQuestionIndex,
            totalQuestions: questions.length,
          ),
          const SizedBox(height: 15),
          // Menampilkan CustomRadio untuk setiap pilihan
          CustomRadio(
            label: 'Tidak Pernah',
            groupValue: selectedOptions[currentQuestionIndex],
            onChanged: (value) {
              setState(() {
                selectedOptions[currentQuestionIndex] = value; // Simpan jawaban
              });
            },
          ),
          const SizedBox(height: 17),
          CustomRadio(
            label: 'Jarang',
            groupValue: selectedOptions[currentQuestionIndex],
            onChanged: (value) {
              setState(() {
                selectedOptions[currentQuestionIndex] = value; // Simpan jawaban
              });
            },
          ),
          const SizedBox(height: 17),
          CustomRadio(
            label: 'Cukup Sering',
            groupValue: selectedOptions[currentQuestionIndex],
            onChanged: (value) {
              setState(() {
                selectedOptions[currentQuestionIndex] = value; // Simpan jawaban
              });
            },
          ),
          const SizedBox(height: 17),
          CustomRadio(
            label: 'Sering',
            groupValue: selectedOptions[currentQuestionIndex],
            onChanged: (value) {
              setState(() {
                selectedOptions[currentQuestionIndex] = value; // Simpan jawaban
              });
            },
          ),
          const SizedBox(height: 17),
          CustomRadio(
            label: 'Sangat Sering',
            groupValue: selectedOptions[currentQuestionIndex],
            onChanged: (value) {
              setState(() {
                selectedOptions[currentQuestionIndex] = value; // Simpan jawaban
              });
            },
          ),
          const SizedBox(height: 75),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (currentQuestionIndex > 0)
                Padding(
                  padding: const EdgeInsets.only(left: 27.0), // Jarak dari kiri
                  child: GestureDetector(
                    onTap: previousQuestion,
                    child: const Text(
                      'Kembali',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              const Spacer(), // Memisahkan antara "Kembali" dan "Lanjut"
              Padding(
                padding: const EdgeInsets.only(right: 27.0), // Jarak dari kanan
                child: GestureDetector(
                  onTap: () {
                    if (currentQuestionIndex == questions.length - 1) {
                      // Jika ini adalah pertanyaan terakhir, navigasikan ke HomePage
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  BottomNavbar()),
                      );
                    } else {
                      // Jika belum di pertanyaan terakhir, lanjutkan ke pertanyaan berikutnya
                      nextQuestion();
                    }
                  },
                  child: Text(
                    currentQuestionIndex == questions.length - 1
                        ? 'Selesai'
                        : 'Lanjut',
                    style: const TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
=======
  Future<void> submitSurvey() async {
    if (selectedOptions.contains(-1)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih jawaban untuk semua pertanyaan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final answers = List.generate(questions.length, (index) {
        return {
          'question_id': questions[index].id,
          'selected_option_id': selectedOptions[index],
        };
      });

      final result = await _apiService.submitScreeningAnswers(answers);

      // Print the result to see the actual response from the API

      // Adjust the condition based on the actual response structure
      if (result['status_code'] == 200 ||
          result['message'] == 'Screening submitted successfully') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Terima kasih telah mengisi survey'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavbar()),
        );
      } else {
        // Display error message from API if available
        final errorMessage = result['message'] ?? 'Terjadi kesalahan';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan: $errorMessage'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting survey: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (hasError) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorMessage,
                style: const TextStyle(fontSize: 14, color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: loadQuestions,
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Tidak ada pertanyaan tersedia.")),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.white),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 150,
              decoration: const BoxDecoration(
                color: Color(0xFF8FD7C1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Text(
                    'Screening Sessions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
>>>>>>> master
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
<<<<<<< HEAD
            ],
          )
=======
            ),
          ),
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      QuestionCard(
                        questionText:
                            questions[currentQuestionIndex].questionText,
                        currentQuestionIndex: currentQuestionIndex,
                        totalQuestions: questions.length,
                      ),
                      const SizedBox(height: 15),
                      ...questions[currentQuestionIndex].options.map((option) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10.0), // Adds 10px spacing
                          child: CustomRadio(
                            label: option.optionText,
                            groupValue: selectedOptions[currentQuestionIndex],
                            value: option.id,
                            onChanged: (value) {
                              setState(() {
                                selectedOptions[currentQuestionIndex] = value;
                              });
                            },
                          ),
                        );
                      }).toList(),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (currentQuestionIndex > 0)
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: GestureDetector(
                                onTap: previousQuestion,
                                child: const Text(
                                  'Kembali',
                                  style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: GestureDetector(
                              onTap: () {
                                if (currentQuestionIndex ==
                                    questions.length - 1) {
                                  submitSurvey();
                                } else {
                                  nextQuestion();
                                }
                              },
                              child: Text(
                                currentQuestionIndex == questions.length - 1
                                    ? 'Selesai'
                                    : 'Lanjut',
                                style: const TextStyle(
                                  color: Colors.teal,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
>>>>>>> master
        ],
      ),
    );
  }
}
