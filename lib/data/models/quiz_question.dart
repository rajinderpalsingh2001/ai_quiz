import 'package:ai_quiz/constants/model_constants/quiz_question_constants.dart';

class QuizQuestion {
  int questionId;
  String question;
  List<String> options;
  int answerIndex;
  String explanation;
  String difficulty;

  QuizQuestion(
      {required this.questionId,
      required this.question,
      required this.options,
      required this.answerIndex,
      required this.explanation,
      required this.difficulty});

  factory QuizQuestion.fromJson(int questionId, Map<String, dynamic> json) {
    return QuizQuestion(
      questionId: questionId,
      question: json[QuizQuestionConstants.QUESTION],
      answerIndex: json[QuizQuestionConstants.ANSWER_INDEX],
      options: List<String>.from(json[QuizQuestionConstants.OPTIONS]),
      explanation: json[QuizQuestionConstants.EXPLANATION],
      difficulty: json[QuizQuestionConstants.DIFFICULTY],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      QuizQuestionConstants.QUESTION: question,
      QuizQuestionConstants.ANSWER_INDEX: answerIndex,
      QuizQuestionConstants.OPTIONS: options,
      QuizQuestionConstants.EXPLANATION: explanation,
      QuizQuestionConstants.DIFFICULTY: difficulty
    };
  }
}
