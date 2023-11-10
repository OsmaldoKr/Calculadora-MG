import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorAppHome(),
    );
  }
}

class CalculatorAppHome extends StatefulWidget {
  const CalculatorAppHome({super.key});

  @override
  State<CalculatorAppHome> createState() => _CalculatorAppHomeState();
}

class _CalculatorAppHomeState extends State<CalculatorAppHome> {
  String equation = '0';
  String result = '';
  String expression = '';

  //function for button working

  buttonPresed(btnText) {
    setState(() {
      if (btnText == 'AC') {
        equation = '0';
        result = '';
      } else if (btnText == '⌫') {
        equation = equation.substring(0, equation.length - 1);

        if (equation == '') {
          equation = '0';
        }
      } else if (btnText == '=') {
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          'Error';
        }
      } else {
        if (equation == '0') {
          equation = btnText;
        } else {
          equation = equation + btnText;
        }
      }
    });
  }

  Widget calButtons(
      String btnText, Color txtColor, double btnWidth, Color btnColor) {
    return InkWell(
      onTap: () {
        buttonPresed(btnText);
      },
      child: Container(
        alignment: Alignment.center,
        height: 68,
        width: btnWidth,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          btnText,
          style: TextStyle(
              color: txtColor, fontSize: 25, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 253, 253, 253),
        title: const Text(
          'MG CALCULADORA',
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0), fontSize: 30, fontWeight: FontWeight.normal),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          // display equation value
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerRight,
            height: 90,
            width: double.infinity,
            color: Colors.black,
            child: SingleChildScrollView(
                child: Text(
              equation,
              style: TextStyle(
                color: Colors.deepOrangeAccent[100],
                fontSize: 38,
              ),
            )),
          ),

          const SizedBox(
            height: 20,
          ),
          // display result
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerRight,
            height: 90,
            width: double.infinity,
            color: Colors.black,
            child: SingleChildScrollView(
                child: Text(
              result,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 60,
              ),
            )),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('AC', Colors.white, 80, Colors.deepOrangeAccent[100]!),
                    calButtons('⌫', Colors.white, 80, Colors.white38),
                    calButtons('%', Colors.white, 80, Colors.white38),
                    calButtons('÷', Colors.white, 80, Colors.deepOrangeAccent[100]!),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('7', Colors.white, 80, Colors.white10),
                    calButtons('8', Colors.white, 80, Colors.white10),
                    calButtons('9', Colors.white, 80, Colors.white10),
                    calButtons('x', Colors.white, 80, Colors.deepOrangeAccent[100]!),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('4', Colors.white, 80, Colors.white10),
                    calButtons('5', Colors.white, 80, Colors.white10),
                    calButtons('6', Colors.white, 80, Colors.white10),
                    calButtons(
                        '-', Colors.white, 80, Colors.deepOrangeAccent[100]!),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('1', Colors.white, 80, Colors.white10),
                    calButtons('2', Colors.white, 80, Colors.white10),
                    calButtons('3', Colors.white, 80, Colors.white10),
                    calButtons('+', Colors.white, 80, Colors.deepOrangeAccent[100]!),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('0', Colors.white, 80, Colors.white10),
                    calButtons('.', Colors.white, 80, Colors.white10),
                    calButtons('9', Colors.white, 80, Colors.white10),
                    calButtons('=', Colors.white, 80, Colors.deepOrangeAccent[100]!),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
