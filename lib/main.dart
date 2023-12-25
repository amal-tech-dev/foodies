import 'package:flutter/material.dart';
import 'package:foodies/controller/email_login_controller.dart';
import 'package:foodies/controller/navigation_controller.dart';
import 'package:foodies/view/home_screen/home_screen.dart';
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
        ChangeNotifierProvider(create: (context) => NavigationController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
