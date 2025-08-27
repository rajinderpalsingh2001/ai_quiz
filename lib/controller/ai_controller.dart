import 'dart:convert';
import 'dart:developer';

import 'package:ai_quiz/constants/gemini_constants.dart';
import 'package:ai_quiz/data/models/quiz_question.dart';
import 'package:ai_quiz/screen/exam_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiController extends GetxController {
  TextEditingController createQuizExplanation = TextEditingController();
  List<QuizQuestion> questions = [];

  String demoQuestions = '''
```json
      {
        "questions": [
          {
            "question": "Which of the following is NOT a fundamental data structure?",
            "options": ["Array", "Linked List", "Tree", "Spreadsheet"],
            "correct_answer": 3,
            "explanation": "Spreadsheets are applications built using data structures, not fundamental data structures themselves.",
            "difficulty": "easy"
          },
          {
            "question": "What is the primary advantage of using a linked list over an array?",
            "options": ["Faster search operations", "More efficient memory usage for frequent insertions/deletions", "Simpler implementation", "Better for random access"],
            "correct_answer": 1,
            "explanation": "Linked lists allow for efficient insertion and deletion of elements without requiring shifting of other elements, unlike arrays.",
            "difficulty": "medium"
          },
          {
            "question": "A binary search tree (BST) is a node-based binary tree data structure which has a property that for every node, the value of the key is greater than or equal to the value of its left subtree and less than or equal to the value of its right subtree. Which of the following operations would be MOST efficient on a balanced BST?",
            "options": ["Insertion", "Deletion", "Search", "All of the above"],
            "correct_answer": 2,
            "explanation": "Search, insertion, and deletion in a balanced BST all have a time complexity of O(log n), but search is generally considered the most efficient because it doesn't require the extra steps of rebalancing (though those steps still have logarithmic time complexity).",
            "difficulty": "medium"
          },
          {
            "question": "Which data structure would be most suitable for implementing a Last-In-First-Out (LIFO) queue?",
            "options": ["Queue", "Stack", "Heap", "Linked List"],
            "correct_answer": 1,
            "explanation": "A stack is inherently a LIFO data structure; the last element added is the first one removed.",
            "difficulty": "easy"
          },
          {
            "question": "Consider a graph represented using an adjacency matrix. What is the space complexity of this representation for a graph with 'V' vertices and 'E' edges?",
            "options": ["O(V)", "O(E)", "O(V+E)", "O(V^2)"],
            "correct_answer": 3,
            "explanation": "An adjacency matrix requires a V x V matrix to represent all possible edges, resulting in O(V^2) space complexity.  However, the question is tricky; if you consider a *sparse* graph with very few edges, the space complexity is dominated by the matrix size, which is O(V^2).",
            "difficulty": "hard"
          },
          {
            "question": "What is the average-case time complexity for searching an element in a sorted array using binary search?",
            "options": ["O(n)", "O(log n)", "O(n^2)", "O(1)"],
            "correct_answer": 1,
            "explanation": "Binary search repeatedly divides the search interval in half, leading to logarithmic time complexity.",
            "difficulty": "medium"
          }
        ]
      }
      ```
''';

  Future createQuiz() async {
    try {
      log("AiController :: createQuiz()");
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: GeminiConstants.API_KEY,
      );

      final prompt = generatePrompt(10);
      final content = [Content.text(prompt)];
      log("AiController :: createQuiz() :: Creating");
      final response = await model.generateContent(content);
      log("AiController :: createQuiz() :: Created");
      String? responseText = response.text;
      // log(responseText ?? '');
      // String responseText = demoQuestions;
      if (responseText != null) {
        responseText = responseText.trim();
        responseText =
            responseText.substring(7, responseText.length - 3).trim();
        Map<String, dynamic> map = jsonDecode(responseText);
        questions =
            (map["questions"] as List<dynamic>).asMap().entries.map((entry) {
          return QuizQuestion.fromJson(entry.key + 1, entry.value);
        }).toList();

        Get.to(() => ExamScreen());
      }
    } catch (e) {
      log("AiController :: createQuiz() :: Error:$e");
    }
  }

  String generatePrompt(int numberOfMCQ) {
    return '''
        You are a professional test agency that specializes in generating high-quality multiple-choice questions (MCQs). Given a topic by the user, you will create a JSON-formatted output containing a list of $numberOfMCQ MCQs. Each question should include four answer choices, one correct answer, and an explanation.

        Generate questions that vary in difficulty (easy, medium, and hard). Ensure they are clear, concise, and relevant to the given topic.

        Output Format (JSON):
        {
          "questions": [
            {
              "question": "<MCQ question text>",
              "options": ["option A", "option B", "option C", "option D"],
              "correct_answer": "<correct option list index>",
              "explanation": "<brief explanation>",
              "difficulty": "<easy | medium | hard>"
            },
            ...
          ]
        }
        Now, generate $numberOfMCQ MCQs for the topic: '${createQuizExplanation.text.trim()}'."
      ''';
  }
}
