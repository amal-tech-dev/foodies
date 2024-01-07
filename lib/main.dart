import 'package:flutter/material.dart';
import 'package:foodies/controller/cuisine_controller.dart';
import 'package:foodies/controller/email_login_controller.dart';
import 'package:foodies/controller/navigation_controller.dart';
import 'package:foodies/controller/prefered_recipe_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

enum Diet { veg, non, semi }

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
        ChangeNotifierProvider(create: (context) => NavigationController()),
        ChangeNotifierProvider(create: (context) => CuisineController()),
        ChangeNotifierProvider(create: (context) => PreferedRecipeController()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: ColorConstant.backgroundColor,
          ),
          home: HomeScreen()
          //     RecipeViewScreen(
          //   recipe: RecipeModel(
          //     id: 0,
          //     name: 'Name',
          //     cuisine: 'Cuisine',
          //     description: 'Description',
          //     time: 'Time',
          //     shef: null,
          //     veg: true,
          //     categories: [
          //       'kboaoencas',
          //       'oaiweoiwne',
          //       'qnoweifowqie',
          //       'wqnefiwqo',
          //     ],
          //     ingredients: [],
          //     steps: [],
          //     image: Assets.thumbnailsGetStarted,
          //   ),
          //   isAddedToKitchen: false,
          //   onKitchenPressed: () {},
          // ),
          ),
    );
  }
}
