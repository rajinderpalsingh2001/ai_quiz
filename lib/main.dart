import 'package:ai_quiz/controller/binding/app_binding.dart';
import 'package:ai_quiz/screen/home_screen.dart';
import 'package:ai_quiz/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      title: "AI Quiz",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      home: HomeScreen(),
    );
  }
}