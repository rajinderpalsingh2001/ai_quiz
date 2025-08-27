import 'dart:developer';

import 'package:ai_quiz/controller/ai_controller.dart';
import 'package:ai_quiz/controller/exam_controller.dart';
import 'package:ai_quiz/data/models/quiz_question.dart';
import 'package:ai_quiz/screen/result_screen.dart';
import 'package:ai_quiz/widgets/primary_button.dart';
import 'package:ai_quiz/widgets/questions_answers_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  AiController aiController = Get.find();
  ExamController examController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exam mode"),
      ),
      body: bodyContainer(),
    );
  }

  Widget bodyContainer() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: QuestionsAnswersWidget(questions: aiController.questions, onChanged: (val, question, optionIndex) {
                setState(() {
                  examController.toggleResponse(
                      question: question, optionIndex: optionIndex);
                });
              })
            ),
          ),
          if(examController.isTestAllCompleted())
          PrimaryButton(
            isFullWidth: true,
              onPressed: () {
                // if (examController.isTestAllCompleted()) {
                  log("Test Completed answer data is ${examController.examResponse.toString()}");
                  Get.to(() => ResultScreen());
                // }
              },
              text: "Show Result")
        ],
      ),
    );
  }
}
