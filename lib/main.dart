import 'package:flutter/material.dart';
import 'package:foodies/controller/cuisine_controller.dart';
import 'package:foodies/controller/email_login_controller.dart';
import 'package:foodies/controller/prefered_recipe_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Foodies());
}

class Foodies extends StatelessWidget {
  Foodies({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EmailLoginController()),
        ChangeNotifierProvider(create: (context) => CuisineController()),
        ChangeNotifierProvider(create: (context) => PreferedRecipeController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorConstant.backgroundColor,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
