import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator Sederhana',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '0';
  double _num1 = 0;
  double _num2 = 0;
  String _operator = '';
  bool _isOperatorChosen = false;

  void _handleButtonPress(String buttonText) {
    if (buttonText == 'C') {
      _clear();
    } else if (buttonText == '+' || buttonText == '-' || buttonText == 'x' || buttonText == '/') {
      _selectOperator(buttonText);
    } else if (buttonText == '=') {
      _calculateResult();
    } else {
      _appendNumber(buttonText);
    }
  }

  void _clear() {
    setState(() {
      _output = '0';
      _num1 = 0;
      _num2 = 0;
      _operator = '';
      _isOperatorChosen = false;
    });
  }

  void _selectOperator(String operator) {
    if (_isOperatorChosen) {
      _calculateResult();
      _num1 = double.parse(_output);
      _output = '0';
    }
    setState(() {
      _operator = operator;
      _isOperatorChosen = true;
    });
  }

  void _appendNumber(String number) {
    if (_output == '0' || _output == 'NaN') {
      setState(() {
        _output = number;
      });
    } else {
      setState(() {
        _output += number;
      });
    }
  }

  void _calculateResult() {
    if (_num1 != 0 && _output != 'NaN') {
      _num2 = double.parse(_output);
      double result = 0;
      switch (_operator) {
        case '+':
          result = _num1 + _num2;
          break;
        case '-':
          result = _num1 - _num2;
          break;
        case 'x':
          result = _num1 * _num2;
          break;
        case '/':
          if (_num2 != 0) {
            result = _num1 / _num2;
          } else {
            result = double.nan;
          }
          break;
        default:
          break;
      }
      setState(() {
        _output = result.toString();
        _num1 = result;
        _operator = '';
        _isOperatorChosen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Sederhana'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(fontSize: 48.0),
              ),
            ),
          ),
          Divider(),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('x'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('C'),
                  _buildButton('0'),
                  _buildButton('='),
                  _buildButton('+'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText) {
  return Expanded(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(24.0),
        primary: Colors.grey[300], // Warna latar belakang
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () => _handleButtonPress(buttonText),
    ),
  );
}

}
