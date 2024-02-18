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
  bool check = false;

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

  // update menu based on authentication status
  Future<void> updateMenu(String docId) async {
    if (auth.currentUser?.isAnonymous ?? false)
      await updateGuestMenu(docId);
    else
      await updateUserMenu(docId);
  }

// update menu for guest
  Future<void> updateGuestMenu(String docId) async {
    Box<String> box = Hive.box<String>('menuBox');
    if (box.containsKey(docId)) {
      box.delete(docId);
      unlikeRecipe(docId);
    } else {
      box.put(docId, docId);
      likeRecipe(docId);
    }
  }

// update menu for user
  Future<void> updateUserMenu(String docId) async {
    String uid = auth.currentUser!.uid;
    DocumentReference reference = firestore.collection('users').doc(uid);
    DocumentSnapshot snapshot = await reference.get();
    List<String> menu = List<String>.from(snapshot.get('menu') ?? []);
    if (menu.contains(docId)) {
      menu.remove(docId);
      unlikeRecipe(docId);
    } else {
      menu.add(docId);
      likeRecipe(docId);
    }
    await reference.update({'menu': menu});
  }

  // update recipes likes
  likeRecipe(String docId) async {
    DocumentReference reference = firestore.collection('recipes').doc(docId);
    await firestore.runTransaction(
      (transaction) async {
        DocumentSnapshot snapshot = await transaction.get(reference);
        int count = await (snapshot.data() as Map<String, dynamic>)['likes'];
        await transaction.update(reference, {'likes': count + 1});
      },
    );
  }

  // update recipes likes
  unlikeRecipe(String docId) async {
    DocumentReference reference = firestore.collection('recipes').doc(docId);
    await firestore.runTransaction(
      (transaction) async {
        DocumentSnapshot snapshot = await transaction.get(reference);
        int count = await (snapshot.data() as Map<String, dynamic>)['likes'];
        await transaction.update(reference, {'likes': count - 1});
      },
    );
  }

  // check if the recipe exists in menu
  checkRecipeInMenu(String docId) async {
    if (auth.currentUser!.isAnonymous || auth.currentUser == null)
      check = await checkGuestMenu(docId);
    else
      check = await checkUserMenu(docId);
    notifyListeners();
  }

// check recipe for guest
  Future<bool> checkGuestMenu(String docId) async {
    Box<String> box = Hive.box<String>('menuBox');
    return box.containsKey(docId);
  }

// check recipe for user
  Future<bool> checkUserMenu(String docId) async {
    String uid = auth.currentUser!.uid;
    DocumentReference reference = firestore.collection('users').doc(uid);
    DocumentSnapshot snapshot = await reference.get();
    List<String> menu = List<String>.from(snapshot.get('menu') ?? []);
    return menu.contains(docId);
  }
}
