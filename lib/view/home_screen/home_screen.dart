import 'package:flutter/material.dart';
import 'package:foodies/controller/connectivity_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/contribute_screen/contribute_screen.dart';
import 'package:foodies/view/favourites_screen/favourites_screen.dart';
import 'package:foodies/view/no_connection_screen/no_connection_screen.dart';
import 'package:foodies/view/profile_screen/profile_screen.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_screen.dart';
import 'package:foodies/widgets/app_name.dart';
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
    ContributeScreen(),
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
        title: AppName(
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
          selectedItemColor: ColorConstant.primary,
          unselectedItemColor: ColorConstant.secondaryDark,
          selectedFontSize: DimenConstant.mini,
          unselectedFontSize: DimenConstant.mini,
          backgroundColor: ColorConstant.backgroundDark,
          type: BottomNavigationBarType.fixed,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          elevation: 0,
          onTap: (value) {
            pageIndex = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.fastfood_rounded),
              icon: Icon(Icons.fastfood_outlined),
              label: 'Recipes',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.add_circle_rounded),
              icon: Icon(Icons.add_circle_outline_rounded),
              label: 'Contribute',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.favorite_rounded),
              icon: Icon(Icons.favorite_outline_rounded),
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
