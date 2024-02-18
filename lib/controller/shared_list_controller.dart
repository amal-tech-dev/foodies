import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SharedListController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool check = false;

  // update shared list based on authentication status
  Future<void> updateSharedList(String docId) async {
    if (auth.currentUser?.isAnonymous ?? false)
      await updateGuestSharedList(docId);
    else
      await updateUserSharedList(docId);
  }

  // update recipes shared
  shareRecipe(String docId) async {
    DocumentReference reference = firestore.collection('recipes').doc(docId);
    await firestore.runTransaction(
      (transaction) async {
        DocumentSnapshot snapshot = await transaction.get(reference);
        int count = await (snapshot.data() as Map<String, dynamic>)['shared'];
        await transaction.update(reference, {'shared': count + 1});
      },
    );
  }

// update shared list for guest
  Future<void> updateGuestSharedList(String docId) async {
    Box<String> box = Hive.box<String>('sharedBox');
    if (!box.containsKey(docId)) box.put(docId, docId);
  }

// update shared list for user
  Future<void> updateUserSharedList(String docId) async {
    String uid = auth.currentUser!.uid;
    DocumentReference reference = firestore.collection('users').doc(uid);
    DocumentSnapshot snapshot = await reference.get();
    List<String> shared = List<String>.from(snapshot.get('shared') ?? []);
    if (!shared.contains(docId)) {
      shared.add(docId);
      await reference.update({'shared': shared});
    }
  }

  // check if the recipe is shared
  checkRecipeIsShared(String docId) async {
    if (auth.currentUser!.isAnonymous || auth.currentUser == null)
      check = await checkGuestSharedList(docId);
    else
      check = await checkUserSharedList(docId);
    notifyListeners();
  }

// check recipe for guest
  Future<bool> checkGuestSharedList(String docId) async {
    Box<String> box = Hive.box<String>('sharedBox');
    return box.containsKey(docId);
  }

// check recipe for user
  Future<bool> checkUserSharedList(String docId) async {
    String uid = auth.currentUser!.uid;
    DocumentReference reference = firestore.collection('users').doc(uid);
    DocumentSnapshot snapshot = await reference.get();
    List<String> menu = List<String>.from(snapshot.get('shared') ?? []);
    return menu.contains(docId);
  }
}
