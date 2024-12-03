import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class NotePadLogic extends GetxController {
  final NotePadState state = NotePadState();

  ScrollController scrollController = ScrollController();

  TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  bool isBetween1And9(String input) {
    final regex = RegExp(r'^[1-9]$');
    return regex.hasMatch(input);
  }

  updateString(String value) {
    if (state.currentString.value.length == 0 && state.resultString.value.length == 0 && value == '()') {
      //none
    } else if (state.resultString.value.length > 0 && value == '()') {
      state.currentString.value = '(${state.resultString.value})';
      state.resultString.value = '';
    } else if (state.currentString.value.length > 0 && value == '()') {
      state.currentString.value = '(${state.currentString.value})';
    } else if ((value == '+' || value == '-' || value == 'x' || value == '÷' || value == '%') &&
        state.resultString.value.length > 0) {
      state.currentString.value = '${state.resultString.value}${value}';
      state.resultString.value = '';
    } else if ((isBetween1And9(value)) && state.resultString.value.length > 0) {
      state.currentString.value = value;
      state.resultString.value = '';
    } else {
      state.currentString.value = '${state.currentString}${value}';
    }
  }

  clearString() {
    state.currentString.value = '';
    state.resultString.value = '';
  }

  calculator() {
    var result = calculate(state.currentString.value);
    state.resultString.value = removeTrailingZeros(result.toString());
  }

  double calculate(String expression) {
    // 将 x 替换为 *，删除空格
    expression = expression.replaceAll('x', '*').replaceAll(' ', '');

    // 将 ÷ 替换为 /，并删除空格
    expression = expression.replaceAll('÷', '/').replaceAll(' ', '');

    // 数字栈和运算符栈
    List<double> numStack = [];
    List<String> opStack = [];

    // 用于标记负号是否是负数而不是减号
    bool expectNegative = true; // 开始时允许负数

    // 遍历表达式中的字符
    for (int i = 0; i < expression.length; i++) {
      String token = expression[i];

      // 如果是数字，解析完整的数字并入栈
      if (isDigit(token)) {
        int j = i;
        while (j < expression.length && (isDigit(expression[j]) || expression[j] == '.')) {
          j++;
        }

        // 解析并处理负数
        double value = double.parse(expression.substring(i, j));
        if (!expectNegative) {
          value = -value;
        }

        numStack.add(value);
        i = j - 1; // 更新索引
        expectNegative = false; // 数字后不允许负数
      }
      // 如果是左括号，入运算符栈
      else if (token == '(') {
        opStack.add(token);
        expectNegative = true; // 括号后允许负数
      }
      // 如果是右括号，计算括号内的表达式
      else if (token == ')') {
        while (opStack.isNotEmpty && opStack.last != '(') {
          numStack.add(performOperation(opStack.removeLast(), numStack.removeLast(), numStack.removeLast()));
        }
        opStack.removeLast(); // 移除左括号
        expectNegative = false; // 括号结束后不允许负数
      }
      // 如果是运算符
      else if (isOperator(token)) {
        if (token == '-' && expectNegative) {
          expectNegative = false; // 表示负号，而不是减号
        } else {
          // 处理运算符优先级
          while (opStack.isNotEmpty && precedence(opStack.last) >= precedence(token)) {
            numStack.add(performOperation(opStack.removeLast(), numStack.removeLast(), numStack.removeLast()));
          }
          opStack.add(token);
          expectNegative = true; // 期望接下来的值可以是负数
        }
      }
    }

    // 处理剩余的运算符
    while (opStack.isNotEmpty) {
      numStack.add(performOperation(opStack.removeLast(), numStack.removeLast(), numStack.removeLast()));
    }

    // 返回最终结果
    return numStack.last;
  }

// 判断字符是否为数字
  bool isDigit(String token) {
    return RegExp(r'\d').hasMatch(token);
  }

// 判断字符是否为运算符
  bool isOperator(String token) {
    return token == '+' || token == '-' || token == '*' || token == '/' || token == '%';
  }

// 运算符优先级
  int precedence(String op) {
    if (op == '+' || op == '-') {
      return 1;
    } else if (op == '*' || op == '/' || op == '%') {
      return 2;
    } else {
      return 0;
    }
  }

// 执行加减乘除模运算
  double performOperation(String op, double b, double a) {
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '*':
        return a * b;
      case '/':
        if (b == 0) throw ArgumentError('除数不能为 0');
        return a / b;
      case '%':
        if (b == 0) throw ArgumentError('除数不能为 0');
        return a % b;
      default:
        throw ArgumentError('不支持的运算符: $op');
    }
  }

  String removeTrailingZeros(String numberStr) {
    if (!numberStr.contains('.')) return numberStr; // 如果没有小数点，直接返回
    numberStr = numberStr.replaceAll(RegExp(r'0+$'), ''); // 去掉末尾的0
    numberStr = numberStr.replaceAll(RegExp(r'\.$'), ''); // 如果小数点后没有数字，去掉小数点
    return numberStr;
  }
}
