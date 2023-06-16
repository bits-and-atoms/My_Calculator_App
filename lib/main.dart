//By Subham Majumder 2212020
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math; //for using math
//i used math_expressions for handling calculations,
// in this calculator i just collected the mathematical expression and processed it and fed it to math_expressions

void main() {
  runApp(const SubhamKaCalculator());
}

class SubhamKaCalculator extends StatelessWidget {
  const SubhamKaCalculator({super.key, Key? key1});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Subham's (2212020) Calculator",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const CalculatorMainScreen(),
    );
  }
}

class CalculatorMainScreen extends StatefulWidget {
  const CalculatorMainScreen({super.key, Key? key2});

  @override
  State<CalculatorMainScreen> createState() => StateOfScreen();
}

class StateOfScreen extends State<CalculatorMainScreen> {
  String inputText = '';
  String resultText = '';
  String auxilaryText = '';
  bool forNewButtons = true;
  bool isRADIAN = true;
  void toggleNewButton() {
    setState(() {
      forNewButtons = !forNewButtons;
    });
  }

  void toggleFORdegree() {
    setState(() {
      isRADIAN = !isRADIAN;
    });
  }

  void addToInputText(String text) {
    String notUpdate = text;

    if (!isRADIAN && (text == 'sin(' || text == 'cos(' || text == 'tan(')) {
      text += '(π/180)*';//my way to convert the radian to degree. Facing some issues with tan 45 degrees or tan pi/4 radian.
    }
    setState(() {
      auxilaryText += notUpdate;
      inputText += text;
    });
  }

  void clearInput() {
    setState(() {
      inputText = '';
      resultText = '';
      auxilaryText = '';
    });
  }

  void oneCharacterDeletion() {
    setState(() {
      if (inputText.isNotEmpty) {
        inputText = inputText.substring(0, inputText.length - 1);
        auxilaryText = auxilaryText.substring(0, auxilaryText.length - 1);
      }
    });
  }

  void _calculateResult() {
    try {
      Parser parser = Parser();
      ContextModel contextModel = ContextModel();
      
      inputText = inputText.replaceAll('÷', '/');//as for evaluation / is used not ÷
      inputText = inputText.replaceAll('x', '*');//as for evaluation * is used not x
      inputText = inputText.replaceAll('√', 'sqrt');//as for evaluation sqrt is used not √
      inputText = inputText.replaceAll('π', '${math.pi}');//as for evaluation value of pi is used not π
      
      Expression expression = parser.parse(inputText);
      double result = expression.evaluate(EvaluationType.REAL, contextModel);
      setState(() {
        resultText = result.toString();
      });
    } catch (e) {
      setState(() {
        resultText = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Subham's (2212020) Calculator",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    auxilaryText,
                    style: const TextStyle(
                        fontSize: 24, color: Color.fromARGB(255, 3, 13, 220)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    resultText,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 13, 115, 4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TheButton(
                text: 'AC',
                onPressed: clearInput,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              ),
              TheButton(
                text: '⌫',//found this symbol in internet 
                onPressed: oneCharacterDeletion,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              ),
              TheButton(
                text: '(',
                onPressed: () => addToInputText('('),
                backgroundColor: Colors.orange,
              ),
              TheButton(
                text: ')',
                onPressed: () => addToInputText(')'),
                backgroundColor: Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TheButton(
                text: '7',
                onPressed: () => addToInputText('7'),
                backgroundColor: Colors.grey,
              ),
              TheButton(
                text: '8',
                onPressed: () => addToInputText('8'),
                backgroundColor: Colors.grey,
              ),
              TheButton(
                text: '9',
                onPressed: () => addToInputText('9'),
                backgroundColor: Colors.grey,
              ),
              forNewButtons
                  ? TheButton(
                      text: '÷',
                      onPressed: () => addToInputText('÷'),
                      backgroundColor: Colors.orange,
                    )
                  : TheButton(
                      text: 'sin',
                      onPressed: () => addToInputText('sin('),
                      backgroundColor: Colors.orange,
                    ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TheButton(
                text: '4',
                onPressed: () => addToInputText('4'),
                backgroundColor: Colors.grey,
              ),
              TheButton(
                text: '5',
                onPressed: () => addToInputText('5'),
                backgroundColor: Colors.grey,
              ),
              TheButton(
                text: '6',
                onPressed: () => addToInputText('6'),
                backgroundColor: Colors.grey,
              ),
              forNewButtons
                  ? TheButton(
                      text: 'x',
                      onPressed: () => addToInputText('x'),
                      backgroundColor: Colors.orange,
                      textColor: Colors.white,
                    )
                  : TheButton(
                      text: 'cos',
                      onPressed: () => addToInputText('cos('),
                      backgroundColor: Colors.orange,
                      textColor: Colors.white,
                    ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TheButton(
                text: '1',
                onPressed: () => addToInputText('1'),
                backgroundColor: Colors.grey,
              ),
              TheButton(
                text: '2',
                onPressed: () => addToInputText('2'),
                backgroundColor: Colors.grey,
              ),
              TheButton(
                text: '3',
                onPressed: () => addToInputText('3'),
                backgroundColor: Colors.grey,
              ),
              forNewButtons
                  ? TheButton(
                      text: '-',
                      onPressed: () => addToInputText('-'),
                      backgroundColor: Colors.orange,
                    )
                  : TheButton(
                      text: 'tan',
                      onPressed: () => addToInputText('tan('),
                      backgroundColor: Colors.orange,
                    ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TheButton(
                text: '0',
                onPressed: () => addToInputText('0'),
                backgroundColor: Colors.grey,
              ),
              TheButton(
                text: '^',
                onPressed: () => addToInputText('^'),
                backgroundColor: Colors.orange,
              ),
              TheButton(
                text: '√',
                onPressed: () => addToInputText('√'),
                backgroundColor: Colors.orange,
              ),
              forNewButtons
                  ? TheButton(
                      text: '+',
                      onPressed: () => addToInputText('+'),
                      backgroundColor: Colors.orange,
                      textColor: Colors.white,
                    )
                  : isRADIAN
                      ? TheButton(
                          text: 'rad',
                          onPressed: () => toggleFORdegree(),
                          backgroundColor: Colors.orange,
                          textColor: Colors.white,
                        )
                      : TheButton(
                          text: 'deg',
                          onPressed: () => toggleFORdegree(),
                          backgroundColor: Colors.orange,
                          textColor: Colors.white,
                        )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              forNewButtons
                  ? TheButton(
                      text: 'more',
                      onPressed: toggleNewButton,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                    )
                  : TheButton(
                      text: 'back',
                      onPressed: toggleNewButton,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                    ),
              TheButton(
                text: 'π',
                onPressed: () => addToInputText('π'),
                backgroundColor: Colors.blue,
                textColor: Colors.white,
              ),
              TheButton(
                text: '.',
                onPressed: () => addToInputText('.'),
                backgroundColor: Colors.blue,
                textColor: Colors.white,
              ),
              TheButton(
                text: '=',
                onPressed: _calculateResult,
                backgroundColor: const Color.fromARGB(255, 26, 121, 5),
                textColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TheButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  const TheButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.grey,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.all(16),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: textColor),
        ),
      ),
    );
  }
}
