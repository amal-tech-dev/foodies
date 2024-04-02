import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/recipe_view_screen/recipe_view_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:share_plus/share_plus.dart';

class RecipeTileController with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, RecipeModel> recipes = {};
  List favourites = [];
  User user = FirebaseAuth.instance.currentUser!;
  late Box box;

  // get recipes
  getRecipes() async {
    CollectionReference reference = firestore.collection('recipes');
    QuerySnapshot snapshot = await reference.get();
    for (QueryDocumentSnapshot doc in snapshot.docs)
      recipes[doc.id] =
          RecipeModel.fromJson(doc.data() as Map<String, dynamic>);
    notifyListeners();
  }

  // get user favourites
  getFavourites() async {
    if (user.isAnonymous) {
      if (await Hive.boxExists(StringConstant.box))
        box = await Hive.box(StringConstant.box);
      else
        box = await Hive.openBox<String>(StringConstant.box);
      favourites = box.values.toList();
    } else {
      DocumentReference reference = firestore.collection('users').doc(user.uid);
      DocumentSnapshot snapshot = await reference.get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      favourites = data['favourites'];
    }
    notifyListeners();
  }

  // update views in firestore
  updateViews(BuildContext context, String docId) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeViewScreen(
          id: docId,
        ),
      ),
    );
    DocumentReference reference = firestore.collection('recipes').doc(docId);
    await reference.update({'views': FieldValue.increment(1)});
    getRecipes();
    notifyListeners();
  }

  // update likes in firestore
  updateLikes(String docId) async {
    DocumentReference reference = firestore.collection('recipes').doc(docId);
    if (recipes[docId]?.likes?.contains(user.uid) ?? false)
      await reference.update({
        'likes': FieldValue.arrayRemove([user.uid])
      });
    else
      await reference.update({
        'likes': FieldValue.arrayUnion([user.uid])
      });
    getRecipes();
    notifyListeners();
  }

  // show views
  showViews(BuildContext context, String docId, int views) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: ColorConstant.backgroundDark,
        child: Padding(
          padding: const EdgeInsets.all(
            DimenConstant.padding * 3,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                StringConstant.viewsDialogPrefix,
                style: TextStyle(
                  color: ColorConstant.secondaryDark,
                  fontSize: DimenConstant.small,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                views.toString(),
                style: TextStyle(
                  color: ColorConstant.primary,
                  fontSize: DimenConstant.large,
                  fontFamily: StringConstant.font,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                StringConstant.viewsDialogSuffix,
                style: TextStyle(
                  color: ColorConstant.secondaryDark,
                  fontSize: DimenConstant.small,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // update shared count and show share options
  updateShared(String docId) async {
    Share.share('vebrbrbfb');
    DocumentReference reference = firestore.collection('recipes').doc(docId);
    await reference.update({'shared': FieldValue.increment(1)});
    getRecipes();
    notifyListeners();
  }

  // update favourites of current user firestore
  updateFavourites(String docId) async {
    if (user.isAnonymous) {
      if (await Hive.boxExists(StringConstant.box))
        box = await Hive.box(StringConstant.box);
      else
        box = await Hive.openBox<String>(StringConstant.box);
      if (favourites.contains(docId)) {
        int index = favourites.indexOf(docId);
        int key = box.keyAt(index);
        await box.deleteAt(key);
      } else {
        await box.add(docId);
      }
    } else {
      DocumentReference reference = firestore.collection('users').doc(user.uid);
      if (favourites.contains(docId))
        await reference.update({
          'favourites': FieldValue.arrayRemove([docId])
        });
      else
        await reference.update({
          'favourites': FieldValue.arrayUnion([docId])
        });
    }
    getFavourites();
    notifyListeners();
  }
}
