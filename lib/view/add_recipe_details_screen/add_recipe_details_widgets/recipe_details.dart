import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/controller/add_recipe_controller.dart';
import 'package:foodies/controller/text_input_format_controller.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:provider/provider.dart';

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
  bool cuisinePressed = false;
  bool categoriesPressed = false;
  bool veg = true;
  String selectedCuisine = '';
  List<String> selectedCategories = [], cuisines = [], categories = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
    veg = Provider.of<AddRecipeController>(context, listen: false)
        .editedRecipe
        .veg!;
    selectedCuisine = Provider.of<AddRecipeController>(context, listen: false)
        .editedRecipe
        .cuisine!;
    selectedCategories =
        Provider.of<AddRecipeController>(context, listen: false)
            .editedRecipe
            .categories!;
    getCuisines();
    getCategories();
    super.initState();
  }

  // get cuisines from firebase
  getCuisines() async {
    DocumentReference reference =
        firestore.collection('database').doc('cuisines');
    DocumentSnapshot snapshot = await reference.get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    cuisines = data['cusines'];
    setState(() {});
  }

  // get categories from firebase
  getCategories() async {
    DocumentReference reference =
        firestore.collection('database').doc('categories');
    DocumentSnapshot snapshot = await reference.get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    categories = data['categories'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomContainer(
                    paddingTop: 0,
                    paddingBottom: 0,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        label: Text(
                          'Name',
                          style: TextStyle(
                            color: ColorConstant.secondary,
                            fontSize: DimenConstant.mini,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: ColorConstant.primary,
                        fontSize: DimenConstant.mini,
                      ),
                      cursorColor: ColorConstant.secondary,
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
                  CustomContainer(
                    paddingTop: 0,
                    paddingBottom: 0,
                    child: TextField(
                      controller: descriptionController,
                      focusNode: descriptionFocusNode,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        label: Text(
                          'Description',
                          style: TextStyle(
                            color: ColorConstant.secondary,
                            fontSize: DimenConstant.mini,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: ColorConstant.primary,
                        fontSize: DimenConstant.mini,
                      ),
                      cursorColor: ColorConstant.secondary,
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
                        child: CustomContainer(
                          paddingTop: DimenConstant.padding * 2,
                          paddingBottom: DimenConstant.padding * 2,
                          backgroundColor: veg ? ColorConstant.secondary : null,
                          onPressed: () {
                            veg = true;
                            setState(() {});
                          },
                          child: Center(
                            child: Text(
                              'Vegetarian',
                              style: TextStyle(
                                color: veg
                                    ? ColorConstant.tertiary
                                    : ColorConstant.secondary,
                                fontSize: DimenConstant.mini,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DimenConstant.separator,
                      Expanded(
                        child: CustomContainer(
                          paddingTop: DimenConstant.padding * 2,
                          paddingBottom: DimenConstant.padding * 2,
                          backgroundColor: veg ? null : ColorConstant.secondary,
                          onPressed: () {
                            veg = false;
                            setState(() {});
                          },
                          child: Center(
                            child: Text(
                              'Non-Vegetarian',
                              style: TextStyle(
                                color: veg
                                    ? ColorConstant.tertiary
                                    : ColorConstant.secondary,
                                fontSize: DimenConstant.mini,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  DimenConstant.separator,
                  CustomContainer(
                    paddingTop: DimenConstant.padding * 2,
                    paddingBottom: DimenConstant.padding * 2,
                    onPressed: () {
                      cuisinePressed = !cuisinePressed;
                      categoriesPressed = false;
                      setState(() {});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cuisines',
                          style: TextStyle(
                            color: ColorConstant.secondary,
                            fontSize: DimenConstant.mini,
                          ),
                        ),
                        Icon(
                          cuisinePressed
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: ColorConstant.secondary,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: cuisinePressed,
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
                                selectedCuisine = cuisines[index];
                                setState(() {});
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    cuisines[index],
                                    style: TextStyle(
                                      color: ColorConstant.primary,
                                      fontSize: DimenConstant.mini,
                                    ),
                                  ),
                                  Radio(
                                    activeColor: ColorConstant.secondary,
                                    value: index + 1,
                                    groupValue:
                                        cuisines.indexOf(selectedCuisine),
                                    onChanged: (value) {
                                      selectedCuisine = cuisines[value! as int];
                                      setState(() {});
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          itemCount: cuisines.length,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !cuisinePressed,
                    child: DimenConstant.separator,
                  ),
                  CustomContainer(
                    paddingTop: DimenConstant.padding * 2,
                    paddingBottom: DimenConstant.padding * 2,
                    onPressed: () {
                      categoriesPressed = !categoriesPressed;
                      cuisinePressed = false;
                      setState(() {});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(
                            color: ColorConstant.secondary,
                            fontSize: DimenConstant.mini,
                          ),
                        ),
                        Icon(
                          categoriesPressed
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: ColorConstant.secondary,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: categoriesPressed,
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
                                selectedCategories.contains(categories[index])
                                    ? selectedCategories
                                        .remove(categories[index])
                                    : selectedCategories.add(categories[index]);
                                setState(() {});
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    categories[index],
                                    style: TextStyle(
                                      color: ColorConstant.primary,
                                      fontSize: DimenConstant.mini,
                                    ),
                                  ),
                                  Checkbox(
                                    activeColor: ColorConstant.secondary,
                                    checkColor: ColorConstant.tertiary,
                                    value: selectedCategories
                                            .contains(categories[index])
                                        ? true
                                        : false,
                                    onChanged: (value) {
                                      value!
                                          ? selectedCategories
                                              .add(categories[index])
                                          : selectedCategories
                                              .remove(categories[index]);
                                      setState(() {});
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          itemCount: categories.length,
                        ),
                      ),
                    ),
                  ),
                  DimenConstant.separator,
                  CustomContainer(
                    paddingTop: 0.0,
                    paddingBottom: 0.0,
                    child: TextField(
                      controller: timeController,
                      decoration: InputDecoration(
                        label: Text(
                          'Cooking Time',
                          style: TextStyle(
                            color: ColorConstant.secondary,
                            fontSize: DimenConstant.mini,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: ColorConstant.primary,
                        fontSize: DimenConstant.mini,
                      ),
                      cursorColor: ColorConstant.secondary,
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
                color: ColorConstant.primary,
                onPressed: () =>
                    Provider.of<AddRecipeController>(context, listen: false)
                        .pageViewController
                        .previousPage(),
                icon: Icon(
                  Icons.navigate_before_rounded,
                  color: ColorConstant.tertiary,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    ColorConstant.secondary,
                  ),
                ),
              ),
              IconButton(
                color: ColorConstant.primary,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Provider.of<AddRecipeController>(context, listen: false)
                      .update(
                    recipe: RecipeModel(
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
                      veg: veg,
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
                  color: ColorConstant.tertiary,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    ColorConstant.secondary,
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
