import 'package:ai_quiz/controller/exam_controller.dart';
import 'package:ai_quiz/data/models/quiz_question.dart';
import 'package:ai_quiz/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionsAnswersWidget extends StatelessWidget {
  List<QuizQuestion> questions;
  Function(bool? val, QuizQuestion question, int optionIndex)? onChanged;
  QuestionsAnswersWidget({required this.questions, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return questionTile(question: questions[index]);
        });
  }

  Widget questionTile({required QuizQuestion question}) {
    return Column(
      children: [
        ListTile(
          tileColor: AppTheme.lightWhite,
          leading: Text(question.questionId.toString()),
          title: Text(question.question),
          trailing: Text(question.difficulty),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: _optionsContainer(question: question),
        ),
        if (onChanged == null) explanationContainer(question: question),
        Divider(),
      ],
    );
  }

  Widget explanationContainer({required QuizQuestion question}) {
    return ListTile(
      tileColor: AppTheme.lightWhite,
      title: Text("Explanation"),
      subtitle: Text(question.explanation),
    );
  }

  Widget _optionsContainer({required QuizQuestion question}) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: question.options.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: onChanged == null
                    ? Get.find<ExamController>()
                            .isCorrect(question: question, optionIndex: index)
                        ? Colors.green.shade200
                        : AppTheme.lightWhite : null
            ),
            child: CheckboxListTile(
                tileColor: AppTheme.lightWhite,
                title: Text(question.options[index]),
                value: Get.find<ExamController>()
                    .isMarked(question: question, optionIndex: index),
                onChanged: (val) {
                  if (onChanged != null) {
                    onChanged!(val, question, index);
                  }
                }),
          );
        });
  }
}
