import 'package:math_expressions/math_expressions.dart';

class CalculatorService {
  String expression = '';
  String result = '0';
  bool shouldReset = false;

  /// Clears both the expression and sets result to '0'.
  void clear() {
    expression = '';
    result = '0';
  }

  /// Toggles the sign (positive/negative) of the current expression.
  /// If the expression starts with '-', removes it.
  /// If the expression doesn't start with '-', adds it.
  void toggleSign() {
    if (expression.startsWith('-')) {
      expression = expression.substring(1);
    } else if (expression.isNotEmpty) {
      expression = '-$expression';
    }
  }

  /// Converts the current expression to a percentage by dividing it by 100.
  void calculatePercentage() {
    if (expression.isNotEmpty) {
      final value = double.parse(expression) / 100;
      expression = value.toString();
    }
  }

  /// Removes the last character from the expression.
  /// Does nothing if the expression is empty.
  void backspace() {
    if (expression.isNotEmpty) {
      expression = expression.substring(0, expression.length - 1);
    }
  }

  /// Adds a new value to the current expression.
  void addToExpression(String value) {
    if (shouldReset) {
      expression = '';
      shouldReset = false;
    }
    expression += value;
  }

  /// Evaluates the current mathematical expression and returns the result.
  String calculateResult() {
    // If expression ends with an operator, don't calculate
    if (expression.isEmpty ||
        expression.endsWith('+') ||
        expression.endsWith('−') ||
        expression.endsWith('×') ||
        expression.endsWith('÷')) {
      return expression.isEmpty ? '0' : expression;
    }

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
        return evalResult
            .toStringAsFixed(8)
            .replaceAll(RegExp(r'0*$'), '')
            .replaceAll(RegExp(r'\.$'), '');
      }
    } catch (e) {
      return 'Error';
    }
  }
}
