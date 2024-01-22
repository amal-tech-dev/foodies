import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/controller/text_input_format_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';

class RecipeDetails extends StatefulWidget {
  RecipeDetails({super.key});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  FocusNode descriptionFocusNode = FocusNode();
  int selectedCuisine = 0;
  List<int> selectedCategories = [];
  bool isCuisinePressed = false;
  bool isCategoriesPressed = false;
  bool isVeg = false;
  bool isNonveg = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: DimenConstant.edgePadding,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.tertiaryColor,
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
            ),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                label: Text(
                  'Name',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.miniText,
                  ),
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: ColorConstant.primaryColor,
                fontSize: DimenConstant.miniText,
              ),
              cursorColor: ColorConstant.secondaryColor,
              cursorRadius: Radius.circular(
                DimenConstant.cursorRadius,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
                TextInputFormatController(),
              ],
              textCapitalization: TextCapitalization.sentences,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              onSubmitted: (value) =>
                  FocusScope.of(context).requestFocus(descriptionFocusNode),
            ),
          ),
          DimenConstant.separator,
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: DimenConstant.edgePadding,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.tertiaryColor,
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
            ),
            child: TextField(
              controller: descriptionController,
              focusNode: descriptionFocusNode,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                label: Text(
                  'Description',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.miniText,
                  ),
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: ColorConstant.primaryColor,
                fontSize: DimenConstant.miniText,
              ),
              cursorColor: ColorConstant.secondaryColor,
              cursorRadius: Radius.circular(
                DimenConstant.cursorRadius,
              ),
              maxLines: 5,
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
                TextInputFormatController(),
              ],
              textCapitalization: TextCapitalization.sentences,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
          ),
          DimenConstant.separator,
          Row(
            children: [
              Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    isVeg = !isVeg;
                    isNonveg = false;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: DimenConstant.edgePadding * 2,
                      horizontal: DimenConstant.edgePadding,
                    ),
                    decoration: BoxDecoration(
                      color: isVeg
                          ? ColorConstant.secondaryColor
                          : ColorConstant.tertiaryColor,
                      borderRadius: BorderRadius.circular(
                        DimenConstant.borderRadius,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Vegetarian',
                        style: TextStyle(
                          color: isVeg
                              ? ColorConstant.tertiaryColor
                              : ColorConstant.secondaryColor,
                          fontSize: DimenConstant.miniText,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              DimenConstant.separator,
              Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    isNonveg = !isNonveg;
                    isVeg = false;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: DimenConstant.edgePadding * 2,
                      horizontal: DimenConstant.edgePadding,
                    ),
                    decoration: BoxDecoration(
                      color: isNonveg
                          ? ColorConstant.secondaryColor
                          : ColorConstant.tertiaryColor,
                      borderRadius: BorderRadius.circular(
                        DimenConstant.borderRadius,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Non-Vegetarian',
                        style: TextStyle(
                          color: isNonveg
                              ? ColorConstant.tertiaryColor
                              : ColorConstant.secondaryColor,
                          fontSize: DimenConstant.miniText,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          DimenConstant.separator,
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              isCuisinePressed = !isCuisinePressed;
              isCategoriesPressed = false;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: DimenConstant.edgePadding * 2,
                horizontal: DimenConstant.edgePadding,
              ),
              decoration: BoxDecoration(
                color: ColorConstant.tertiaryColor,
                borderRadius: BorderRadius.circular(
                  DimenConstant.borderRadius,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cuisines',
                    style: TextStyle(
                      color: ColorConstant.secondaryColor,
                      fontSize: DimenConstant.miniText,
                    ),
                  ),
                  Icon(
                    isCuisinePressed
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: ColorConstant.secondaryColor,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isCuisinePressed,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.edgePadding,
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectedCuisine = index + 1;
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            StringConstant.cuisines[index + 1],
                            style: TextStyle(
                              color: ColorConstant.primaryColor,
                              fontSize: DimenConstant.miniText,
                            ),
                          ),
                          Radio(
                            activeColor: ColorConstant.secondaryColor,
                            value: index + 1,
                            groupValue: selectedCuisine,
                            onChanged: (value) {
                              selectedCuisine = value!;
                              setState(() {});
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  itemCount: StringConstant.cuisines.length - 1,
                ),
              ),
            ),
          ),
          Visibility(
            visible: !isCuisinePressed,
            child: DimenConstant.separator,
          ),
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              isCategoriesPressed = !isCategoriesPressed;
              isCuisinePressed = false;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: DimenConstant.edgePadding * 2,
                horizontal: DimenConstant.edgePadding,
              ),
              decoration: BoxDecoration(
                color: ColorConstant.tertiaryColor,
                borderRadius: BorderRadius.circular(
                  DimenConstant.borderRadius,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      color: ColorConstant.secondaryColor,
                      fontSize: DimenConstant.miniText,
                    ),
                  ),
                  Icon(
                    isCategoriesPressed
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: ColorConstant.secondaryColor,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isCategoriesPressed,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.edgePadding,
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectedCategories.contains(index + 1)
                            ? selectedCategories.remove(index + 1)
                            : selectedCategories.add(index + 1);
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            StringConstant.categories[index + 1],
                            style: TextStyle(
                              color: ColorConstant.primaryColor,
                              fontSize: DimenConstant.miniText,
                            ),
                          ),
                          Checkbox(
                            activeColor: ColorConstant.secondaryColor,
                            checkColor: ColorConstant.tertiaryColor,
                            value: selectedCategories.contains(index + 1)
                                ? true
                                : false,
                            onChanged: (value) {
                              value!
                                  ? selectedCategories.add(index + 1)
                                  : selectedCategories.remove(index + 1);
                              setState(() {});
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  itemCount: StringConstant.categories.length - 1,
                ),
              ),
            ),
          ),
          DimenConstant.separator,
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: DimenConstant.edgePadding,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.tertiaryColor,
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
            ),
            child: TextField(
              controller: timeController,
              decoration: InputDecoration(
                label: Text(
                  'Cooking Time',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.miniText,
                  ),
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: ColorConstant.primaryColor,
                fontSize: DimenConstant.miniText,
              ),
              cursorColor: ColorConstant.secondaryColor,
              cursorRadius: Radius.circular(
                DimenConstant.cursorRadius,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
                TextInputFormatController(),
              ],
              textCapitalization: TextCapitalization.sentences,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              onSubmitted: (value) => FocusScope.of(context).unfocus(),
            ),
          )
        ],
      ),
    );
  }
}
