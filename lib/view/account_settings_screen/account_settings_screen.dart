import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/edit_user_details_screen/edit_user_details_screen.dart';
import 'package:foodies/view/reset_password_screen/reset_password_screen.dart';
import 'package:foodies/view/update_email_screen/update_email_screen.dart';
import 'package:foodies/widgets/settings_tile.dart';

class AccountSettingsScreen extends StatelessWidget {
  AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundColor,
        surfaceTintColor: Colors.transparent,
        leading: BackButton(
          color: ColorConstant.primaryColor,
        ),
        title: Text(
          'Account Settings',
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.smallText,
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
              name: 'Personal Info',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditUserDetailsScreen(),
                ),
              ),
            ),
            DimenConstant.separator,
            SettingsTile(
              icon: Icons.email_outlined,
              name: 'Update Email',
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
              name: 'Reset Password',
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
              name: 'Delete Account',
              color: ColorConstant.errorColor,
              onPressed: () {},
            ),
            DimenConstant.separator,
          ],
        ),
      ),
    );
  }
}
