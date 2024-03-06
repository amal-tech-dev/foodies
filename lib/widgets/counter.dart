import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class Counter extends StatefulWidget {
  String collection, docId, field;
  String? header;

  Counter({
    super.key,
    required this.collection,
    required this.docId,
    required this.field,
    this.header,
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
    getData();
    super.initState();
  }

  // get required data from field
  getData() async {
    DocumentReference reference =
        firestore.collection(widget.collection).doc(widget.docId);
    DocumentSnapshot snapshot = await reference.get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    int temp = 0;
    if (data[widget.field] is int)
      temp = data[widget.field];
    else if (data[widget.field] is List<dynamic>)
      temp = data[widget.field].length;
    else
      temp = 0;
    if (temp < 1000) {
      count = temp;
      suffix = '';
    } else if (temp < 1000000) {
      count = temp ~/ 1000;
      suffix = 'k';
    } else if (temp < 1000000000) {
      count = temp ~/ 1000000;
      suffix = 'M';
    } else {
      count = temp ~/ 1000000000;
      suffix = 'B';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AnimatedFlipCounter(
              value: count.toInt(),
              textStyle: TextStyle(
                color: ColorConstant.primary,
                fontSize: widget.header != null
                    ? DimenConstant.extraSmall
                    : DimenConstant.mini,
              ),
            ),
            Text(
              suffix,
              style: TextStyle(
                color: ColorConstant.primary,
                fontSize: widget.header != null
                    ? DimenConstant.extraSmall
                    : DimenConstant.mini,
              ),
            ),
          ],
        ),
        Visibility(
          visible: widget.header != null,
          child: Text(
            widget.header ?? '',
            style: TextStyle(
              color: ColorConstant.primary,
              fontSize: DimenConstant.mini,
            ),
          ),
        ),
      ],
    );
  }
}
