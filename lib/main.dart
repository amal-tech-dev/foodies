import 'package:flutter/material.dart';
import 'package:foodies/view/overview_screen/overview_screen_1.dart';

void main() {
  runApp(Foodies());
}

class Foodies extends StatelessWidget {
  Foodies({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OverviewScreen1(),
    );
  }
}
