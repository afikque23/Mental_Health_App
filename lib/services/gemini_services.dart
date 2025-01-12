// lib/services/gemini_service.dart

import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const apiKey = "AIzaSyCdzOnI2bb7V7_y2nNUH32dmLT5WA1Tjk0";
  late GenerativeModel model;

  GeminiService() {
    model = GenerativeModel(
      model: 'gemini-1.5-flash-8b',
      apiKey: apiKey,
    );
  }

  Future<String> getResponse(String userStory) async {
    try {
      final prompt = '''
      Berikut adalah cerita pengalaman seseorang, tolong berikan saran yang membangun dan mendukung:
      $userStory
      
      Berikan respon yang empatik dan saran yang konstruktif dalam bahasa Indonesia yang mudah dipahami.
      ''';

      final content = Content.text(prompt);
      final response = await model.generateContent([content]);

      return response.text ?? "Maaf, tidak dapat memberikan respons saat ini.";
    } catch (e) {
      return "Terjadi kesalahan: $e";
    }
  }
}
