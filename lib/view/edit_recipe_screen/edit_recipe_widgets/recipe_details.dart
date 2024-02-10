import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/controller/add_recipe_controller.dart';
import 'package:foodies/controller/text_input_format_controller.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:provider/provider.dart';

class RecipeDetails extends StatefulWidget {
  RecipeDetails({super.key});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  FocusNode descriptionFocusNode = FocusNode();
  bool isCuisinePressed = false;
  bool isCategoriesPressed = false;
  bool isVeg = true;
  String selectedCuisine = '';
  List<String> selectedCategories = [];

  @override
  void initState() {
    nameController = TextEditingController(
        text: Provider.of<AddRecipeController>(context, listen: false)
            .editedRecipe
            .name);
    descriptionController = TextEditingController(
        text: Provider.of<AddRecipeController>(context, listen: false)
            .editedRecipe
            .description);
    timeController = TextEditingController(
        text: Provider.of<AddRecipeController>(context, listen: false)
            .editedRecipe
            .time);
    isVeg = Provider.of<AddRecipeController>(context, listen: false)
        .editedRecipe
        .veg;
    selectedCuisine = Provider.of<AddRecipeController>(context, listen: false)
        .editedRecipe
        .cuisine;
    selectedCategories =
        Provider.of<AddRecipeController>(context, listen: false)
            .editedRecipe
            .categories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding,
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
                      onSubmitted: (value) => FocusScope.of(context)
                          .requestFocus(descriptionFocusNode),
                    ),
                  ),
                  DimenConstant.separator,
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding,
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
                        LengthLimitingTextInputFormatter(200),
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
                            isVeg = true;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: DimenConstant.padding * 2,
                              horizontal: DimenConstant.padding,
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
                            isVeg = false;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: DimenConstant.padding * 2,
                              horizontal: DimenConstant.padding,
                            ),
                            decoration: BoxDecoration(
                              color: !isVeg
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
                                  color: !isVeg
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
                        vertical: DimenConstant.padding * 2,
                        horizontal: DimenConstant.padding,
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
                              horizontal: DimenConstant.padding,
                            ),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                selectedCuisine =
                                    StringConstant.cuisines[index + 1];
                                setState(() {});
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    groupValue: StringConstant.cuisines
                                        .indexOf(selectedCuisine),
                                    onChanged: (value) {
                                      selectedCuisine =
                                          StringConstant.cuisines[value!];
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
                        vertical: DimenConstant.padding * 2,
                        horizontal: DimenConstant.padding,
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
                      height: MediaQuery.of(context).size.height / 3,
                      child: Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: DimenConstant.padding,
                            ),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                selectedCategories.contains(
                                        StringConstant.categories[index + 1])
                                    ? selectedCategories.remove(
                                        StringConstant.categories[index + 1])
                                    : selectedCategories.add(
                                        StringConstant.categories[index + 1]);
                                setState(() {});
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    value: selectedCategories.contains(
                                            StringConstant
                                                .categories[index + 1])
                                        ? true
                                        : false,
                                    onChanged: (value) {
                                      value!
                                          ? selectedCategories.add(
                                              StringConstant
                                                  .categories[index + 1])
                                          : selectedCategories.remove(
                                              StringConstant
                                                  .categories[index + 1]);
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
                      horizontal: DimenConstant.padding,
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
            ),
          ),
          DimenConstant.separator,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                color: ColorConstant.primaryColor,
                onPressed: () =>
                    Provider.of<AddRecipeController>(context, listen: false)
                        .pageViewController
                        .previousPage(),
                icon: Icon(
                  Icons.navigate_before_rounded,
                  color: ColorConstant.tertiaryColor,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    ColorConstant.secondaryColor,
                  ),
                ),
              ),
              IconButton(
                color: ColorConstant.primaryColor,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Provider.of<AddRecipeController>(context, listen: false)
                      .update(
                    recipe: RecipeModel(
                      id: Provider.of<AddRecipeController>(context,
                              listen: false)
                          .editedRecipe
                          .id,
                      name: nameController.text.trim(),
                      cuisine: selectedCuisine,
                      description: descriptionController.text.trim(),
                      time: timeController.text.trim(),
                      image: Provider.of<AddRecipeController>(context,
                              listen: false)
                          .editedRecipe
                          .image,
                      chef: Provider.of<AddRecipeController>(context,
                              listen: false)
                          .editedRecipe
                          .chef,
                      veg: isVeg,
                      categories: selectedCategories,
                      ingredients: Provider.of<AddRecipeController>(context,
                              listen: false)
                          .editedRecipe
                          .ingredients,
                      steps: Provider.of<AddRecipeController>(context,
                              listen: false)
                          .editedRecipe
                          .steps,
                    ),
                  );
                  Provider.of<AddRecipeController>(context, listen: false)
                      .pageViewController
                      .nextPage();
                },
                icon: Icon(
                  Icons.navigate_next_rounded,
                  color: ColorConstant.tertiaryColor,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    ColorConstant.secondaryColor,
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
