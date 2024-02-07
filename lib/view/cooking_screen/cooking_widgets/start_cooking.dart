import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:foodies/utils/audio_constant.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/lottie_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/cooking_screen/cooking_widgets/step_item.dart';
import 'package:foodies/view/cooking_screen/cooking_widgets/timer_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StartCooking extends StatefulWidget {
  List<String> steps;
  VoidCallback onPressed;
  StartCooking({
    super.key,
    required this.steps,
    required this.onPressed,
  });

  @override
  _StartCookingState createState() => _StartCookingState();
}

class _StartCookingState extends State<StartCooking> {
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();
  int cookingIndex = -1, hr = 0, min = 0, sec = 0;
  bool isTimerPressed = false, isTimerRunning = false, isAlertPlaying = false;
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    isTimerRunning || isAlertPlaying
                        ? Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: DimenConstant.edgePadding,
                                  horizontal: DimenConstant.edgePadding * 2,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorConstant.primaryColor,
                                  borderRadius: BorderRadius.circular(500),
                                ),
                                child: isTimerRunning
                                    ? TimerCountdown(
                                        enableDescriptions: false,
                                        timeTextStyle: TextStyle(
                                          color: ColorConstant.tertiaryColor,
                                          fontSize: DimenConstant.miniText,
                                        ),
                                        format: hr != 0
                                            ? CountDownTimerFormat
                                                .hoursMinutesSeconds
                                            : min != 0
                                                ? CountDownTimerFormat
                                                    .minutesSeconds
                                                : CountDownTimerFormat
                                                    .secondsOnly,
                                        endTime: DateTime.now().add(
                                          Duration(
                                            hours: hr,
                                            minutes: min,
                                            seconds: sec,
                                          ),
                                        ),
                                        onEnd: () async {
                                          isTimerRunning = false;
                                          isAlertPlaying = true;
                                          hr = 0;
                                          min = 0;
                                          sec = 0;
                                          setState(() {});
                                          await Alarm.set(
                                            alarmSettings: AlarmSettings(
                                              id: 0,
                                              dateTime: DateTime.now(),
                                              assetAudioPath:
                                                  AudioConstant.timerAlert,
                                              notificationTitle: StringConstant
                                                  .notificationTitle,
                                              notificationBody: StringConstant
                                                  .notificationBody,
                                            ),
                                          );
                                        },
                                      )
                                    : Lottie.asset(
                                        LottieConstant.alertPlaying,
                                        height: 20,
                                        width: 50,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                              IconButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    ColorConstant.errorColor,
                                  ),
                                ),
                                onPressed: () async {
                                  isTimerRunning = false;
                                  isAlertPlaying = false;
                                  hr = 0;
                                  min = 0;
                                  sec = 0;
                                  setState(() {});
                                  await Alarm.stop(0);
                                },
                                icon: Icon(
                                  Icons.stop_rounded,
                                  color: ColorConstant.primaryColor,
                                ),
                              ),
                            ],
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                ColorConstant.secondaryColor,
                              ),
                            ),
                            onPressed: () {
                              if (isTimerPressed) isTimerRunning = true;
                              isTimerPressed = !isTimerPressed;
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.timer_outlined,
                                  color: ColorConstant.tertiaryColor,
                                ),
                                DimenConstant.separator,
                                Text(
                                  isTimerPressed ? 'Start' : 'Timer',
                                  style: TextStyle(
                                    color: ColorConstant.tertiaryColor,
                                    fontSize: DimenConstant.miniText,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                ),
          Visibility(
            visible: isTimerPressed,
            child: DimenConstant.separator,
          ),
          Visibility(
            visible: isTimerPressed,
            child: TimerWidget(
              onHourChanged: (int value) {
                hr = value;
                setState(() {});
              },
              onMinuteChanged: (int value) {
                min = value;
                setState(() {});
              },
              onSecondChanged: (int value) {
                sec = value;
                setState(() {});
              },
            ),
          ),
          // Visibility(
          //   visible:isAlertPlaying,
          //   child: Lottie.a,
          // ),
        ],
      ),
    );
  }
}
