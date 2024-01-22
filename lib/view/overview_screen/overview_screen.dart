import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodies/controller/carousel_slider_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/overview_screen/overview_widgets/carousel_item.dart';
import 'package:foodies/view/select_diet_screen/select_diet_screen.dart';

class OverviewScreen extends StatefulWidget {
  OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  CarouselSliderController carouselSliderController =
      CarouselSliderController();
  CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 40,
          ),
          TextButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectDietScreen(),
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
                  carouselSliderController.increment();
                  setState(() {});
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 50.0,
              horizontal: 20.0,
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStatePropertyAll(
                  Size(
                    MediaQuery.of(context).size.width,
                    50,
                  ),
                ),
                backgroundColor: MaterialStatePropertyAll(
                  ColorConstant.secondaryColor,
                ),
              ),
              onPressed: () {
                if (carouselSliderController.index < 2) {
                  carouselController.nextPage();
                  setState(() {});
                } else {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectDietScreen(),
                      ),
                      (route) => false);
                }
              },
              child: Text(
                'Next',
                style: TextStyle(
                  color: ColorConstant.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
