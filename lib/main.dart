import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../colors/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Ubuntu',
      ),
      home: const CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 36.0;

  onButtonClick(value) {
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "C") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
      }
    } else {
      input = input + value;
      hideInput = false;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var outputSize = 36.0;

    return Scaffold(
      backgroundColor: bColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Text('Flutter Calculator App'),
      ),
      body: Column(
        children: [
          //input and output area
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12.0),
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    output,
                    style: const TextStyle(
                      color: bgColor,
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    hideInput ? '' : input,
                    style: TextStyle(
                      color: bgColor.withOpacity(0.7),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),

          //button Area
          Row(
            children: [
              button(text: 'AC', tColors: yColor),
              button(text: 'C'),
              button(text: '%'),
              button(text: '/'),
            ],
          ),

          Row(
            children: [
              button(text: '7'),
              button(text: '8'),
              button(text: '9'),
              button(text: 'x'),
            ],
          ),

          Row(
            children: [
              button(text: '4'),
              button(text: '5'),
              button(text: '7'),
              button(text: '-'),
            ],
          ),

          Row(
            children: [
              button(text: '1'),
              button(text: '2'),
              button(text: '3'),
              button(text: '+'),
            ],
          ),

          Row(
            children: [
              button(text: '0'),
              button(text: '.'),
              button(text: '=', tColors: yColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({
    text,
    tColors = Colors.white,
    buttonbgColor = bgColor,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(7.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(20.0),
            backgroundColor: buttonbgColor,
          ),
          onPressed: () {
            onButtonClick(text);
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: tColors,
            ),
          ),
        ),
      ),
    );
  }
}
