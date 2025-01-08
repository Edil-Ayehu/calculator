import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  bool isDarkMode = true;
  String _expression = '308 × 42';
  String _result = '12,936';

  Widget _buildButton(String text, {Color? color, double fontSize = 24}) {
    return AspectRatio(
      aspectRatio: 1,
      child: TextButton(
        onPressed: () {
          // Add calculator logic here
        },
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
    Color functionColor = Color(0xFF4CD9B0);
    Color operatorColor = Color(0xFFFF5A5A);

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF17171C) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Theme Toggle
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      isDarkMode ? Icons.wb_sunny_outlined : Icons.wb_sunny,
                      color: isDarkMode ? Colors.white54 : Colors.black,
                    ),
                    onPressed: () => setState(() => isDarkMode = false),
                  ),
                  IconButton(
                    icon: Icon(
                      isDarkMode
                          ? Icons.nightlight_round
                          : Icons.nightlight_outlined,
                      color: isDarkMode ? Colors.white : Colors.black54,
                    ),
                    onPressed: () => setState(() => isDarkMode = true),
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
                      _expression,
                      style: TextStyle(
                        fontSize: 24,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _result,
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
                      Expanded(child: _buildButton('AC', color: functionColor)),
                      Expanded(child: _buildButton('±', color: functionColor)),
                      Expanded(child: _buildButton('%', color: functionColor)),
                      Expanded(child: _buildButton('÷', color: operatorColor)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: _buildButton('7')),
                      Expanded(child: _buildButton('8')),
                      Expanded(child: _buildButton('9')),
                      Expanded(child: _buildButton('×', color: operatorColor)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: _buildButton('4')),
                      Expanded(child: _buildButton('5')),
                      Expanded(child: _buildButton('6')),
                      Expanded(child: _buildButton('−', color: operatorColor)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: _buildButton('1')),
                      Expanded(child: _buildButton('2')),
                      Expanded(child: _buildButton('3')),
                      Expanded(child: _buildButton('+', color: operatorColor)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: _buildButton('↺')),
                      Expanded(child: _buildButton('0')),
                      Expanded(child: _buildButton('.')),
                      Expanded(child: _buildButton('=', color: operatorColor)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
