import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class LoginOptions extends StatelessWidget {
  VoidCallback onGooglePressed, onEmailPressed, onGuestPressed;

  LoginOptions({
    super.key,
    required this.onGooglePressed,
    required this.onEmailPressed,
    required this.onGuestPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onGooglePressed,
          child: Container(
            padding: EdgeInsets.all(
              DimenConstant.edgePadding * 1.5,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.tertiaryColor,
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.google,
                  color: ColorConstant.secondaryColor,
                ),
                DimenConstant.separator,
                Text(
                  'Continue with Google',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.subtitleText,
                  ),
                )
              ],
            ),
          ),
        ),
        DimenConstant.separator,
        InkWell(
          onTap: onEmailPressed,
          child: Container(
            padding: EdgeInsets.all(
              DimenConstant.edgePadding * 1.5,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.tertiaryColor,
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.mail_rounded,
                  color: ColorConstant.secondaryColor,
                ),
                DimenConstant.separator,
                Text(
                  'Continue with Email',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.subtitleText,
                  ),
                )
              ],
            ),
          ),
        ),
        DimenConstant.separator,
        InkWell(
          onTap: onGuestPressed,
          child: Container(
            padding: EdgeInsets.all(
              DimenConstant.edgePadding * 1.5,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.tertiaryColor,
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: ColorConstant.secondaryColor,
                ),
                DimenConstant.separator,
                Text(
                  'Continue as Guest',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.subtitleText,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
