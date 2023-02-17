import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'QuestionList/Questionlist.dart';

QuestionBank questionBank = QuestionBank();

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuizApp(),
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  //int questionNo=questionBank.QuestionList.length;
  // IconData icon=Icons.ice_skating;
  List<Widget> iconlist = [];
  int noOfCorrect = 0;
  int noOfFalse = 0;

  void nextQuestion() {
    if (questionBank.questionCount < questionBank.QuestionList.length - 1) {
      questionBank.questionCount++;
    } else {
      getAlert(context, noOfCorrect, noOfFalse);
      questionBank.questionCount = 0;
      noOfFalse = 0;
      noOfCorrect = 0;
      iconlist = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                child: Text(
                  questionBank.getQuestion(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (questionBank.getAnswer() == true) {
                      print('got correct');
                      noOfCorrect++;
                      iconlist.add(Icon(Icons.check, color: Colors.green));
                    } else {
                      noOfFalse++;
                      print('got incorrect');
                      iconlist.add(Icon(Icons.close, color: Colors.red));
                    }
                    nextQuestion();
                  });
                },
                child: Mycontainer('True', Colors.blue, context),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (questionBank.getAnswer() == false) {
                      print('got correct');
                      noOfCorrect++;
                      iconlist.add(Icon(Icons.check, color: Colors.green));
                    } else {
                      print('got incorrect');
                      noOfFalse++;
                      iconlist.add(Icon(
                        Icons.close,
                        color: Colors.red,
                      ));
                    }

                    nextQuestion();
                  });
                },
                child: Mycontainer('False', Colors.red, context),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: iconlist,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Mycontainer(String buttonTxt, Color clr, BuildContext context) {
  return Container(
    height: 60,
    width: MediaQuery
        .of(context)
        .size
        .width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: clr,
    ),
    child: Center(
        child: Text(
          buttonTxt,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
  );
}



void getAlert(BuildContext context, int nooFcorrect, int nooFincorrect) {
  Alert(
      context: context,
      title: "Finished",
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Text('No Of Correct: $nooFcorrect', style: TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text('No 0f InCorrect: $nooFincorrect', style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),)

        ],
      ),
      desc: "you have reached the end of the quiz.")
      .show();
}
