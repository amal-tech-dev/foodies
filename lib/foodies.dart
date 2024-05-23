import 'package:flutter/material.dart';
import 'package:foodies/controller/connectivity_controller.dart';
import 'package:foodies/controller/filter_controller.dart';
import 'package:foodies/controller/recipe_tile_controller.dart';
import 'package:foodies/theme/foodies_theme.dart';
import 'package:foodies/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

class Foodies extends StatelessWidget {
  Foodies({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FilterController()),
        ChangeNotifierProvider(create: (context) => RecipeTileController()),
        ChangeNotifierProvider(create: (context) => ConnectivityController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: FoodiesTheme.light,
        darkTheme: FoodiesTheme.dark,
        themeMode: ThemeMode.system,
        home: SplashScreen(),
      ),
    );
  }
}
