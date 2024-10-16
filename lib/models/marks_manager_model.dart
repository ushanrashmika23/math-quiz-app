class MarksManager {
  static int questionCount = 10;
  static int currentQuestion = 1;
  static int totalMarks = 0;
  static int correctMarks = 0;
  static int wrongMarks = 0;
  static int skipMarks = 0;
  static List<Object> history = [];

  static void correctAnswer() {
    correctMarks++;
    totalMarks++;
  }

  static void wrongAnswer() {
    wrongMarks++;
    totalMarks++;
  }

  static void skipAnswer() {
    skipMarks++;
    totalMarks++;
  }

  static bool nextQuestion() {
    if (currentQuestion < questionCount) {
      currentQuestion++;
      return false;
    } else {
      print(currentQuestion);
      return true;
    }
  }

  static void reset() {
    questionCount = 10;
    currentQuestion = 1;
    totalMarks = 0;
    correctMarks = 0;
    wrongMarks = 0;
    skipMarks = 0;
    history = [];
  }
}
