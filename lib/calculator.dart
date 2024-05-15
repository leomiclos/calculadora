import 'package:flutter/material.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  double _result = 0;

  void _calculate(Operation operation) {
    double num1 = double.tryParse(_num1Controller.text) ?? 0;
    double num2 = double.tryParse(_num2Controller.text) ?? 0;

    setState(() {
      switch (operation) {
        case Operation.addition:
          _result = num1 + num2;
          break;
        case Operation.subtraction:
          _result = num1 - num2;
          break;
        case Operation.multiplication:
          _result = num1 * num2;
          break;
        case Operation.division:
          if (num2 != 0) {
            _result = num1 / num2;
          } else {
            _result = double.infinity; // Handle division by zero
          }
          break;
      }
    });
  }

  void _resetFields() {
    _num1Controller.text = '';
    _num2Controller.text = '';
    setState(() {
      _result = 0;
    });
  }

  Widget _buildOperationButton(Operation operation, String label) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _calculate(operation),
        child: Text(
          label,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: _num1Controller,
              decoration: const InputDecoration(
                labelText: '1º Número',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              controller: _num2Controller,
              decoration: const InputDecoration(
                labelText: '2º Número',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOperationButton(Operation.addition, '+'),
                _buildOperationButton(Operation.subtraction, '-'),
                _buildOperationButton(Operation.multiplication, '×'),
                _buildOperationButton(Operation.division, '÷'),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Resultado: $_result',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _resetFields,
              child: const Text('Limpar'),
            ),
          ],
        ),
      ),
    );
  }
}

enum Operation { addition, subtraction, multiplication, division }
