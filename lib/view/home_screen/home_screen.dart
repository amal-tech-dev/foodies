import 'package:flutter/material.dart';
import 'package:foodies/controller/connectivity_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/add_recipe_screen/add_recipe_screen.dart';
import 'package:foodies/view/favourites_screen/favourites_screen.dart';
import 'package:foodies/view/no_connection_screen/no_connection_screen.dart';
import 'package:foodies/view/profile_screen/profile_screen.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_screen.dart';
import 'package:foodies/view/search_screen/search_screen.dart';
import 'package:foodies/widgets/madroid.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  List screens = [
    RecipeFeedScreen(),
    SearchScreen(),
    AddRecipeScreen(),
    FavouritesScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    getPermissions();
    Provider.of<ConnectivityController>(
      context,
      listen: false,
    ).checkConnectivity();
    super.initState();
  }

  // get permissions required
  getPermissions() async {
    if (await Permission.notification.isDenied ||
        await Permission.notification.isRestricted) {
      await Permission.notification.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.background,
        surfaceTintColor: Colors.transparent,
        title: Madroid.appName(
          size: DimenConstant.small,
        ),
      ),
      body: Provider.of<ConnectivityController>(context).connected
          ? screens[pageIndex]
          : NoConnectionScreen(),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: pageIndex,
          selectedItemColor: ColorConstant.secondary,
          unselectedItemColor: ColorConstant.primary,
          selectedFontSize: DimenConstant.mini,
          unselectedFontSize: DimenConstant.mini,
          backgroundColor: ColorConstant.background,
          type: BottomNavigationBarType.fixed,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          onTap: (value) {
            pageIndex = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.fastfood_rounded,
              ),
              icon: Icon(Icons.fastfood_outlined),
              label: 'Recipes',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.search_rounded),
              icon: Icon(Icons.search_rounded),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.add_rounded),
              icon: Icon(Icons.add_rounded),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.bookmarks_rounded),
              icon: Icon(Icons.bookmarks_outlined),
              label: 'Favourites',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.person_rounded),
              icon: Icon(Icons.person_outline_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
