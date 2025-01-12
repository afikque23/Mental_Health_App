import 'package:flutter/material.dart';
import 'package:mental_health_app/common/widgets/appbar/bottom_navbar.dart';
import 'package:mental_health_app/services/api_service.dart';
import 'package:mental_health_app/data/models/ScreeningQuestion.dart';
import 'package:mental_health_app/common/widgets/customRadio/custom_radio.dart';
import 'package:mental_health_app/common/widgets/questionCard/question_card.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
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
      }
    });
  }

  void previousQuestion() {
    setState(() {
      if (currentQuestionIndex > 0) {
        _controller.reverse().then((_) {
          setState(() {
            currentQuestionIndex--;
          });
          _controller.forward();
        });
      }
    });
  }

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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
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
        ],
      ),
    );
  }
}
