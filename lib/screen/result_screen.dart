import 'package:ai_quiz/controller/ai_controller.dart';
import 'package:ai_quiz/controller/exam_controller.dart';
import 'package:ai_quiz/data/models/quiz_question.dart';
import 'package:ai_quiz/theme/app_theme.dart';
import 'package:ai_quiz/widgets/questions_answers_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  ExamController examController = Get.find();
  AiController aiController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: bodyContainer(),
    );
  }

  Widget bodyContainer() {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              "You got ${examController.numberOfCorrectAnswers()}/${aiController.questions.length}"),
          Text("You got ${examController.getResultPercentage()}%"),
          Expanded(
              child: SingleChildScrollView(child: questionResultsContainer())),
        ],
      ),
    );
  }

  Widget questionResultsContainer() {
    return QuestionsAnswersWidget(questions: aiController.questions);
  }
}
