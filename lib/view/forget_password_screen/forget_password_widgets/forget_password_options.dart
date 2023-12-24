import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class ForgetPasswordOptions extends StatelessWidget {
  const ForgetPasswordOptions({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: DimenConstant.edgePadding * 1.5,
          ),
          decoration: BoxDecoration(
            color: ColorConstant.tertiaryColor,
            borderRadius: BorderRadius.circular(
              DimenConstant.borderRadius,
            ),
          ),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
              label: Text(
                'Email',
                style: TextStyle(
                  color: ColorConstant.primaryColor,
                ),
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: ColorConstant.secondaryColor,
            ),
            cursorColor: ColorConstant.primaryColor,
          ),
        ),
        DimenConstant.separator,
        ElevatedButton(
          style: ButtonStyle(
            fixedSize: MaterialStatePropertyAll(
              Size(
                MediaQuery.of(context).size.width,
                45,
              ),
            ),
            backgroundColor: MaterialStatePropertyAll(
              ColorConstant.primaryColor,
            ),
          ),
          onPressed: () {},
          child: Text(
            'Verify',
            style: TextStyle(
              color: ColorConstant.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
