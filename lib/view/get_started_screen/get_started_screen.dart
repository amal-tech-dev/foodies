import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/overview_screen/overview_screen.dart';
import 'package:foodies/widgets/foodies_widget.dart';

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
              ImageConstant.getStarted,
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
                ColorConstant.background.withOpacity(0.0),
                ColorConstant.background.withOpacity(0.0),
                ColorConstant.background.withOpacity(0.0),
                ColorConstant.background.withOpacity(0.3),
                ColorConstant.background.withOpacity(0.5),
                ColorConstant.background.withOpacity(0.7),
                ColorConstant.background.withOpacity(0.8),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(
                  DimenConstant.padding * 3,
                ),
                child: Column(
                  children: [
                    Text(
                      StringConstant.welcomeTitle,
                      style: TextStyle(
                        color: ColorConstant.secondary,
                        fontSize: DimenConstant.large,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    FoodiesWidget.appName(
                      size: DimenConstant.large,
                      bold: true,
                    ),
                    Text(
                      StringConstant.welcomeSubtitle,
                      style: TextStyle(
                        color: ColorConstant.primary,
                        fontSize: DimenConstant.extraSmall,
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
                        color: ColorConstant.secondary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: ColorConstant.tertiary,
                            fontSize: DimenConstant.small,
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
