import 'Questions.dart';

class QuesBrain {
  int _number = 0;
  List<Questions> _reflist = [
    Questions('You can lead a cow down stairs but not up stairs.', false),
    Questions(
        'Approximately one quarter of human bones are in the feet.', true),
    Questions('A slug\'s blood is green.', true),
  ];

  String getQuestion() {
    return _reflist[_number].ques;
  }

  bool nextQuestion() {
    if (_number < _reflist.length - 1) {
      _number++;
      return true;
    } else
      return false;
  }

  bool getAnswer() {
    return _reflist[_number].ans;
  }

  void resetall() {
    _number = 0;
  }
}
