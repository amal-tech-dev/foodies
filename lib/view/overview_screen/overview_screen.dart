import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodies/controller/page_view_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/home_screen/home_screen.dart';
import 'package:foodies/view/overview_screen/overview_widgets/carousel_item.dart';
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/separator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OverviewScreen extends StatelessWidget {
  OverviewScreen({super.key});

  PageViewController carouselSliderController = PageViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.padding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: kToolbarHeight,
            ),
            CustomButton.text(
              text: 'Skip',
              textColor: ColorConstant.secondaryDark,
              textSize: DimenConstant.extraSmall,
              background: Colors.transparent,
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setBool('newLogin', false);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                    (route) => false);
              },
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Image.asset(
                ImageConstant.overview,
              ),
            ),
            Separator(),
            Expanded(
              child: CarouselSlider(
                items: [
                  CarouselItem(
                    title: StringConstant.carouselTitle1,
                    subtitle: StringConstant.carouselSubtitle1,
                  ),
                  CarouselItem(
                    title: StringConstant.carouselTitle2,
                    subtitle: StringConstant.carouselSubtitle2,
                  ),
                  CarouselItem(
                    title: StringConstant.carouselTitle3,
                    subtitle: StringConstant.carouselSubtitle3,
                  ),
                ],
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  onPageChanged: (index, reason) {
                    if (index == 2) {
                      Timer(
                        Duration(seconds: 5),
                        () async {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.setBool('newLogin', false);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                              (route) => false);
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
