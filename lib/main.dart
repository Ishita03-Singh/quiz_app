import 'package:flutter/material.dart';
import 'package:quizzler/Questions.dart';
import 'package:quizzler/ques_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper = [];
  QuesBrain ques_helper = new QuesBrain();

  void checkcorrectness(bool user_ans) {
    bool ans = ques_helper.getAnswer();
    if (ans == user_ans) {
      setState(() {
        scorekeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      });
    } else {
      setState(() {
        scorekeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      });
    }
    bool is_next = ques_helper.nextQuestion();
    if (is_next == false)
      Alert(
        context: context,
        type: AlertType.info,
        title: "Quizzler",
        desc: "This quiz is finished.",
        buttons: [
          DialogButton(
            child: Text(
              "RESET",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                ques_helper.resetall();
                scorekeeper.clear();
              });
              Navigator.of(context, rootNavigator: true).pop();
            },
            width: 120,
          )
        ],
      ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                ques_helper.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkcorrectness(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkcorrectness(false);
              },
            ),
          ),
        ),
        Expanded(
            child: Row(
          children: scorekeeper,
        )),
      ],
    );
  }
}/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
