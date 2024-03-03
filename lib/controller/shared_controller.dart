import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SharedController with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // update recipes shared
  shareRecipe(String docId) async {
    DocumentReference reference = firestore.collection('recipes').doc(docId);
    await firestore.runTransaction(
      (transaction) async =>
          transaction.update(reference, {'shared': FieldValue.increment(1)}),
    );
  }
}
