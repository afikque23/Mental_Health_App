class AnswerOption {
  final int id;
  final String optionText;
  final int score; // Changed from 'value' to 'score'

  AnswerOption({
    required this.id,
    required this.optionText,
    required this.score, // Initialize score
  });

  factory AnswerOption.fromJson(Map<String, dynamic> json) {
    try {
      // Safely parse 'id' ensuring it's an integer
      final id = json['id_answer'] is String
          ? int.parse(json['id_answer'])
          : json['id_answer'] as int;

      // Optionally, provide a fallback for missing 'option_text'
      final optionText = json['option_text'] ?? 'No option text available';

      // Handle 'score' carefully, cast it based on its type
      final score = _parseScore(json['score']);

      return AnswerOption(id: id, optionText: optionText, score: score);
    } catch (e) {
      // Handle any parsing errors
      print('Error parsing AnswerOption: $e');
      throw Exception('Error parsing AnswerOption: $e\nJSON: $json');
    }
  }

  // Helper method to safely parse score
  static dynamic _parseScore(dynamic score) {
    if (score == null) {
      return 0; // Default to 0 if score is null
    } else if (score is int || score is double) {
      return score; // Return numeric score as is
    } else if (score is String) {
      return int.tryParse(score) ?? 0; // Parse as int if it's a string
    } else {
      return 0; // Fallback to 0 for unsupported types
    }
  }

  @override
  String toString() {
    return 'AnswerOption(id: $id, optionText: $optionText, score: $score)';
  }
}
