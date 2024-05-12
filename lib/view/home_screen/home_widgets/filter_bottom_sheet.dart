import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodies/controller/filter_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/home_screen/home_widgets/filter_item.dart';
import 'package:foodies/widgets/separator.dart';
import 'package:provider/provider.dart';

class FilterBottomSheet extends StatefulWidget {
  FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int dietIndex = 0;
  List<int> cuisineIndexes = [0], categoryIndexes = [0];
  List<String> diet = [], cuisines = [], categories = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void didChangeDependencies() {
    getFilters();
    setState(() {});
    super.didChangeDependencies();
  }

  // get diet from firestore
  getDiet() async {
    DocumentSnapshot snapshot =
        await firestore.collection('database').doc('diet').get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    diet = List<String>.from(data['diet']);
  }

  // get cuisine from firestore
  getCuisines() async {
    DocumentSnapshot snapshot =
        await firestore.collection('database').doc('cuisines').get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    cuisines = List<String>.from(data['cuisines']);
  }

  // get categories from firestore
  getCategories() async {
    DocumentSnapshot snapshot =
        await firestore.collection('database').doc('categories').get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    categories = List<String>.from(data['categories']);
  }

  // get existing filters
  getFilters() {
    List<String> temp = Provider.of<FilterController>(context).filters;
    for (String value in temp) {
      if (diet.contains(value)) {
        dietIndex = diet.indexOf(value);
      } else if (cuisines.contains(value)) {
        cuisineIndexes.add(cuisines.indexOf(value) + 1);
      } else if (categories.contains(value)) {
        categoryIndexes.add(categories.indexOf(value) + 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        DimenConstant.padding,
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Diet',
                    style: TextStyle(
                      color: ColorConstant.primary,
                      fontSize: DimenConstant.sText,
                    ),
                  ),
                  Separator(),
                  SizedBox(
                    height: 32.5,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => FilterItem(
                        name: diet[index],
                        isPressed: dietIndex == index ? true : false,
                        onPressed: () {
                          dietIndex = index;
                          setState(() {});
                        },
                      ),
                      separatorBuilder: (context, index) => Separator(),
                      itemCount: diet.length,
                    ),
                  ),
                  Separator(),
                  Text(
                    'Cuisines',
                    style: TextStyle(
                      color: ColorConstant.primary,
                      fontSize: DimenConstant.sText,
                    ),
                  ),
                  Separator(),
                  SizedBox(
                    height: 150,
                    child: MasonryGridView.builder(
                      crossAxisSpacing: DimenConstant.padding,
                      mainAxisSpacing: DimenConstant.padding,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemBuilder: (context, index) => FilterItem(
                        name: index == 0 ? 'All' : cuisines[index - 1],
                        isPressed:
                            cuisineIndexes.contains(index) ? true : false,
                        onPressed: () {
                          if (index == 0) {
                            if (!cuisineIndexes.contains(index)) {
                              cuisineIndexes = [0];
                            }
                          } else {
                            if (cuisineIndexes.contains(0)) {
                              cuisineIndexes.remove(0);
                            }
                            if (cuisineIndexes.contains(index)) {
                              cuisineIndexes.remove(index);
                            } else {
                              cuisineIndexes.add(index);
                            }
                          }
                          if (cuisineIndexes.isEmpty) {
                            cuisineIndexes = [0];
                          }
                          setState(() {});
                        },
                      ),
                      itemCount: cuisines.length + 1,
                    ),
                  ),
                  Separator(),
                  Text(
                    'Categories',
                    style: TextStyle(
                      color: ColorConstant.primary,
                      fontSize: DimenConstant.sText,
                    ),
                  ),
                  Separator(),
                  SizedBox(
                    height: 72,
                    child: MasonryGridView.builder(
                      crossAxisSpacing: DimenConstant.padding,
                      mainAxisSpacing: DimenConstant.padding,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) => FilterItem(
                        name: index == 0 ? 'All' : categories[index - 1],
                        isPressed:
                            categoryIndexes.contains(index) ? true : false,
                        onPressed: () {
                          if (index == 0) {
                            if (!categoryIndexes.contains(index)) {
                              categoryIndexes = [0];
                            }
                          } else {
                            if (categoryIndexes.contains(0)) {
                              categoryIndexes.remove(0);
                            }
                            if (categoryIndexes.contains(index)) {
                              categoryIndexes.remove(index);
                            } else {
                              categoryIndexes.add(index);
                            }
                          }
                          if (categoryIndexes.isEmpty) {
                            categoryIndexes = [0];
                          }
                          setState(() {});
                        },
                      ),
                      itemCount: categories.length + 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Separator(),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      ColorConstant.primary,
                    ),
                  ),
                  onPressed: () {
                    Provider.of<FilterController>(context, listen: false)
                        .resetFilters();
                    dietIndex = 0;
                    cuisineIndexes = [0];
                    categoryIndexes = [0];
                    setState(() {});
                  },
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      color: ColorConstant.tertiaryLight,
                    ),
                  ),
                ),
              ),
              Separator(),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      ColorConstant.primary,
                    ),
                  ),
                  onPressed: () {
                    List<String> temp = [];
                    if (dietIndex != 0) {
                      temp.add(diet[dietIndex]);
                    }
                    if (cuisineIndexes != [0]) {
                      for (int i in cuisineIndexes) {
                        if (i != 0) temp.add(cuisines[i - 1]);
                      }
                    }
                    if (categoryIndexes != [0]) {
                      for (int i in categoryIndexes) {
                        if (i != 0) temp.add(categories[i - 1]);
                      }
                    }
                    Provider.of<FilterController>(context, listen: false)
                        .setFilters(temp);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: ColorConstant.tertiaryLight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
