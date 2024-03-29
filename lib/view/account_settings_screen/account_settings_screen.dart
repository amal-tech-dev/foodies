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
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/settings_tile.dart';

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
        backgroundColor: ColorConstant.backgroundDark,
        surfaceTintColor: Colors.transparent,
        leading: CustomButton.back(),
        title: Text(
          'Account Settings',
          style: TextStyle(
            color: ColorConstant.primaryDark,
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
            SettingsTile(
              icon: Icons.info_outline_rounded,
              header: 'Personal Info',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditUserScreen(),
                ),
              ),
            ),
            DimenConstant.separator,
            SettingsTile(
              icon: Icons.email_outlined,
              header: 'Update Email',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateEmailScreen(),
                ),
              ),
            ),
            DimenConstant.separator,
            SettingsTile(
              icon: Icons.password_rounded,
              header: 'Reset Password',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResetPasswordScreen(),
                ),
              ),
            ),
            DimenConstant.separator,
            SettingsTile(
              icon: Icons.delete_outline_rounded,
              header: 'Delete Account',
              color: ColorConstant.error,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: ColorConstant.backgroundDark,
                    surfaceTintColor: Colors.transparent,
                    title: Text(
                      'Delete account',
                      style: TextStyle(
                        color: ColorConstant.primaryDark,
                        fontSize: DimenConstant.small,
                      ),
                    ),
                    content: Text(
                      StringConstant.deleteAccount,
                      style: TextStyle(
                        color: ColorConstant.secondaryDark,
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
                            color: ColorConstant.primaryDark,
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
            ),
          ],
        ),
      ),
    );
  }
}
