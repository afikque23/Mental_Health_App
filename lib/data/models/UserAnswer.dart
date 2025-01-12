class UserAnswer {
  final int idUser;
  final int idQuestion;
  final int idAnswer;
  final int screeningResultId;

  UserAnswer({
    required this.idUser,
    required this.idQuestion,
    required this.idAnswer,
    required this.screeningResultId,
  });

  factory UserAnswer.fromJson(Map<String, dynamic> json) {
    return UserAnswer(
      idUser: json['id_user'],
      idQuestion: json['id_question'],
      idAnswer: json['id_answer'],
      screeningResultId: json['screening_result_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_user': idUser,
      'id_question': idQuestion,
      'id_answer': idAnswer,
      'screening_result_id': screeningResultId,
    };
  }
}
