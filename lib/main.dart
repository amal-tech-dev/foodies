import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:foodies/controller/add_recipe_controller.dart';
import 'package:foodies/controller/preferred_recipe_controller.dart';
import 'package:foodies/database/recipes.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/view/cooking_screen/cooking_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();
  runApp(Foodies());
}

class Foodies extends StatelessWidget {
  Foodies({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => PreferredRecipeController()),
        ChangeNotifierProvider(create: (context) => AddRecipeController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorConstant.backgroundColor,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: ColorConstant.secondaryColor,
            selectionColor: ColorConstant.secondaryColor.withOpacity(0.75),
            selectionHandleColor: ColorConstant.secondaryColor,
          ),
        ),
        home: CookingScreen(recipe: Recipes.list[1]),
      ),
    );
  }
}
