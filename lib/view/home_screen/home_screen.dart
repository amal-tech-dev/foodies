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
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/filter_bottom_sheet.dart';
import 'package:foodies/widgets/separator.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  ConnectivityController connectivity = ConnectivityController();
  List pages = [
    RecipeFeedScreen(),
    ContributeScreen(),
    FavouritesScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    getPermissions();
    connectivity.checkConnectivity();
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
        title: AppName(size: DimenConstant.large),
        actions: [
          CustomButton.icon(
            visible: pageIndex == 0,
            icon: Icons.tune_rounded,
            iconColor: ColorConstant.secondaryLight,
            background: Colors.transparent,
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => FilterBottomSheet(),
              backgroundColor: ColorConstant.backgroundLight,
              showDragHandle: true,
            ),
          ),
          CustomButton.icon(
            visible: pageIndex == 0,
            icon: Icons.search_rounded,
            iconColor: ColorConstant.secondaryLight,
            background: Colors.transparent,
            onPressed: () {},
          ),
          Separator(),
        ],
      ),
      body: connectivity.connected ? pages[pageIndex] : NoConnectionScreen(),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: pageIndex,
          backgroundColor: ColorConstant.backgroundLight,
          selectedFontSize: DimenConstant.xSmall,
          unselectedFontSize: DimenConstant.xSmall,
          selectedItemColor: ColorConstant.primary,
          unselectedItemColor: ColorConstant.secondaryLight,
          elevation: 0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
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
