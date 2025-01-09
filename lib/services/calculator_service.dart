import 'package:math_expressions/math_expressions.dart';

class CalculatorService {
  String expression = '';
  String result = '0';
  bool shouldReset = false;

  void clear() {
    expression = '';
    result = '0';
  }

  void toggleSign() {
    if (expression.startsWith('-')) {
      expression = expression.substring(1);
    } else if (expression.isNotEmpty) {
      expression = '-$expression';
    }
  }

  void calculatePercentage() {
    if (expression.isNotEmpty) {
      final value = double.parse(expression) / 100;
      expression = value.toString();
    }
  }

  void backspace() {
    if (expression.isNotEmpty) {
      expression = expression.substring(0, expression.length - 1);
    }
  }

  void addToExpression(String value) {
    if (shouldReset) {
      expression = '';
      shouldReset = false;
    }
    expression += value;
  }

  String calculateResult() {
    String sanitizedExpression = expression;
    sanitizedExpression = sanitizedExpression.replaceAll('×', '*');
    sanitizedExpression = sanitizedExpression.replaceAll('÷', '/');
    sanitizedExpression = sanitizedExpression.replaceAll('−', '-');
    sanitizedExpression = sanitizedExpression.replaceAll('--', '+');

    try {
      final parser = Parser();
      final contextModel = ContextModel();
      final exp = parser.parse(sanitizedExpression);
      final evalResult = exp.evaluate(EvaluationType.REAL, contextModel);

      if (evalResult % 1 == 0) {
        return evalResult.toInt().toString();
      } else {
        return evalResult.toStringAsFixed(8)
            .replaceAll(RegExp(r'0*$'), '')
            .replaceAll(RegExp(r'\.$'), '');
      }
    } catch (e) {
      return 'Error';
    }
  }
}
