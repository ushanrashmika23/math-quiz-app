import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quize_app/models/marks_manager_model.dart';
import 'package:quize_app/models/quiz_model.dart';
import 'package:quize_app/pages/result_page.dart';

class QuizPage extends StatefulWidget {
  final Quiz quiz = Quiz();
  String? question;
  QuizPage({super.key}) {
    quiz.generateQuestion();
    question = quiz.getQuestion();
  }

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final inputController = TextEditingController();
  int correct = 0;
  int wrong = 0;
  int skipped = 0;
  int currentQuestion = MarksManager.currentQuestion;
  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  void updateScore() {
    setState(() {
      correct = MarksManager.correctMarks;
      wrong = MarksManager.wrongMarks;
      skipped = MarksManager.skipMarks;
    });
  }

  void newQuestion() {
    // MarksManager.nextQuestion();
    if (MarksManager.nextQuestion()) {
      print("done");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(),
        ),
      );
    } else {
      widget.quiz.generateQuestion();
      setState(() {
        inputController.clear();
        widget.question = widget.quiz.getQuestion();
        updateScore();
      });
    }
  }

  void skipQuestion() {
    widget.quiz.skipQuestion();
    updateScore();
    newQuestion();
  }

  void checkAnswer() {
    if (inputController.text.isNotEmpty) {
      widget.quiz.setAnswer(int.parse(inputController.text));
      int result = widget.quiz.checkAnswer();
      if (result == 1) {
        //print("Correct");
      } else if (result == 2) {
        //print("Wrong");
      } else if (result == 0) {
        //print("Skip");
      }
      updateScore();
      newQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${MarksManager.currentQuestion} Of ${MarksManager.questionCount}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      Text(
                        " $correct",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.info,
                        color: Colors.orange,
                      ),
                      Text(
                        " $skipped",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                      Text(
                        " $wrong",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ])
                  ],
                ),
              ),
              Column(children: [
                Text(
                  widget.question!,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: inputController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        )),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    checkAnswer();
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(Colors.black),
                    foregroundColor:
                        WidgetStatePropertyAll<Color>(Colors.white),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Check Answer",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    skipQuestion();
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(Colors.black),
                    foregroundColor:
                        WidgetStatePropertyAll<Color>(Colors.white),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ]),
              const SizedBox(
                height: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
