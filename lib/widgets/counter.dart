import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class Counter extends StatelessWidget {
  String collection, docId, field, title;

  Counter({
    super.key,
    required this.collection,
    required this.docId,
    required this.field,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    num count = 0;
    return Column(
      children: [
        StreamBuilder(
          stream: firestore.collection(collection).doc(docId).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              if (data[field] is int)
                count = data[field];
              else if (data[field] is List<dynamic>)
                count = data[field].length;
              else
                count = 0;
            }
            return AnimatedFlipCounter(
              value: count,
              textStyle: TextStyle(
                color: ColorConstant.primaryColor,
                fontSize: DimenConstant.extraSmallText,
              ),
            );
          },
        ),
        Text(
          title,
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.miniText,
          ),
        ),
      ],
    );
  }
}
