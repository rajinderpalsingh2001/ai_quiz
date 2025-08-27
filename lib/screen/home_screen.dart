import 'package:ai_quiz/controller/ai_controller.dart';
import 'package:ai_quiz/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  AiController aiController = Get.find();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("AI Quiz"),
        ),
        body: bodyContainer(),
      ),
    );
  }

  Widget bodyContainer() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                  child: Text(
                    "Create Quiz for",
                    style: TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: aiController.createQuizExplanation,
                  minLines: 4,
                  maxLines: 6,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    border: InputBorder.none,
                    hintText: "Explain here......",
                    hintStyle:
                        TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This is Required";
                    }
                    return null; //valid
                  },
                ),
              ],
            )),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: PrimaryButton(
                isLoading: isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    await aiController.createQuiz();
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                text: "GENERATE",
              ),
            )
          ],
        ),
      ),
    );
  }
}
