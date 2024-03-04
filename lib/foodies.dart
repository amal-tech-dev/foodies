import 'package:flutter/material.dart';
import 'package:foodies/controller/add_recipe_controller.dart';
import 'package:foodies/controller/connectivity_controller.dart';
import 'package:foodies/controller/filter_controller.dart';
import 'package:foodies/controller/likes_controller.dart';
import 'package:foodies/controller/shared_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

class Foodies extends StatelessWidget {
  Foodies({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FilterController()),
        ChangeNotifierProvider(create: (context) => LikesController()),
        ChangeNotifierProvider(create: (context) => AddRecipeController()),
        ChangeNotifierProvider(create: (context) => SharedController()),
        ChangeNotifierProvider(create: (context) => ConnectivityController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorConstant.background,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: ColorConstant.secondary,
            selectionColor: ColorConstant.secondary.withOpacity(0.5),
            selectionHandleColor: ColorConstant.secondary,
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
