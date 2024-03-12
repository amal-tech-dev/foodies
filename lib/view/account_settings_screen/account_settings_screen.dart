import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/edit_user_screen/edit_user_screen.dart';
import 'package:foodies/view/login_screen/login_screen.dart';
import 'package:foodies/view/reset_password_screen/reset_password_screen.dart';
import 'package:foodies/view/update_email_screen/update_email_screen.dart';
import 'package:foodies/widgets/custom_container.dart';

class AccountSettingsScreen extends StatelessWidget {
  AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseStorage storage = FirebaseStorage.instance;
    String myUid = FirebaseAuth.instance.currentUser!.uid;

    // delete image in firebase
    deleteImage(String field, String url) async {
      await storage.refFromURL(url).delete();
      await firestore.collection('users').doc(myUid).update({field: null});
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.background,
        surfaceTintColor: Colors.transparent,
        leading: BackButton(
          color: ColorConstant.primary,
        ),
        title: Text(
          'Account Settings',
          style: TextStyle(
            color: ColorConstant.primary,
            fontSize: DimenConstant.small,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          DimenConstant.padding,
        ),
        child: Column(
          children: [
            CustomContainer(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditUserScreen(),
                ),
              ),
              child: Row(
                children: [
                  DimenConstant.separator,
                  Icon(
                    Icons.info_outline_rounded,
                    color: ColorConstant.primary,
                  ),
                  DimenConstant.separator,
                  Text(
                    'Personal Info',
                    style: TextStyle(
                      color: ColorConstant.secondary,
                      fontSize: DimenConstant.small,
                    ),
                  ),
                ],
              ),
            ),
            DimenConstant.separator,
            CustomContainer(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateEmailScreen(),
                ),
              ),
              child: Row(
                children: [
                  DimenConstant.separator,
                  Icon(
                    Icons.email_outlined,
                    color: ColorConstant.primary,
                  ),
                  DimenConstant.separator,
                  Text(
                    'Update Email',
                    style: TextStyle(
                      color: ColorConstant.secondary,
                      fontSize: DimenConstant.small,
                    ),
                  ),
                ],
              ),
            ),
            DimenConstant.separator,
            CustomContainer(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResetPasswordScreen(),
                ),
              ),
              child: Row(
                children: [
                  DimenConstant.separator,
                  Icon(
                    Icons.password_rounded,
                    color: ColorConstant.primary,
                  ),
                  DimenConstant.separator,
                  Text(
                    'Reset Password',
                    style: TextStyle(
                      color: ColorConstant.secondary,
                      fontSize: DimenConstant.small,
                    ),
                  ),
                ],
              ),
            ),
            DimenConstant.separator,
            CustomContainer(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: ColorConstant.background,
                    surfaceTintColor: Colors.transparent,
                    title: Text(
                      'Delete account',
                      style: TextStyle(
                        color: ColorConstant.primary,
                        fontSize: DimenConstant.small,
                      ),
                    ),
                    content: Text(
                      StringConstant.deleteAccount,
                      style: TextStyle(
                        color: ColorConstant.secondary,
                        fontSize: DimenConstant.mini,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    actions: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: ColorConstant.primary,
                            fontSize: DimenConstant.mini,
                          ),
                        ),
                      ),
                      DimenConstant.separator,
                      InkWell(
                        onTap: () async {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            (route) => false,
                          );
                          DocumentReference reference =
                              firestore.collection('users').doc(myUid);
                          DocumentSnapshot snapshot = await reference.get();
                          Map<String, dynamic> data =
                              snapshot.data() as Map<String, dynamic>;
                          if (data['profile'] != null)
                            deleteImage('profile', data['profile']);
                          if (data['cover'] != null)
                            deleteImage('cover', data['cover']);
                          await reference.delete();
                          await auth.currentUser!.delete();
                          await auth.signOut();
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            color: ColorConstant.error,
                            fontSize: DimenConstant.mini,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Row(
                children: [
                  DimenConstant.separator,
                  Icon(
                    Icons.delete_outline_rounded,
                    color: ColorConstant.primary,
                  ),
                  DimenConstant.separator,
                  Text(
                    'Delete Account',
                    style: TextStyle(
                      color: ColorConstant.error,
                      fontSize: DimenConstant.small,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
