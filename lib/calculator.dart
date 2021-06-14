import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  var ans = "";
  Widget btns(var val) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            ans = ans + val;
          });
        },
        child: Text(val));
  }

  Widget sBox() {
    return SizedBox(
      width: 10,
    );
  }

  answerFunc() {
    Parser p = Parser();
    Expression exp = p.parse(ans);
    ContextModel cmodel = ContextModel();
    double finAns = exp.evaluate(EvaluationType.REAL, cmodel);
    setState(() {
      ans = finAns.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculator',
          style: TextStyle(
              fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(top: 14),
              width: MediaQuery.of(context).size.width * 0.90,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.red,
                    width: 4,
                  )),
              child: Text(
                ans,
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                btns('7'),
                btns('8'),
                btns('9'),
                btns('+'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                btns('4'),
                btns('5'),
                btns('6'),
                btns('-'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                btns('1'),
                btns('2'),
                btns('3'),
                btns('*'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ans = "";
                      });
                    },
                    child: Text('C')),
                btns('0'),
                ElevatedButton(onPressed: answerFunc, child: Text('=')),
                btns('/'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
