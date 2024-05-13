import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/edit_info_screen/edit_info_screen.dart';
import 'package:foodies/view/login_screen/login_screen.dart';
import 'package:foodies/view/reset_password_screen/reset_password_screen.dart';
import 'package:foodies/view/update_email_screen/update_email_screen.dart';
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/custom_dialog.dart';
import 'package:foodies/widgets/custom_navigator.dart';
import 'package:foodies/widgets/custom_text.dart';
import 'package:foodies/widgets/separator.dart';
import 'package:foodies/widgets/settings_tile.dart';

class AccountSettingsScreen extends StatelessWidget {
  AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseStorage storage = FirebaseStorage.instance;
    User user = FirebaseAuth.instance.currentUser!;

    // delete image in firebase
    deleteImage(String field, String url) async {
      await storage.refFromURL(url).delete();
      await firestore.collection('users').doc(user.uid).update({field: null});
    }

    return Scaffold(
      appBar: AppBar(
        leading: CustomButton.back(),
        title: CustomText(
          text: 'Account Settings',
          size: DimenConstant.mText,
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
              onPressed: () => CustomNavigator.push(
                context: context,
                push: EditInfoScreen(),
              ),
            ),
            Separator(),
            SettingsTile(
              icon: Icons.email_outlined,
              header: 'Update Email',
              onPressed: () => CustomNavigator.push(
                context: context,
                push: UpdateEmailScreen(),
              ),
            ),
            Separator(),
            SettingsTile(
              icon: Icons.password_rounded,
              header: 'Reset Password',
              onPressed: () => CustomNavigator.push(
                context: context,
                push: ResetPasswordScreen(),
              ),
            ),
            Separator(),
            SettingsTile(
              icon: Icons.delete_outline_rounded,
              header: 'Delete Account',
              color: ColorConstant.error,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    title: 'Delete account',
                    content: StringConstant.deleteAccount,
                    positiveText: 'Delete',
                    positiveColor: ColorConstant.error,
                    onPositivePressed: () async {
                      CustomNavigator.pushAndRemoveUntil(
                        context: context,
                        removeUntil: LoginScreen(),
                      );
                      DocumentReference reference =
                          firestore.collection('users').doc(user.uid);
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
