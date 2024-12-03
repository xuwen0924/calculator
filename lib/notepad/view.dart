import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class NotePadPage extends GetView<NotePadLogic> {
  NotePadPage({super.key});

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.only(top: top),
          color: Colors.black,
          child: _buildMain(context),
        ),
      ),
    );
  }

  Widget _buildMain(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          if (controller.state.resultString.value.isNotEmpty) _buildCurrentWidget(),
          // if (controller.state.resultString.value.length > 0)
          _buildResultWidget(),
          SizedBox(height: 24),
          _buildButtonWidget(context),
        ],
      );
    });
  }

  Widget _buildCurrentWidget() {
    return Obx(() {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                controller.state.currentString.value ?? '',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 36,
                ),
                textAlign: TextAlign.end,
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 24),
          ],
        ),
      );
    });
  }

  Widget _buildResultWidget() {
    return Obx(() {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                (controller.state.resultString.value).isNotEmpty
                    ? controller.state.resultString.value
                    : controller.state.currentString.value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 64,
                ),
                textAlign: TextAlign.end,
                maxLines: 2,
              ),
            ),
            const SizedBox(width: 24),
          ],
        ),
      );
    });
  }

  Widget _buildButtonWidget(BuildContext context) {
    double bottom = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          _buildRowWidget1(),
          const SizedBox(height: 12),
          _buildRowWidget2(),
          const SizedBox(height: 12),
          _buildRowWidget3(),
          const SizedBox(height: 12),
          _buildRowWidget4(),
          const SizedBox(height: 12),
          _buildRowWidget5(context),
          SizedBox(height: bottom + 36),
        ],
      ),
    );
  }

  Widget _buildRowWidget1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildItemWidget(
          title: 'C',
          color: Colors.grey,
          textColor: Colors.black,
          onTap: () {
            controller.clearString();
          },
        ),
        _buildItemWidget(
          title: '()',
          color: Colors.grey,
          textColor: Colors.black,
          onTap: () {
            controller.updateString('()');
          },
        ),
        _buildItemWidget(
          title: '%',
          color: Colors.grey,
          textColor: Colors.black,
          onTap: () {
            controller.updateString('%');
          },
        ),
        _buildItemWidget(
          title: '÷',
          color: Colors.orange,
          onTap: () {
            controller.updateString('÷');
          },
        ),
      ],
    );
  }

  Widget _buildRowWidget2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildItemWidget(
          title: '7',
          color: Colors.white24,
          onTap: () {
            controller.updateString('7');
          },
        ),
        _buildItemWidget(
          title: '8',
          color: Colors.white24,
          onTap: () {
            controller.updateString('8');
          },
        ),
        _buildItemWidget(
          title: '9',
          color: Colors.white24,
          onTap: () {
            controller.updateString('9');
          },
        ),
        _buildItemWidget(
          title: 'x',
          color: Colors.orange,
          onTap: () {
            controller.updateString('x');
          },
        ),
      ],
    );
  }

  Widget _buildRowWidget3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildItemWidget(
          title: '4',
          color: Colors.white24,
          onTap: () {
            controller.updateString('4');
          },
        ),
        _buildItemWidget(
          title: '5',
          color: Colors.white24,
          onTap: () {
            controller.updateString('5');
          },
        ),
        _buildItemWidget(
          title: '6',
          color: Colors.white24,
          onTap: () {
            controller.updateString('6');
          },
        ),
        _buildItemWidget(
          title: '-',
          color: Colors.orange,
          onTap: () {
            controller.updateString('-');
          },
        ),
      ],
    );
  }

  Widget _buildRowWidget4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildItemWidget(
          title: '1',
          color: Colors.white24,
          onTap: () {
            controller.updateString('1');
          },
        ),
        _buildItemWidget(
          title: '2',
          color: Colors.white24,
          onTap: () {
            controller.updateString('2');
          },
        ),
        _buildItemWidget(
          title: '3',
          color: Colors.white24,
          onTap: () {
            controller.updateString('3');
          },
        ),
        _buildItemWidget(
          title: '+',
          color: Colors.orange,
          onTap: () {
            controller.updateString('+');
          },
        ),
      ],
    );
  }

  Widget _buildRowWidget5(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double margin = (width - 80 * 4 - 16 * 2) / 3;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildItemWidget1(
            title: '0',
            color: Colors.white24,
            onTap: () {
              controller.updateString('0');
            },
          ),
        ),
        SizedBox(width: margin),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildItemWidget(
                title: '.',
                color: Colors.white24,
                onTap: () {
                  controller.updateString('.');
                },
              ),
              _buildItemWidget(
                title: '=',
                color: Colors.orange,
                onTap: () {
                  controller.calculator();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItemWidget({
    String? title,
    Color? color,
    Color? textColor,
    GestureTapCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        child: Center(
          child: Text(
            title ?? '',
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemWidget1({
    String? title,
    Color? color,
    Color? textColor,
    GestureTapCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        child: Center(
          child: Text(
            title ?? '',
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 36,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
