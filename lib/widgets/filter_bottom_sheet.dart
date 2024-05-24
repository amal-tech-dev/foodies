import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodies/controller/filter_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_text.dart';
import 'package:foodies/widgets/filter_item.dart';
import 'package:foodies/widgets/separator.dart';
import 'package:provider/provider.dart';

class FilterBottomSheet extends StatefulWidget {
  FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String diet = 'Semi-Vegetarian';
  List<String> cuisines = ['All'], categories = ['All'];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: ColorConstant.backgroundLight,
      child: Column(
        children: [
          CustomText(
            text: 'Diet',
            color: ColorConstant.primary,
          ),
          Separator(),
          StreamBuilder(
              stream: firestore.collection('database').doc('diet').snapshots(),
              builder: (context, snapshot) {
                Map<String, dynamic> data = snapshot.data!.data()!;
                return Expanded(
                  flex: 0,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => FilterItem(
                      name: data[index],
                      pressed: diet == data[index],
                      onPressed: () {
                        diet = data[index];
                        setState(() {});
                      },
                    ),
                    separatorBuilder: (context, index) => Separator(),
                    itemCount: diet.length,
                  ),
                );
              }),
          Separator(),
          Text(
            'Cuisines',
            style: TextStyle(
              color: ColorConstant.primary,
              fontSize: DimenConstant.small,
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
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) => FilterItem(
                name: index == 0 ? 'All' : cuisines[index - 1],
                pressed: cuisines.contains(index) ? true : false,
                onPressed: () {
                  if (index == 0) {
                    if (!cuisines.contains(index)) {
                      cuisines = [0];
                    }
                  } else {
                    if (cuisines.contains(0)) {
                      cuisines.remove(0);
                    }
                    if (cuisines.contains(index)) {
                      cuisines.remove(index);
                    } else {
                      cuisines.add(index);
                    }
                  }
                  if (cuisines.isEmpty) {
                    cuisines = [0];
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
              fontSize: DimenConstant.small,
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
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => FilterItem(
                name: index == 0 ? 'All' : categories[index - 1],
                pressed: categories.contains(index) ? true : false,
                onPressed: () {
                  if (index == 0) {
                    if (!categories.contains(index)) {
                      categories = [0];
                    }
                  } else {
                    if (categories.contains(0)) {
                      categories.remove(0);
                    }
                    if (categories.contains(index)) {
                      categories.remove(index);
                    } else {
                      categories.add(index);
                    }
                  }
                  if (categories.isEmpty) {
                    categories = [0];
                  }
                  setState(() {});
                },
              ),
              itemCount: categories.length + 1,
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
                    diet = 0;
                    cuisines = [0];
                    categories = [0];
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
                    if (diet != 0) {
                      temp.add(diet[diet]);
                    }
                    if (cuisines != [0]) {
                      for (int i in cuisines) {
                        if (i != 0) temp.add(cuisines[i - 1]);
                      }
                    }
                    if (categories != [0]) {
                      for (int i in categories) {
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
