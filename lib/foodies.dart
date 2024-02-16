import 'package:flutter/material.dart';
import 'package:foodies/controller/add_recipe_controller.dart';
import 'package:foodies/controller/filter_controller.dart';
import 'package:foodies/controller/menu_list_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

class Foodies extends StatelessWidget {
  Foodies({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddRecipeController()),
        ChangeNotifierProvider(create: (context) => FilterController()),
        ChangeNotifierProvider(create: (context) => MenuListController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorConstant.backgroundColor,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: ColorConstant.secondaryColor,
            selectionColor: ColorConstant.secondaryColor.withOpacity(0.75),
            selectionHandleColor: ColorConstant.secondaryColor,
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
