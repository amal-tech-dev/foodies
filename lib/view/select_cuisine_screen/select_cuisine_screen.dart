import 'package:flutter/material.dart';
import 'package:foodies/controller/cuisine_controller.dart';
import 'package:foodies/database/database.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/home_screen/home_screen.dart';
import 'package:foodies/view/select_cuisine_screen/select_cuisine_widgets/cuisine_tile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectCuisineScreen extends StatelessWidget {
  const SelectCuisineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cuisineController =
        Provider.of<CuisineController>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(
            DimenConstant.edgePadding,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  DimenConstant.edgePadding * 3,
                ),
                child: Text(
                  StringConstant.selectCuisineText,
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: DimenConstant.subtitleText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: DimenConstant.edgePadding,
                    mainAxisSpacing: DimenConstant.edgePadding,
                  ),
                  itemBuilder: (context, index) => CuisineTile(
                    name: Database.cuisines[index],
                    isPressed: cuisineController.cuisineIndexes.contains(index)
                        ? true
                        : false,
                    onPressed: () {
                      cuisineController.cuisineIndexes.contains(index)
                          ? cuisineController.deleteIndex(index)
                          : cuisineController.addIndex(index);
                    },
                  ),
                  itemCount: Database.cuisines.length,
                ),
              ),
              DimenConstant.separator,
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                    Size(
                      MediaQuery.of(context).size.width,
                      45,
                    ),
                  ),
                  backgroundColor: MaterialStatePropertyAll(
                    ColorConstant.secondaryColor,
                  ),
                ),
                onPressed: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.setStringList(
                    'cuisines',
                    List.generate(
                      cuisineController.cuisineIndexes.length,
                      (index) => Database
                          .cuisines[cuisineController.cuisineIndexes[index]],
                    ),
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
