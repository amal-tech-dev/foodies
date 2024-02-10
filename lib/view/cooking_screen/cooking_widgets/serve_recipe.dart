import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/home_screen/home_screen.dart';

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
              backgroundImage: AssetImage(image),
            ),
            DimenConstant.separator,
            Text(
              name,
              style: TextStyle(
                color: ColorConstant.primaryColor,
                fontSize: DimenConstant.largeText,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              StringConstant.serveRecipe,
              style: TextStyle(
                color: ColorConstant.secondaryColor,
                fontSize: DimenConstant.smallText,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  ColorConstant.secondaryColor,
                ),
              ),
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
                (route) => false,
              ),
              child: Text(
                'Finish',
                style: TextStyle(
                  color: ColorConstant.tertiaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
