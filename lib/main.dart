import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _output = '';

  void _onPressed(String value) {
    setState(() {
      _input += value;
    });
  }

  void _clear() {
    setState(() {
      _input = '';
      _output = '';
    });
  }

  void _calculate() {
    try {
      _output = _evaluateExpression(_input);
    } catch (e) {
      _output = 'Erro';
    }
    setState(() {});
  }

  String _evaluateExpression(String expression) {
    try {
      // Cria uma expressão a partir da string recebida
      final exp = Expression.parse(expression);

      // Calcula o valor da expressão
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(exp, {});

      // Retorna o resultado da avaliação
      return result.toString();
    } catch (e) {
      // Em caso de erro, retorna "Erro"
      return 'Erro';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              _input,
              style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              _output,
              style: const TextStyle(fontSize: 24.0),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                String buttonText;
                switch (index) {
                  case 0:
                    buttonText = '7';
                    break;
                  case 1:
                    buttonText = '8';
                    break;
                  case 2:
                    buttonText = '9';
                    break;
                  case 3:
                    buttonText = '/';
                    break;
                  case 4:
                    buttonText = '4';
                    break;
                  case 5:
                    buttonText = '5';
                    break;
                  case 6:
                    buttonText = '6';
                    break;
                  case 7:
                    buttonText = '*';
                    break;
                  case 8:
                    buttonText = '1';
                    break;
                  case 9:
                    buttonText = '2';
                    break;
                  case 10:
                    buttonText = '3';
                    break;
                  case 11:
                    buttonText = '-';
                    break;
                  case 12:
                    buttonText = '0';
                    break;
                  case 13:
                    buttonText = '=';
                    break;
                  case 14:
                    buttonText = '+';
                    break;
                  case 15:
                    buttonText = 'C';
                    break;
                  default:
                    buttonText = '';
                }
                return ElevatedButton(
                  onPressed: () {
                    if (buttonText == 'C') {
                      _clear();
                    } else if (buttonText == '=') {
                      _calculate();
                    } else {
                      _onPressed(buttonText);
                    }
                  },
                  child: Text(buttonText, style: const TextStyle(fontSize: 24.0)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
