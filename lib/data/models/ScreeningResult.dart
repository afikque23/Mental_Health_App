// ignore: file_names
import 'package:mental_health_app/data/models/UserAnswer.dart';

class ScreeningResult {
  final int idResult;
  final int idUser;
  final int totalUser;
  final int depresionScore;
  final int anxietyScore;
  final int stressScore;
  final DateTime screeningDate;
  final int idQuestions;
  final int idUserAnswer;
  final List<UserAnswer>? userAnswers;

  ScreeningResult({
    required this.idResult,
    required this.idUser,
    required this.totalUser,
    required this.depresionScore,
    required this.anxietyScore,
    required this.stressScore,
    required this.screeningDate,
    required this.idQuestions,
    required this.idUserAnswer,
    this.userAnswers,
  });

  factory ScreeningResult.fromJson(Map<String, dynamic> json) {
    return ScreeningResult(
      idResult: json['id_result'] ?? 0,
      idUser: json['id_user'] ?? 0,
      totalUser: json['total_user'] ?? 0,
      depresionScore: json['depresion_score'] ?? 0,
      anxietyScore: json['anxiety_score'] ?? 0,
      stressScore: json['stress_score'] ?? 0,
      screeningDate: json['screening_date'] != null
          ? DateTime.parse(json['screening_date'])
          : DateTime.now(),
      idQuestions: json['id_questions'] ?? 0,
      idUserAnswer: json['id_user_answer'] ?? 0,
      userAnswers: (json['user_answers'] as List<dynamic>?)
          ?.map((e) => UserAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_result': idResult,
      'id_user': idUser,
      'total_user': totalUser,
      'depresion_score': depresionScore,
      'anxiety_score': anxietyScore,
      'stress_score': stressScore,
      'screening_date': screeningDate.toIso8601String(),
      'id_questions': idQuestions,
      'id_user_answer': idUserAnswer,
      'user_answers': userAnswers?.map((e) => e.toJson()).toList(),
    };
  }
}
