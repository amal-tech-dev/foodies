import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/home_screen/home_screen.dart';
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/separator.dart';

class ServeRecipe extends StatelessWidget {
  String name, image;
  ServeRecipe({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        DimenConstant.padding,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(image),
            ),
            Separator(),
            Text(
              name,
              style: TextStyle(
                color: ColorConstant.secondaryDark,
                fontSize: DimenConstant.large,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              StringConstant.serveRecipe,
              style: TextStyle(
                color: ColorConstant.primary,
                fontSize: DimenConstant.small,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            CustomButton.text(
              text: 'Finish',
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
                (route) => false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
