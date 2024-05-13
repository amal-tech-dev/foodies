import 'package:flutter/material.dart';
import 'package:foodies/controller/connectivity_controller.dart';
import 'package:foodies/controller/filter_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/contribute_screen/contribute_screen.dart';
import 'package:foodies/view/favourites_screen/favourites_screen.dart';
import 'package:foodies/view/home_screen/home_widgets/filter_bottom_sheet.dart';
import 'package:foodies/view/no_connection_screen/no_connection_screen.dart';
import 'package:foodies/view/profile_screen/profile_screen.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_screen.dart';
import 'package:foodies/widgets/app_name.dart';
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/separator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  ConnectivityController connectivityController = ConnectivityController();
  FilterController filterController = FilterController();
  List screens = [
    RecipeFeedScreen(),
    ContributeScreen(),
    FavouritesScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    getPermissions();
    connectivityController.checkConnectivity();
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
        title: AppName(size: DimenConstant.mText),
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
        //   bottom: pageIndex == 0 && filterController.filters.isNotEmpty
        //       ? PreferredSize(
        //           preferredSize: Size(double.infinity, 30),
        //           child: Expanded(
        //             child: ListView.separated(
        //               scrollDirection: Axis.horizontal,
        //               itemBuilder: (context, index) => FilterItem(
        //                 name:
        //                     Provider.of<FilterController>(context).filters[index],
        //                 isPressed: true,
        //                 onPressed: () {
        //                   Provider.of<FilterController>(
        //                     context,
        //                     listen: false,
        //                   ).removeFilter(
        //                     Provider.of<FilterController>(
        //                       context,
        //                       listen: false,
        //                     ).filters[index],
        //                   );
        //                 },
        //               ),
        //               separatorBuilder: (context, index) => SizedBox(
        //                 width: 5,
        //               ),
        //               itemCount:
        //                   Provider.of<FilterController>(context).filters.length,
        //             ),
        //           ),
        //         )
        //       : null,
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
          unselectedItemColor: ColorConstant.secondaryLight,
          selectedFontSize: DimenConstant.xsText,
          unselectedFontSize: DimenConstant.xsText,
          backgroundColor: ColorConstant.backgroundLight,
          type: BottomNavigationBarType.fixed,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
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
