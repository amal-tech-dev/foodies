import 'package:flutter/material.dart';
import 'package:foodies/controller/cuisine_controller.dart';
import 'package:foodies/controller/preferred_recipe_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/view/edit_recipe_screen/edit_recipe_screen.dart';
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
        ChangeNotifierProvider(create: (context) => CuisineController()),
        ChangeNotifierProvider(
            create: (context) => PreferredRecipeController()),
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
        home: EditRecipeScreen(toAdd: true),
      ),
    );
  }
}
