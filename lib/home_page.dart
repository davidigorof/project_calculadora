import 'package:calculator_app/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '+',
    '3',
    '2',
    '1',
    '-',
    '',
    '0',
    '.',
    '='
  ];

  String finalQuestion;
  var question = '';
  var answer = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      body: Column(
        children: [
          Flexible(
              child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: ListView(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 50),
                        alignment: Alignment.centerRight,
                        child: Text(
                          question,
                          style: TextStyle(fontSize: 30, color: Colors.black45),
                        )),
                    SizedBox(height: 20),
                    Container(alignment: Alignment.bottomRight, child: Text(answer, style: TextStyle(fontSize: 40, color: Colors.black45))),
                  ],
                ),
              ]),
            ),
          )),
          Flexible(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                child: Container(
                  color: Colors.blue[200],
                  child: Stack(children: [
                    GridView.builder(
                        itemCount: buttons.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {
                          // Reset
                          if (index == 0) {
                            return MyButtons(
                              buttonTap: () {
                                setState(() {
                                  question = '';
                                  answer = '0';
                                });
                              },
                              textButton: buttons[index],
                              color: Colors.blue,
                              textColor: Colors.yellow,
                            );
                          }

                          // Delete
                          else if (index == 1) {
                            return MyButtons(
                              textButton: buttons[index],
                              color: Colors.blue,
                              textColor: Colors.white,
                              buttonTap: () {
                                setState(() {
                                  question = question.substring(0, question.length - 1);
                                });
                              },
                            );
                          }

                          // Equal
                          else if (index == buttons.length - 1) {
                            return MyButtons(
                              textButton: buttons[index],
                              color: Colors.blue,
                              textColor: Colors.white,
                              buttonTap: () {
                                setState(() {
                                  equalPressed();
                                });
                              },
                            );
                          } else if (index == buttons.length - 4) {
                            return MyButtons(
                              textButton: buttons[index],
                              color: Colors.transparent,
                              textColor: Colors.white,
                              buttonTap: () {
                                setState(() {});
                              },
                            );
                          } else {
                            return MyButtons(
                              textButton: buttons[index],
                              color: isOperator(buttons[index]) ? Colors.teal : Colors.white12,
                              textColor: Colors.white,
                              buttonTap: () {
                                setState(() {
                                  question += buttons[index];
                                });
                              },
                            );
                          }
                        }),
                    Align(alignment: Alignment(-0.85, 0.87), child: IconButton(icon: Icon(Icons.more_horiz, color: Colors.white, size: 24), onPressed: () => showToast('There is no function yet', gravity: Toast.BOTTOM, duration: 2)))
                  ]),
                ),
              ))
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '+' || x == '-' || x == '%' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    finalQuestion = question;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answer = '= ' + eval.toString();

    // if(answer.length > 12) {
    //   answer = answer.substring(0, 13);
    // // } else {
    //   answer = answer;
    // }
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity, backgroundColor: Colors.pink[300]);
  }
}
