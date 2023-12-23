import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/login_screen/login_screen.dart';
import 'package:foodies/view/overview_screen/overview_widgets/carousel_item.dart';

class OverviewScreen extends StatefulWidget {
  OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  CarouselController carouselController = CarouselController();
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false),
              child: Text(
                'Skip',
                style: TextStyle(
                  color: ColorConstant.secondaryColor,
                  fontSize: DimenConstant.subtitleText,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset(
                ImageConstant.overviewThumbnail,
              ),
            ),
            Expanded(
              child: CarouselSlider(
                carouselController: carouselController,
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
                  enableInfiniteScroll: false,
                  scrollPhysics: NeverScrollableScrollPhysics(),
                  onPageChanged: (index, reason) {
                    currentPageIndex = index;
                    setState(() {});
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 60.0,
                horizontal: 20.0,
              ),
              child: ElevatedButton(
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
                onPressed: () {
                  if (currentPageIndex < 2) {
                    carouselController.nextPage();
                    setState(() {});
                  } else {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                        (route) => false);
                  }
                },
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
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
