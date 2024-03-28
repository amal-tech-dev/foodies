import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
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
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/custom_container.dart';
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
  PageController pageController = PageController();
  int cookingIndex = -1, hr = 0, min = 0, sec = 0;
  bool timerPressed = false, timerRunning = false, alertPlaying = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        DimenConstant.padding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: cookingIndex == -1
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
                          color: ColorConstant.secondaryDark,
                          fontSize: DimenConstant.medium,
                        ),
                      ),
                    ],
                  )
                : PageView(
                    controller: pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                      widget.steps.length,
                      (index) => StepItem(
                        item: widget.steps[index],
                        cooking: cookingIndex == index ? true : false,
                        completed: cookingIndex > index ? true : false,
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
                count: widget.steps.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 5,
                  dotWidth: 5,
                  activeDotColor: ColorConstant.secondaryDark,
                  dotColor: ColorConstant.primaryDark.withOpacity(0.5),
                ),
              ),
            ),
          ),
          DimenConstant.separator,
          if (cookingIndex == -1)
            Center(
              child: CustomButton.text(
                text: 'Start',
                onPressed: () {
                  cookingIndex++;
                  setState(() {});
                },
              ),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton.icon(
                  icon: Icons.keyboard_arrow_left_rounded,
                  onPressed: () {
                    if (cookingIndex > 0) {
                      pageController.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                      cookingIndex--;
                      setState(() {});
                    }
                  },
                ),
                if (timerRunning || alertPlaying)
                  Row(
                    children: [
                      CustomContainer(
                        paddingLeft: DimenConstant.padding * 2,
                        paddingRight: DimenConstant.padding * 2,
                        backgroundColor: ColorConstant.primaryDark,
                        borderRadius: 500.0,
                        child: timerRunning
                            ? TimerCountdown(
                                enableDescriptions: false,
                                timeTextStyle: TextStyle(
                                  color: ColorConstant.tertiaryDark,
                                  fontSize: DimenConstant.mini,
                                ),
                                format: hr != 0
                                    ? CountDownTimerFormat.hoursMinutesSeconds
                                    : min != 0
                                        ? CountDownTimerFormat.minutesSeconds
                                        : CountDownTimerFormat.secondsOnly,
                                endTime: DateTime.now().add(
                                  Duration(
                                    hours: hr,
                                    minutes: min,
                                    seconds: sec,
                                  ),
                                ),
                                onEnd: () async {
                                  timerRunning = false;
                                  alertPlaying = true;
                                  hr = 0;
                                  min = 0;
                                  sec = 0;
                                  setState(() {});
                                  await Alarm.set(
                                    alarmSettings: AlarmSettings(
                                      id: 1,
                                      dateTime: DateTime.now(),
                                      assetAudioPath: AudioConstant.timerAlert,
                                      notificationTitle:
                                          StringConstant.notificationTitle,
                                      notificationBody:
                                          StringConstant.notificationBody,
                                      loopAudio: true,
                                      fadeDuration: 3,
                                      vibrate: true,
                                      volume: 1,
                                      enableNotificationOnKill: true,
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
                      CustomButton.icon(
                        icon: Icons.stop_rounded,
                        iconColor: ColorConstant.primaryDark,
                        background: ColorConstant.error,
                        onPressed: () async {
                          timerRunning = false;
                          alertPlaying = false;
                          hr = 0;
                          min = 0;
                          sec = 0;
                          setState(() {});
                          await Alarm.stop(1);
                        },
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      CustomButton.elevated(
                        onPressed: () {
                          if (timerPressed) timerRunning = true;
                          timerPressed = !timerPressed;
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: ColorConstant.tertiaryDark,
                            ),
                            DimenConstant.separator,
                            Text(
                              timerPressed ? 'Start' : 'Timer',
                              style: TextStyle(
                                color: ColorConstant.tertiaryDark,
                                fontSize: DimenConstant.mini,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomButton.icon(
                        visible: timerPressed,
                        icon: Icons.close_rounded,
                        iconColor: ColorConstant.primaryDark,
                        background: ColorConstant.error,
                        onPressed: () async {
                          timerPressed = false;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                CustomButton.icon(
                  icon: Icons.keyboard_arrow_right_rounded,
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
                ),
              ],
            ),
          Visibility(
            visible: timerPressed,
            child: DimenConstant.separator,
          ),
          Visibility(
            visible: timerPressed,
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
        ],
      ),
    );
  }
}
