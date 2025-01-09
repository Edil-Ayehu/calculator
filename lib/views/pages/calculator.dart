import 'package:calculator/controllers/theme_controller.dart';
import 'package:calculator/services/calculator_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final CalculatorService _calculatorService = CalculatorService();

  void _onButtonPressed(String value) {
    setState(() {
      switch (value) {
        case 'AC':
          _calculatorService.clear();
          break;
        case '=':
          _calculatorService.result = _calculatorService.calculateResult();
          _calculatorService.expression = _calculatorService.result;
          _calculatorService.shouldReset = true;
          break;
        case '±':
          _calculatorService.toggleSign();
          break;
        case '%':
          _calculatorService.calculatePercentage();
          break;
        case '↺':
          _calculatorService.backspace();
          break;
        default:
          _calculatorService.addToExpression(value);
          break;
      }

      // Update result in real-time for basic operations
      if (value != '=' && _calculatorService.expression.isNotEmpty) {
        try {
          _calculatorService.result = _calculatorService.calculateResult();
        } catch (e) {
          // If calculation fails, keep the previous result
        }
      }
    });
  }

  Widget _buildButton(String text,
      {Color? color, double fontSize = 24, bool isDarkMode = false}) {
    return AspectRatio(
      aspectRatio: 1,
      child: TextButton(
        onPressed: () => _onButtonPressed(text),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: color ?? (isDarkMode ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color functionColor = Color(0xFF4CD9B0);
    Color operatorColor = Color(0xFFFF5A5A);

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF17171C) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Single Theme Toggle Icon
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      isDarkMode
                          ? Icons.wb_sunny_outlined
                          : Icons.nightlight_round,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    onPressed: themeController.toggleTheme,
                  ),
                ],
              ),
            ),

            // Expression Display
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _calculatorService.expression,
                      style: TextStyle(
                        fontSize: 24,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _calculatorService.result,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Keypad
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildButton('AC',
                              color: functionColor, isDarkMode: isDarkMode)),
                      Expanded(
                          child: _buildButton('±',
                              color: functionColor, isDarkMode: isDarkMode)),
                      Expanded(
                          child: _buildButton('%',
                              color: functionColor, isDarkMode: isDarkMode)),
                      Expanded(
                          child: _buildButton('÷',
                              color: operatorColor, isDarkMode: isDarkMode)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: _buildButton('7', isDarkMode: isDarkMode)),
                      Expanded(
                          child: _buildButton('8', isDarkMode: isDarkMode)),
                      Expanded(
                          child: _buildButton('9', isDarkMode: isDarkMode)),
                      Expanded(
                          child: _buildButton('×',
                              color: operatorColor, isDarkMode: isDarkMode)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: _buildButton('4', isDarkMode: isDarkMode)),
                      Expanded(
                          child: _buildButton('5', isDarkMode: isDarkMode)),
                      Expanded(
                          child: _buildButton('6', isDarkMode: isDarkMode)),
                      Expanded(
                          child: _buildButton('−',
                              color: operatorColor, isDarkMode: isDarkMode)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: _buildButton('1', isDarkMode: isDarkMode)),
                      Expanded(
                          child: _buildButton('2', isDarkMode: isDarkMode)),
                      Expanded(
                          child: _buildButton('3', isDarkMode: isDarkMode)),
                      Expanded(
                          child: _buildButton('+',
                              color: operatorColor, isDarkMode: isDarkMode)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: _buildButton('↺', isDarkMode: isDarkMode)),
                      Expanded(
                          child: _buildButton('0', isDarkMode: isDarkMode)),
                      Expanded(
                          child: _buildButton('.', isDarkMode: isDarkMode)),
                      Expanded(
                          child: _buildButton('=',
                              color: operatorColor, isDarkMode: isDarkMode)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
