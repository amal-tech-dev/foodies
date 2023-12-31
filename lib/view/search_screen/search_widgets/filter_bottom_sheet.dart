import 'package:flutter/material.dart';
import 'package:foodies/database/database.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class FilterBottomSheet extends StatelessWidget {
  FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Container(
      padding: EdgeInsets.all(
        DimenConstant.edgePadding,
      ),
      child: Column(
        children: [
          Text(
            'Filters',
            style: TextStyle(
              color: ColorConstant.primaryColor,
              fontSize: DimenConstant.mediumText,
            ),
          ),
          DimenConstant.separator,
          DimenConstant.separator,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cuisine',
                style: TextStyle(
                  color: ColorConstant.primaryColor,
                  fontSize: DimenConstant.titleText,
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: currentIndex,
                  icon: Icon(
                    Icons.expand_more_rounded,
                  ),
                  iconEnabledColor: ColorConstant.secondaryColor,
                  dropdownColor: ColorConstant.backgroundColor,
                  items: List.generate(
                    Database.cuisines.length,
                    (index) => DropdownMenuItem(
                      value: index,
                      child: Text(
                        'All',
                        style: TextStyle(
                          color: ColorConstant.secondaryColor,
                          fontSize: DimenConstant.subtitleText,
                        ),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    currentIndex = value ?? currentIndex;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
