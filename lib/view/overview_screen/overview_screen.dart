import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodies/controller/carousel_slider_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/home_screen/home_screen.dart';
import 'package:foodies/view/overview_screen/overview_widgets/carousel_item.dart';

class OverviewScreen extends StatelessWidget {
  OverviewScreen({super.key});

  CarouselSliderController carouselSliderController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.edgePadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  (route) => false),
              child: Text(
                'Skip',
                style: TextStyle(
                  color: ColorConstant.primaryColor,
                  fontSize: DimenConstant.extraSmallText,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Image.asset(
                ImageConstant.overviewThumbnail,
              ),
            ),
            DimenConstant.separator,
            Expanded(
              child: CarouselSlider(
                carouselController: carouselSliderController.controller,
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
                  onPageChanged: (index, reason) => Timer(
                    Duration(seconds: 5),
                    () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false),
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
