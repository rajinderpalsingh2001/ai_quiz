import 'package:ai_quiz/controller/ai_controller.dart';
import 'package:ai_quiz/controller/exam_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AiController>(AiController());
    Get.put<ExamController>(ExamController());
  }
}
