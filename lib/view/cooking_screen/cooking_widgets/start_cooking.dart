import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/view/cooking_screen/cooking_widgets/step_item.dart';
import 'package:foodies/view/cooking_screen/cooking_widgets/timer_bottom_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StartCooking extends StatefulWidget {
  String time;
  List<String> steps;
  VoidCallback onPressed;
  StartCooking({
    super.key,
    required this.time,
    required this.steps,
    required this.onPressed,
  });

  @override
  _StartCookingState createState() => _StartCookingState();
}

class _StartCookingState extends State<StartCooking> {
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();
  int cookingIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        DimenConstant.edgePadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: cookingIndex == -1 || cookingIndex == widget.steps.length
                ? Column(
                    children: [
                      Image.asset(
                        ImageConstant.chef,
                      ),
                      Text(
                        cookingIndex == -1
                            ? 'Light up the burner'
                            : 'Smells good',
                        style: TextStyle(
                          color: ColorConstant.secondaryColor,
                          fontSize: DimenConstant.mediumText,
                        ),
                      ),
                    ],
                  )
                : PageView(
                    controller: pageController,
                    children: List.generate(
                      widget.steps.length,
                      (index) => StepItem(
                        item: widget.steps[index],
                        isCooking: cookingIndex == index ? true : false,
                        isCompleted: cookingIndex > index ? true : false,
                      ),
                    ),
                  ),
          ),
          Visibility(
            visible: cookingIndex > -1 && cookingIndex < widget.steps.length
                ? true
                : false,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: 6,
                effect: ExpandingDotsEffect(
                  dotHeight: 5,
                  dotWidth: 5,
                  activeDotColor: ColorConstant.secondaryColor,
                  dotColor: ColorConstant.primaryColor.withOpacity(0.5),
                ),
              ),
            ),
          ),
          DimenConstant.separator,
          cookingIndex == -1
              ? Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        ColorConstant.secondaryColor,
                      ),
                    ),
                    onPressed: () {
                      cookingIndex++;
                      setState(() {});
                    },
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: ColorConstant.tertiaryColor,
                        fontSize: DimenConstant.miniText,
                      ),
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          ColorConstant.secondaryColor,
                        ),
                      ),
                      onPressed: () {
                        pageController.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                        cookingIndex--;
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_left_rounded,
                        color: ColorConstant.tertiaryColor,
                      ),
                    ),
                    DimenConstant.separator,
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          ColorConstant.secondaryColor,
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: ColorConstant.backgroundColor,
                          builder: (context) => TimerBottomSheet(),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            color: ColorConstant.tertiaryColor,
                          ),
                          DimenConstant.separator,
                          Text(
                            'Timer',
                            style: TextStyle(
                              color: ColorConstant.tertiaryColor,
                              fontSize: DimenConstant.miniText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DimenConstant.separator,
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          ColorConstant.secondaryColor,
                        ),
                      ),
                      onPressed: cookingIndex == widget.steps.length - 1
                          ? widget.onPressed
                          : () {
                              pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                              cookingIndex++;
                              setState(() {});
                            },
                      icon: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: ColorConstant.tertiaryColor,
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
