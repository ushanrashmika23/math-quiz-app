import 'dart:math';

import 'package:quize_app/models/marks_manager_model.dart';

class Quiz {
  Quiz();

  String? _question;
  int? _num1;
  int? _num2;
  int? _answer;
  int? _userAnswer;
  int? _choice;
  void generateQuestion() {
    //MarksManager.nextQuestion();
    final choice = Random().nextInt(3);
    _choice = choice;
    int num1 = Random().nextInt(100);
    int num2 = Random().nextInt(100);
    switch (choice) {
      case 0:
        _question = '$num1 + $num2 = ?';
        _num1 = num1;
        _num2 = num2;
        _answer = num1 + num2;
        break;
      case 1:
        _question = '$num1 - $num2 = ?';
        _num1 = num1;
        _num2 = num2;
        _answer = num1 - num2;
        break;
      case 2:
        int num3 = Random().nextInt(10);
        _question = '$num1 * $num3 = ?';
        _num1 = num1;
        _num2 = num3;
        _answer = num1 * num3;
        break;
    }
  }

  void setAnswer(int userAnswer) {
    _userAnswer = userAnswer;
  }

  String getQuestion() {
    return _question!;
  }

  int getAnswer() {
    return _answer!;
  }

  int getUserAnswer() {
    return _userAnswer!;
  }

  void skipQuestion() {
    final questionData = {
      "question": _question,
      "answer": _answer,
      "userAnswer": "",
      "num1": _num1,
      "num2": _num2,
      "choice": _choice
    };

    MarksManager.history.add(questionData);
    MarksManager.skipAnswer();
  }

  int getSkippedCount() {
    return MarksManager.skipMarks;
  }

  int getCorrectCount() {
    return MarksManager.correctMarks;
  }

  int getWrongCount() {
    return MarksManager.wrongMarks;
  }

  int checkAnswer() {
    final questionData = {
      "question": _question,
      "answer": _answer,
      "userAnswer": _userAnswer,
      "num1": _num1,
      "num2": _num2,
      "choice": _choice
    };

    MarksManager.history.add(questionData);

    if (_userAnswer == null) {
      MarksManager.skipAnswer();
      return 0;
    } else if (_userAnswer == _answer) {
      MarksManager.correctAnswer();
      return 1;
    } else if (_userAnswer != _answer) {
      MarksManager.wrongAnswer();
      return 2;
    } else {
      return -1;
    }
  }
}

// void main() {
//   while (true) {
//     String? inpt = stdin.readLineSync();
//     if (inpt != null) {
//       Quize q = Quize();
//       q.generateQuestion();
//       q.setAnswer(10);
//       q.checkAnswer();
//       print(q.getQuestion());
//       print(MarksManager.history);
//     }
//   }
// }
