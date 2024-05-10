import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class Counter extends StatefulWidget {
  int count;
  String? header;
  bool? visible;

  Counter({
    super.key,
    required this.count,
    this.header,
    this.visible,
  });

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int count = 0;
  String suffix = '';

  @override
  void initState() {
    formatCount(widget.count);
    super.initState();
  }

  @override
  void didUpdateWidget(Counter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.count != widget.count) {
      formatCount(widget.count);
      setState(() {});
    }
  }

  // format count with respect to length
  formatCount(int value) async {
    if (value < 1000) {
      count = value;
      suffix = '';
    } else if (value < 1000000) {
      count = value ~/ 1000;
      suffix = 'K';
    } else if (value < 1000000000) {
      count = value ~/ 1000000;
      suffix = 'M';
    } else {
      count = value ~/ 1000000000;
      suffix = 'B';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedFlipCounter(
              value: count,
              textStyle: TextStyle(
                color: ColorConstant.secondaryLight,
                fontSize: widget.header != null
                    ? DimenConstant.sText
                    : DimenConstant.xsText,
              ),
            ),
            Text(
              suffix,
              style: TextStyle(
                color: ColorConstant.secondaryLight,
                fontSize: widget.header != null
                    ? DimenConstant.sText
                    : DimenConstant.xsText,
              ),
            ),
          ],
        ),
        Visibility(
          visible: widget.header != null,
          child: Text(
            widget.header ?? '',
            style: TextStyle(
              color: ColorConstant.secondaryLight,
              fontSize: DimenConstant.xsText,
            ),
          ),
        ),
      ],
    );
  }
}
