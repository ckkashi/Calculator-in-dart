import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:sizer/sizer.dart';

class Calculator2Screen extends StatefulWidget {
  @override
  _Calculator2ScreenState createState() => _Calculator2ScreenState();
}

class _Calculator2ScreenState extends State<Calculator2Screen> {
  var oldVal = "";
  var newVal = "";
  var txt = TextEditingController();
  var oldTxt = TextEditingController();

  var btnColors = [Colors.grey[600], Colors.red[800], Colors.blue];

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GestureDetector(
        onTap: () {
          FocusScopeNode currentScope = FocusScope.of(context);
          if (!currentScope.hasPrimaryFocus) {
            currentScope.unfocus();
          } else {
            currentScope.unfocus();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('Calculator',
                style: TextStyle(
                  fontSize: 18.sp,
                )),
            centerTitle: true,
          ),
          body: Container(
            height: 100.h,
            width: 100.w,
            color: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      width: 100.w,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: TextField(
                                readOnly: true,
                                style: TextStyle(fontSize: 20.sp),
                                decoration: InputDecoration(
                                  hintText: '',
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                controller: oldTxt,
                                cursorHeight: 9.h,
                                maxLines: 1,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Center(
                                child: TextField(
                                  readOnly: true,
                                  style: TextStyle(fontSize: 40.sp),
                                  decoration: InputDecoration(
                                    hintText: '0',
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  controller: txt,
                                  cursorHeight: 9.h,
                                  maxLines: 1,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                Expanded(
                    flex: 4,
                    child: Container(
                      width: 100.w,
                      color: Colors.green,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 60.h,
                                color: Colors.blue,
                                child: Column(
                                  children: [
                                    cBtnContainer('C', btnColors[1]),
                                    btnContainer('7', btnColors[0]),
                                    btnContainer('4', btnColors[0]),
                                    btnContainer('1', btnColors[0]),
                                    btnContainer(".", btnColors[0]),
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 60.h,
                                color: Colors.red,
                                child: Column(
                                  children: [
                                    acBtnContainer('AC', btnColors[2]),
                                    btnContainer('8', btnColors[0]),
                                    btnContainer('5', btnColors[0]),
                                    btnContainer('2', btnColors[0]),
                                    btnContainer("0", btnColors[0]),
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 100.h,
                                color: Colors.orange,
                                child: Column(
                                  children: [
                                    btnContainer('/', btnColors[2]),
                                    btnContainer('9', btnColors[0]),
                                    btnContainer('6', btnColors[0]),
                                    btnContainer('3', btnColors[0]),
                                    btnContainer("00", btnColors[0]),
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 60.h,
                                color: Colors.blue,
                                child: Column(
                                  children: [
                                    btnContainer('*', btnColors[2]),
                                    btnContainer('-', btnColors[2]),
                                    btnContainer('+', btnColors[2]),
                                    equalBtnContainer('=', btnColors[1])
                                  ],
                                ),
                              )),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget acBtnContainer(var val, var bgColor) {
    return Expanded(
        flex: 1,
        child: Container(
          width: 25.w,
          child: TextButton(
              onPressed: () {
                print('working ac');
                setState(() {
                  newVal = "";
                  oldVal = "";
                  txt.text = newVal;
                  oldTxt.text = oldVal;
                });
              },
              child: Text(
                val,
                style: TextStyle(fontSize: 15.sp, color: Colors.white),
              )),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(
                color: Colors.black, width: 2, style: BorderStyle.solid),
          ),
        ));
  }

  Widget cBtnContainer(var val, var bgColor) {
    return Expanded(
        flex: 1,
        child: Container(
          width: 25.w,
          child: TextButton(
              onPressed: () {
                String chk;
                if (newVal != null) {
                  chk = newVal.substring(0, newVal.length - 1);

                  setState(() {
                    newVal = chk;
                    txt.text = newVal;
                  });
                }
              },
              child: Text(
                val,
                style: TextStyle(fontSize: 15.sp, color: Colors.white),
              )),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(
                color: Colors.black, width: 2, style: BorderStyle.solid),
          ),
        ));
  }

  Widget equalBtnContainer(var val, var bgColor) {
    return Expanded(
        flex: 2,
        child: Container(
          width: 25.w,
          child: TextButton(
              onPressed: () {
                print('working =');
                setState(() {
                  oldVal = newVal;
                  Parser p = Parser();
                  Expression exp = p.parse(newVal);
                  ContextModel cms = ContextModel();
                  double ans = exp.evaluate(EvaluationType.REAL, cms);
                  newVal = ans.toString();
                  txt.text = newVal;
                  oldTxt.text = oldVal;
                });
              },
              child: Text(
                val,
                style: TextStyle(fontSize: 15.sp, color: Colors.white),
              )),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(
                color: Colors.black, width: 2, style: BorderStyle.solid),
          ),
        ));
  }

  Widget btnContainer(var val, var bgColor) {
    return Expanded(
        flex: 1,
        child: Container(
          width: 25.w,
          child: numBtn(val),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(
                color: Colors.black, width: 2, style: BorderStyle.solid),
          ),
        ));
  }

  Widget numBtn(var num) {
    return TextButton(
        onPressed: () {
          setState(() {
            newVal += num;
            txt.text = newVal;
          });
        },
        child: Text(
          num,
          style: TextStyle(fontSize: 15.sp, color: Colors.white),
        ));
  }
}
