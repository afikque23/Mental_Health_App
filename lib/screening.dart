import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class ScreeningPage extends StatefulWidget {
  const ScreeningPage({super.key});

  @override
  ScreeningPageState createState() => ScreeningPageState();
}

class ScreeningPageState extends State<ScreeningPage> {
  final _logger = Logger('MoodSurveyScreen'); // Create logger instance

  int currentQuestionIndex = 0;
  String? selectedAnswer; // Menyimpan jawaban yang dipilih

  final List<Map<String, String>> surveyQuestions = [
    {
      "question":
          "Seberapa sering Anda merasa sedih, tertekan, atau putus asa?",
    },
    {
      "question":
          "Seberapa sering Anda mengalami kesulitan untuk tertidur, sulit tertidur, atau terlalu banyak tidur?",
    },
    {
      "question": "Seberapa sering Anda merasa lelah atau kekurangan energi?",
    },
    {
      "question": "Seberapa sering Anda merasa gugup, cemas, atau gelisah?",
    },
    {
      "question":
          "Seberapa sering Anda tidak mampu menghentikan atau mengendalikan rasa khawatir?",
    },
    {
      "question": "Seberapa sering Anda mengalami kesulitan bersantai?",
    },
    {
      "question":
          "Seberapa sering Anda merasa gelisah sehingga sulit untuk duduk diam?",
    },
    {
      "question":
          "Seberapa sering Anda menyadari bahwa Anda tidak mampu mengatasi semua hal yang harus Anda lakukan?",
    },
    {
      "question":
          "Seberapa sering Anda marah karena hal-hal di luar kendali Anda?",
    },
    {
      "question":
          "Seberapa sering Anda merasakan kesulitan yang menumpuk begitu tinggi sampai Anda tidak dapat mengatasinya?",
    },
    {
      "question": "Seberapa sering Anda merasa yakin dengan kemampuan Anda?",
    },
    {
      "question": "Seberapa sering Anda merasa puas dengan diri sendiri?",
    },
    {
      "question":
          "Seberapa sering Anda merasa bahwa Anda memiliki sejumlah sifat baik?",
    },
    {
      "question":
          "Seberapa sering Anda merasa bahwa Anda memiliki seseorang yang dapat Anda mintai dukungan emosional?",
    },
    {
      "question":
          "Seberapa sering Anda merasa menjadi bagian dari suatu komunitas atau kelompok sosial?",
    },
    {
      "question":
          "Seberapa sering kamu merasa ada orang yang benar-benar memahamimu?",
    },
  ];

  void _nextQuestion() {
    if (currentQuestionIndex < surveyQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer =
            null; // Reset jawaban yang dipilih saat berpindah ke pertanyaan berikutnya
      });
    } else {
      // Gunakan logger alih-alih print
      _logger.info('Survei selesai');
    }
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        selectedAnswer =
            null; // Reset jawaban yang dipilih saat berpindah ke pertanyaan sebelumnya
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF68B39F),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 90, 16, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                surveyQuestions[currentQuestionIndex]['question']!,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Colors.white),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 40),
            _buildOptionButton(
                '1. Tidak pernah', selectedAnswer == '1. Tidak pernah'),
            const SizedBox(height: 23),
            _buildOptionButton('2. Jarang', selectedAnswer == '2. Jarang'),
            const SizedBox(height: 23),
            _buildOptionButton(
                '3. Cukup Sering', selectedAnswer == '3. Cukup Sering'),
            const SizedBox(height: 23),
            _buildOptionButton('4. Sering', selectedAnswer == '4. Sering'),
            const SizedBox(height: 23),
            _buildOptionButton(
                '5. Sangat Sering', selectedAnswer == '5. Sangat Sering'),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _previousQuestion,
                  child: const Text(
                    'Kembali',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                        color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: _nextQuestion,
                  child: const Text(
                    'Lanjut',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 20),
      child: SizedBox(
        width: 320,
        height: 53,
        child: ElevatedButton(
          onPressed: () {
            _logger.info('$text dipilih');
            // Mengubah status pilihan
            setState(() {
              selectedAnswer = text; // Mengatur jawaban yang dipilih
            });
          },
          style: ElevatedButton.styleFrom(
            foregroundColor:
                isSelected ? Colors.white : const Color(0xFF5F5F5F),
            backgroundColor:
                isSelected ? const Color(0xFF2D6974) : Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 3,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 15,
              bottom: 15,
              right: 100,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,      
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}