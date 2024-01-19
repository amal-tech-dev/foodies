import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/home_screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectDietScreen extends StatelessWidget {
  SelectDietScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.edgePadding,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(
                DimenConstant.edgePadding * 4,
              ),
              child: Text(
                StringConstant.selectDietText,
                style: TextStyle(
                  color: ColorConstant.primaryColor,
                  fontSize: DimenConstant.subtitleText,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            InkWell(
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setString('diet', 'veg');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Container(
                height: 100,
                padding: EdgeInsets.all(
                  DimenConstant.edgePadding,
                ),
                decoration: BoxDecoration(
                  color: ColorConstant.tertiaryColor,
                  borderRadius: BorderRadius.circular(
                    DimenConstant.borderRadius,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Vegetarian',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.subtitleText,
                    ),
                  ),
                ),
              ),
            ),
            DimenConstant.separator,
            InkWell(
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setString('diet', 'non');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Container(
                height: 100,
                padding: EdgeInsets.all(
                  DimenConstant.edgePadding,
                ),
                decoration: BoxDecoration(
                  color: ColorConstant.tertiaryColor,
                  borderRadius: BorderRadius.circular(
                    DimenConstant.borderRadius,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Non-Vegetarian',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.subtitleText,
                    ),
                  ),
                ),
              ),
            ),
            DimenConstant.separator,
            InkWell(
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setString('diet', 'semi');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Container(
                height: 100,
                padding: EdgeInsets.all(
                  DimenConstant.edgePadding,
                ),
                decoration: BoxDecoration(
                  color: ColorConstant.tertiaryColor,
                  borderRadius: BorderRadius.circular(
                    DimenConstant.borderRadius,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Semi-Vegetarian',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.subtitleText,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
