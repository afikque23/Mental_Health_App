// ignore_for_file: file_names, avoid_print

import 'AnswerOption.dart';

class ScreeningQuestion {
  final int id;
  final String category;
  final String questionText;
  final List<AnswerOption> options;

  ScreeningQuestion({
    required this.id,
    required this.category,
    required this.questionText,
    required this.options,
  });

  factory ScreeningQuestion.fromJson(Map<String, dynamic> json) {
    try {
      // Parse id
      final id = json['id'] is String ? int.parse(json['id']) : json['id'];

      // Parse category with a fallback
      final category = json['category'] ?? 'No category';

      // Parse questionText with a fallback
      final questionText =
          json['question_text'] ?? 'No question text available';

      // Parse options
      if (json['options'] == null || json['options'] is! List) {
        throw Exception('Options are required and must be a List');
      }

      final List<dynamic> optionsList = json['options'];
      final List<AnswerOption> options = optionsList.map((optionJson) {
        return AnswerOption.fromJson(optionJson);
      }).toList();

      return ScreeningQuestion(
        id: id,
        category: category,
        questionText: questionText,
        options: options,
      );
    } catch (e) {
      print('Error parsing ScreeningQuestion: $e');
      throw Exception('Error parsing ScreeningQuestion: $e\nJSON: $json');
    }
  }

  @override
  String toString() {
    return 'ScreeningQuestion(id: $id, category: $category, questionText: $questionText, options: $options)';
  }
}
