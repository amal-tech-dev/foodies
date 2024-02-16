import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:hive/hive.dart';

class MenuListController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<RecipeModel> recipes = [];
  List<String> menu = [];

  // get menu list
  getMenuList() async {
    if (auth.currentUser!.isAnonymous && auth.currentUser == null) {
      Box<String> menuBox = Hive.box<String>('menuBox');
      menu = menuBox.values.toList();
    } else {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(uid).get();
      if (snapshot.exists) {
        menu = List<String>.from(
            (snapshot.data() as Map<String, dynamic>)['menu']);
      }
    }
    recipes.clear();
    for (String docId in menu) {
      DocumentSnapshot snapshot =
          await firestore.collection('recipes').doc(docId).get();
      if (snapshot.exists) {
        recipes
            .add(RecipeModel.fromJson(snapshot.data() as Map<String, dynamic>));
      }
    }
    notifyListeners();
  }
}
