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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
                    'Preference',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.titleText,
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: currentIndex,
                      alignment: Alignment.centerRight,
                      icon: Icon(
                        Icons.expand_more_rounded,
                      ),
                      iconEnabledColor: ColorConstant.secondaryColor,
                      dropdownColor: ColorConstant.backgroundColor,
                      items: List.generate(
                        Database.preferences.length,
                        (index) => DropdownMenuItem(
                          value: index,
                          child: Text(
                            Database.preferences[index],
                            style: TextStyle(
                              color: ColorConstant.primaryColor,
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
                      alignment: Alignment.centerRight,
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
                            Database.cuisines[index],
                            style: TextStyle(
                              color: ColorConstant.primaryColor,
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
              DimenConstant.separator,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.titleText,
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: currentIndex,
                      alignment: Alignment.centerRight,
                      icon: Icon(
                        Icons.expand_more_rounded,
                      ),
                      iconEnabledColor: ColorConstant.secondaryColor,
                      dropdownColor: ColorConstant.backgroundColor,
                      items: List.generate(
                        Database.categories.length,
                        (index) => DropdownMenuItem(
                          value: index,
                          child: Text(
                            Database.categories[index],
                            style: TextStyle(
                              color: ColorConstant.primaryColor,
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
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      ColorConstant.secondaryColor,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                ),
              ),
              DimenConstant.separator,
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      ColorConstant.secondaryColor,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
