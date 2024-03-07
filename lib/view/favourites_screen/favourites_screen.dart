import 'package:flutter/material.dart';
import 'package:foodies/controller/likes_controller.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatefulWidget {
  FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  bool empty = false;

  @override
  void initState() {
    Provider.of<LikesController>(context, listen: false).getMenuList();
    if (Provider.of<LikesController>(context, listen: false).recipes.isEmpty)
      empty = true;
    else
      empty = false;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
