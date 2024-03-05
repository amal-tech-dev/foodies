import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class TimerWidget extends StatelessWidget {
  dynamic onHourChanged, onMinuteChanged, onSecondChanged;

  TimerWidget({
    super.key,
    required this.onHourChanged,
    required this.onMinuteChanged,
    required this.onSecondChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: ColorConstant.secondary,
                        width: DimenConstant.borderWidth,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 120,
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 40,
                  diameterRatio: 2,
                  perspective: 0.0001,
                  onSelectedItemChanged: onHourChanged,
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 25,
                    builder: (context, index) => Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          index.toString().padLeft(2, '0'),
                          style: TextStyle(
                            color: ColorConstant.primary,
                            fontSize: DimenConstant.small,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        DimenConstant.separator,
        Text(
          ':',
          style: TextStyle(
            color: ColorConstant.primary,
            fontSize: DimenConstant.small,
          ),
        ),
        DimenConstant.separator,
        Expanded(
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: ColorConstant.secondary,
                        width: DimenConstant.borderWidth,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 120,
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 40,
                  diameterRatio: 2,
                  perspective: 0.0001,
                  onSelectedItemChanged: onMinuteChanged,
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 60,
                    builder: (context, index) => Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          index.toString().padLeft(2, '0'),
                          style: TextStyle(
                            color: ColorConstant.primary,
                            fontSize: DimenConstant.small,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        DimenConstant.separator,
        Text(
          ':',
          style: TextStyle(
            color: ColorConstant.primary,
            fontSize: DimenConstant.small,
          ),
        ),
        DimenConstant.separator,
        Expanded(
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: ColorConstant.secondary,
                        width: DimenConstant.borderWidth,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 120,
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 40,
                  diameterRatio: 2,
                  perspective: 0.0001,
                  onSelectedItemChanged: onSecondChanged,
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 60,
                    builder: (context, index) => Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          index.toString().padLeft(2, '0'),
                          style: TextStyle(
                            color: ColorConstant.primary,
                            fontSize: DimenConstant.small,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
