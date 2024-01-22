import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/overview_screen/overview_screen.dart';

class GetStartedScreen extends StatelessWidget {
  GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImageConstant.getStartedThumbnail,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorConstant.backgroundColor.withOpacity(0.0),
                ColorConstant.backgroundColor.withOpacity(0.1),
                ColorConstant.backgroundColor.withOpacity(0.2),
                ColorConstant.backgroundColor.withOpacity(0.4),
                ColorConstant.backgroundColor.withOpacity(0.6),
                ColorConstant.backgroundColor.withOpacity(0.7),
                ColorConstant.backgroundColor.withOpacity(0.8),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Text(
                      StringConstant.welcomeTitle,
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                        fontSize: DimenConstant.largeText,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    DimenConstant.separator,
                    Text(
                      StringConstant.welcomeSubtitle,
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                        fontSize: DimenConstant.extraSmallText,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              DimenConstant.separator,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OverviewScreen(),
                      ),
                    ),
                    child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                        color: ColorConstant.secondaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: ColorConstant.primaryColor,
                            fontSize: DimenConstant.smallText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
