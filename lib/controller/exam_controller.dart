import 'dart:developer';

import 'package:ai_quiz/controller/ai_controller.dart';
import 'package:ai_quiz/data/models/quiz_question.dart';
import 'package:get/get.dart';

class ExamController extends GetxController {
  AiController aiController = Get.find();
  //{questionId: userMarkedOptionIndex, .......}
  Map<int, int> examResponse = {};

  void addResponse({required QuizQuestion question, required int optionIndex}) {
    examResponse.putIfAbsent(question.questionId, () => -1);
    examResponse[question.questionId] = optionIndex;
  }

  void removeResponse(int questionId) {
    examResponse.remove(questionId);
  }

  bool isMarked({required QuizQuestion question, required int optionIndex}) {
    return examResponse[question.questionId] != null &&
        optionIndex == examResponse[question.questionId];
  }

  void toggleResponse(
      {required QuizQuestion question, required int optionIndex}) {
    if (examResponse[question.questionId] != null &&
        examResponse[question.questionId] == optionIndex) {
      removeResponse(question.questionId);
    } else {
      addResponse(question: question, optionIndex: optionIndex);
    }
    log(examResponse.toString());
  }

  bool isTestAllCompleted() {
    return examResponse.length == aiController.questions.length;
  }

  int numberOfCorrectAnswers() {
    int correctCount = 0;
    for (QuizQuestion question in aiController.questions) {
      if (examResponse[question.questionId] != null &&
          examResponse[question.questionId]! == question.answerIndex) {
        correctCount++;
      }
    }
    return correctCount;
  }

  bool isCorrect({required QuizQuestion question, required int optionIndex}) {
    return optionIndex == question.answerIndex;
  }

  double getResultPercentage() {
    int totalQuestions = aiController.questions.length;
    int correctCount = numberOfCorrectAnswers();
    return ((correctCount / totalQuestions) * 100).toPrecision(2);
  }
}
