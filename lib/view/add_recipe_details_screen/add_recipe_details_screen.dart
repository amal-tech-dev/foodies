import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/add_recipe_details_screen/add_recipe_details_widgets/page_item.dart';
import 'package:foodies/view/add_recipe_details_screen/add_recipe_details_widgets/slidable_item.dart';
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_scaffold_messenger.dart';
import 'package:foodies/widgets/custom_text.dart';
import 'package:foodies/widgets/custom_text_field.dart';
import 'package:foodies/widgets/pick_image_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';

class AddRecipeDetailsScreen extends StatefulWidget {
  AddRecipeDetailsScreen({super.key});

  @override
  State<AddRecipeDetailsScreen> createState() => _AddRecipeDetailsScreenState();
}

class _AddRecipeDetailsScreenState extends State<AddRecipeDetailsScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  RecipeModel recipe = RecipeModel();
  PageController pageController = PageController();
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController ingredientController = TextEditingController();
  TextEditingController stepController = TextEditingController();
  bool buttonVisibility = false, editing = false;
  List cuisines = [], categories = [], selectedCategories = [];
  String? selectedCuisine, imageUrl;
  List<String> ingredients = [], steps = [], imageUrls = [];
  List<bool> checkValues = [];
  int radioValue = -1, editingIndex = -1;
  File? image;
  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    getCuisine();
    getCategories();
    getImageUrls();
    nameController.addListener(() {
      buttonVisibility = nameController.text.isNotEmpty;
      setState(() {});
    });
    aboutController.addListener(() {
      buttonVisibility = aboutController.text.isNotEmpty;
      setState(() {});
    });
    timeController.addListener(() {
      buttonVisibility = timeController.text.isNotEmpty;
      setState(() {});
    });
    super.initState();
  }

  // get cuisines from firebase
  getCuisine() async {
    DocumentReference reference =
        firestore.collection('database').doc('cuisines');
    DocumentSnapshot snapshot = await reference.get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    cuisines = data['cuisines'];
    setState(() {});
  }

  // get categories from firebase
  getCategories() async {
    DocumentReference reference =
        firestore.collection('database').doc('categories');
    DocumentSnapshot snapshot = await reference.get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    categories = data['categories'];
    checkValues = List.generate(categories.length, (index) => false);
    setState(() {});
  }

  getImageUrls() async {
    ListResult listResult = await storage.ref('food_items').listAll();
    for (Reference ref in listResult.items) {
      String url = await ref.getDownloadURL();
      imageUrls.add(url);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundDark,
        surfaceTintColor: Colors.transparent,
        leading: CustomButton.back(),
        title: Text(
          'Add Recipe',
          style: TextStyle(
            color: ColorConstant.secondaryDark,
            fontSize: DimenConstant.small,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.padding,
        ),
        child: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            PageItem(
              header: StringConstant.addRecipeName,
              image: ImageConstant.chef,
              children: [
                SliverToBoxAdapter(
                  child: CustomContainer(
                    paddingVertical: 0,
                    child: CustomTextField.singleLine(
                      context: context,
                      hint: 'Recipe Name',
                      controller: nameController,
                      limit: 20,
                      onSubmitted: () {
                        recipe.name = nameController.text.trim();
                        buttonVisibility = false;
                        setState(() {});
                        FocusScope.of(context).unfocus();
                        pageController.nextPage(
                          duration: Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.bounceInOut,
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DimenConstant.separator,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding * 10,
                    ),
                    child: CustomButton.text(
                      visible: buttonVisibility,
                      text: 'Next',
                      onPressed: () {
                        recipe.name = nameController.text.trim();
                        buttonVisibility = false;
                        setState(() {});
                        FocusScope.of(context).unfocus();
                        pageController.nextPage(
                          duration: Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.bounceInOut,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            PageItem(
              header: StringConstant.addRecipeAbout,
              image: ImageConstant.chef,
              children: [
                SliverToBoxAdapter(
                  child: CustomContainer(
                    child: CustomTextField.multiLine(
                      context: context,
                      hint: 'About',
                      controller: aboutController,
                      lines: 5,
                      limit: 100,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DimenConstant.separator,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding * 10,
                    ),
                    child: CustomButton.text(
                      visible: buttonVisibility,
                      text: 'Next',
                      onPressed: () {
                        recipe.about = aboutController.text.trim();
                        buttonVisibility = false;
                        setState(() {});
                        FocusScope.of(context).unfocus();
                        pageController.nextPage(
                          duration: Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.bounceInOut,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            PageItem(
              header: StringConstant.addRecipeDiet,
              image: ImageConstant.chef,
              children: [
                SliverToBoxAdapter(
                  child: CustomContainer(
                    height: 100,
                    paddingTop: DimenConstant.padding * 2,
                    paddingLeft: DimenConstant.padding * 2,
                    paddingRight: DimenConstant.padding * 2,
                    paddingBottom: DimenConstant.padding * 2,
                    gradient: LinearGradient(
                      colors: [
                        ColorConstant.vegPrimary,
                        ColorConstant.vegSecondary,
                      ],
                    ),
                    onPressed: () {
                      recipe.veg = true;
                      setState(() {});
                      pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.bounceInOut,
                      );
                    },
                    child: Center(
                      child: Text(
                        'Vegetarian',
                        style: TextStyle(
                          color: ColorConstant.secondaryDark,
                          fontSize: DimenConstant.small,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DimenConstant.separator,
                ),
                SliverToBoxAdapter(
                  child: CustomContainer(
                    height: 100,
                    paddingTop: DimenConstant.padding * 2,
                    paddingLeft: DimenConstant.padding * 2,
                    paddingRight: DimenConstant.padding * 2,
                    paddingBottom: DimenConstant.padding * 2,
                    gradient: LinearGradient(
                      colors: [
                        ColorConstant.nonVegPrimary,
                        ColorConstant.nonVegSecondary,
                      ],
                    ),
                    onPressed: () {
                      recipe.veg = false;
                      setState(() {});
                      pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.bounceInOut,
                      );
                    },
                    child: Center(
                      child: Text(
                        'Non-Vegetarian',
                        style: TextStyle(
                          color: ColorConstant.secondaryDark,
                          fontSize: DimenConstant.small,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            PageItem(
              header: StringConstant.addRecipeTime,
              image: ImageConstant.chef,
              children: [
                SliverToBoxAdapter(
                  child: CustomContainer(
                    paddingVertical: 0,
                    child: CustomTextField.singleLine(
                      context: context,
                      hint: 'Cooking Time',
                      controller: timeController,
                      limit: 20,
                      onSubmitted: () {
                        recipe.time = timeController.text.trim();
                        buttonVisibility = false;
                        setState(() {});
                        FocusScope.of(context).unfocus();
                        pageController.nextPage(
                          duration: Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.bounceInOut,
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DimenConstant.separator,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding * 10,
                    ),
                    child: CustomButton.text(
                      visible: buttonVisibility,
                      text: 'Next',
                      onPressed: () {
                        recipe.time = timeController.text.trim();
                        buttonVisibility = false;
                        setState(() {});
                        FocusScope.of(context).unfocus();
                        pageController.nextPage(
                          duration: Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.bounceInOut,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            PageItem(
              header: StringConstant.addRecipeCuisine,
              image: ImageConstant.chef,
              children: [
                SliverToBoxAdapter(
                  child: CustomContainer(
                    padding: 0,
                    child: ExpansionTile(
                      title: Text(
                        'Cuisines',
                        style: TextStyle(
                          color: ColorConstant.secondaryDark,
                          fontSize: DimenConstant.extraSmall,
                        ),
                      ),
                      subtitle: selectedCuisine == null
                          ? null
                          : Text(
                              selectedCuisine ?? '',
                              style: TextStyle(
                                color: ColorConstant.primary,
                                fontSize: DimenConstant.mini,
                              ),
                            ),
                      iconColor: ColorConstant.primary,
                      collapsedIconColor: ColorConstant.primary,
                      collapsedShape: InputBorder.none,
                      shape: InputBorder.none,
                      childrenPadding: EdgeInsets.only(
                        left: DimenConstant.padding * 2,
                        right: DimenConstant.padding,
                      ),
                      children: [
                        CustomContainer(
                          paddingTop: 0,
                          paddingLeft: 0,
                          paddingRight: 0,
                          paddingBottom: 0,
                          height: 200,
                          child: Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  selectedCuisine = cuisines[index];
                                  radioValue = index;
                                  buttonVisibility = true;
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        cuisines[index],
                                        style: TextStyle(
                                          color: ColorConstant.secondaryDark,
                                          fontSize: DimenConstant.mini,
                                        ),
                                      ),
                                    ),
                                    Radio(
                                      value: index,
                                      groupValue: radioValue,
                                      activeColor: ColorConstant.primary,
                                      onChanged: (value) {
                                        selectedCuisine = cuisines[index];
                                        radioValue = index;
                                        buttonVisibility = true;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              itemCount: cuisines.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DimenConstant.separator,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding * 10,
                    ),
                    child: CustomButton.text(
                      visible: buttonVisibility,
                      text: 'Next',
                      onPressed: () {
                        recipe.cuisine = selectedCuisine;
                        buttonVisibility = false;
                        setState(() {});
                        pageController.nextPage(
                          duration: Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.bounceInOut,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            PageItem(
              header: StringConstant.addRecipeCategories,
              image: ImageConstant.chef,
              children: [
                SliverToBoxAdapter(
                  child: CustomContainer(
                    padding: 0,
                    child: ExpansionTile(
                      title: Text(
                        'Categories',
                        style: TextStyle(
                          color: ColorConstant.secondaryDark,
                          fontSize: DimenConstant.extraSmall,
                        ),
                      ),
                      subtitle: selectedCategories.isEmpty
                          ? null
                          : Text(
                              selectedCategories.join(' | '),
                              style: TextStyle(
                                color: ColorConstant.primary,
                                fontSize: DimenConstant.mini,
                              ),
                            ),
                      iconColor: ColorConstant.primary,
                      collapsedIconColor: ColorConstant.primary,
                      collapsedShape: InputBorder.none,
                      shape: InputBorder.none,
                      childrenPadding: EdgeInsets.only(
                        left: DimenConstant.padding * 2,
                        right: DimenConstant.padding,
                      ),
                      children: [
                        CustomContainer(
                          paddingTop: 0,
                          paddingLeft: 0,
                          paddingRight: 0,
                          paddingBottom: 0,
                          height: 200,
                          child: Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  checkValues[index] = !checkValues[index];
                                  selectedCategories = [];
                                  for (int i = 0; i < checkValues.length; i++) {
                                    if (checkValues[i])
                                      selectedCategories.add(categories[i]);
                                  }
                                  buttonVisibility =
                                      selectedCategories.isEmpty ? false : true;
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        categories[index],
                                        style: TextStyle(
                                          color: ColorConstant.secondaryDark,
                                          fontSize: DimenConstant.mini,
                                        ),
                                      ),
                                    ),
                                    Checkbox(
                                      value: checkValues[index],
                                      checkColor: ColorConstant.tertiaryDark,
                                      activeColor: ColorConstant.primary,
                                      onChanged: (value) {
                                        checkValues[index] = value ?? false;
                                        selectedCategories = [];
                                        for (int i = 0;
                                            i < checkValues.length;
                                            i++) {
                                          if (checkValues[i])
                                            selectedCategories
                                                .add(categories[i]);
                                        }
                                        buttonVisibility =
                                            selectedCategories.isEmpty
                                                ? false
                                                : true;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              itemCount: categories.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DimenConstant.separator,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding * 10,
                    ),
                    child: CustomButton.text(
                      visible: buttonVisibility,
                      text: 'Next',
                      onPressed: () {
                        recipe.categories = [...selectedCategories];
                        buttonVisibility = false;
                        setState(() {});
                        pageController.nextPage(
                          duration: Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.bounceInOut,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            PageItem(
              header: StringConstant.addRecipeIngredients,
              image: ImageConstant.chef,
              children: [
                SliverToBoxAdapter(
                  child: Center(
                    child: CustomText(
                      visible: ingredients.isNotEmpty,
                      text:
                          'Slide ingredients to edit or delete. Press ingredient to undo edit.',
                      color: ColorConstant.primary,
                      size: DimenConstant.mini,
                      align: TextAlign.center,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: ingredients.isNotEmpty,
                    child: DimenConstant.separator,
                  ),
                ),
                SliverList.separated(
                  itemBuilder: (context, index) => index == ingredients.length
                      ? Row(
                          children: [
                            Expanded(
                              child: CustomContainer(
                                paddingVertical: 0,
                                child: CustomTextField.singleLine(
                                  context: context,
                                  hint: 'Ingredient',
                                  controller: ingredientController,
                                  limit: 30,
                                  onSubmitted: () {
                                    if (ingredientController.text.isEmpty) {
                                      CustomScaffoldMessenger.snackBar(
                                        context: context,
                                        content: 'Ingredient is empty',
                                      );
                                    } else {
                                      if (editing) {
                                        ingredients[editingIndex] =
                                            ingredientController.text.trim();
                                        editing = false;
                                        editingIndex = -1;
                                      } else {
                                        ingredients.add(
                                            ingredientController.text.trim());
                                      }
                                      ingredientController.clear();
                                      buttonVisibility = true;
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                            ),
                            DimenConstant.separator,
                            CustomContainer(
                              paddingVertical: DimenConstant.padding * 1.5,
                              paddingHorizontal: DimenConstant.padding * 2.5,
                              onPressed: () {
                                if (ingredientController.text.isEmpty) {
                                  CustomScaffoldMessenger.snackBar(
                                    context: context,
                                    content: 'Ingredient is empty',
                                  );
                                } else {
                                  if (editing) {
                                    ingredients[editingIndex] =
                                        ingredientController.text.trim();
                                    editing = false;
                                    editingIndex = -1;
                                  } else {
                                    ingredients
                                        .add(ingredientController.text.trim());
                                  }
                                  ingredientController.clear();
                                  buttonVisibility = true;
                                  setState(() {});
                                }
                              },
                              child: CustomText(
                                text: editing ? 'Update' : 'Add',
                                color: ColorConstant.primary,
                                size: DimenConstant.mini,
                              ),
                            ),
                          ],
                        )
                      : SlidableItem(
                          item: ingredients[index],
                          editing: editingIndex == index,
                          onItemPressed: () {
                            editing = false;
                            ingredientController.clear();
                            editingIndex = -1;
                            setState(() {});
                          },
                          onEditPressed: () {
                            editing = true;
                            ingredientController = TextEditingController(
                              text: ingredients[index],
                            );
                            editingIndex = index;
                            setState(() {});
                          },
                          onDeletePressed: () {
                            ingredients.removeAt(index);
                            if (ingredients.isEmpty) buttonVisibility = false;
                            setState(() {});
                          },
                        ),
                  separatorBuilder: (context, index) => DimenConstant.separator,
                  itemCount: ingredients.length + 1,
                ),
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: buttonVisibility,
                    child: DimenConstant.separator,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding * 10,
                    ),
                    child: CustomButton.text(
                      visible: buttonVisibility,
                      text: 'Next',
                      onPressed: () {
                        recipe.ingredients = ingredients;
                        buttonVisibility = false;
                        editingIndex = -1;
                        setState(() {});
                        pageController.nextPage(
                          duration: Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.bounceInOut,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            PageItem(
              header: StringConstant.addRecipeSteps,
              image: ImageConstant.chef,
              children: [
                SliverToBoxAdapter(
                  child: Center(
                    child: CustomText(
                      visible: steps.isNotEmpty,
                      text:
                          'Slide steps to edit or delete. Press step to undo edit.',
                      color: ColorConstant.primary,
                      size: DimenConstant.mini,
                      align: TextAlign.center,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: steps.isNotEmpty,
                    child: DimenConstant.separator,
                  ),
                ),
                SliverList.separated(
                  itemBuilder: (context, index) => index == steps.length
                      ? Row(
                          children: [
                            Expanded(
                              child: CustomContainer(
                                paddingVertical: 0,
                                child: CustomTextField.singleLine(
                                  context: context,
                                  hint: 'Step',
                                  controller: stepController,
                                  limit: 30,
                                  onSubmitted: () {
                                    if (stepController.text.isEmpty) {
                                      CustomScaffoldMessenger.snackBar(
                                        context: context,
                                        content: 'Step is empty',
                                      );
                                    } else {
                                      if (editing) {
                                        steps[editingIndex] =
                                            stepController.text.trim();
                                        editing = false;
                                        editingIndex = -1;
                                      } else {
                                        steps.add(stepController.text.trim());
                                      }
                                      stepController.clear();
                                      buttonVisibility = true;
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                            ),
                            DimenConstant.separator,
                            CustomContainer(
                              paddingVertical: DimenConstant.padding * 1.5,
                              paddingHorizontal: DimenConstant.padding * 2.5,
                              onPressed: () {
                                if (stepController.text.isEmpty) {
                                  CustomScaffoldMessenger.snackBar(
                                    context: context,
                                    content: 'Step is empty',
                                  );
                                } else {
                                  if (editing) {
                                    steps[editingIndex] =
                                        stepController.text.trim();
                                    editing = false;
                                    editingIndex = -1;
                                  } else {
                                    steps.add(stepController.text.trim());
                                  }
                                  stepController.clear();
                                  buttonVisibility = true;
                                  setState(() {});
                                }
                              },
                              child: CustomText(
                                text: editing ? 'Update' : 'Add',
                                color: ColorConstant.primary,
                                size: DimenConstant.mini,
                              ),
                            ),
                          ],
                        )
                      : SlidableItem(
                          item: steps[index],
                          editing: editingIndex == index,
                          onItemPressed: () {
                            editing = false;
                            stepController.clear();
                            editingIndex = -1;
                            setState(() {});
                          },
                          onEditPressed: () {
                            editing = true;
                            stepController = TextEditingController(
                              text: steps[index],
                            );
                            editingIndex = index;
                            setState(() {});
                          },
                          onDeletePressed: () {
                            steps.removeAt(index);
                            if (steps.isEmpty) buttonVisibility = false;
                            setState(() {});
                          },
                        ),
                  separatorBuilder: (context, index) => DimenConstant.separator,
                  itemCount: steps.length + 1,
                ),
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: buttonVisibility,
                    child: DimenConstant.separator,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding * 10,
                    ),
                    child: CustomButton.text(
                      visible: buttonVisibility,
                      text: 'Next',
                      onPressed: () {
                        recipe.steps = steps;
                        buttonVisibility = false;
                        editingIndex = -1;
                        setState(() {});
                        pageController.nextPage(
                          duration: Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.bounceInOut,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            PageItem(
              header: StringConstant.addRecipeImage,
              image: ImageConstant.chef,
              children: [
                SliverToBoxAdapter(
                  child: CarouselSlider(
                    items: List.generate(
                      imageUrls.length,
                      (index) => CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage(
                          ImageConstant.food,
                        ),
                        foregroundImage: NetworkImage(
                          imageUrls[index],
                        ),
                      ),
                    ),
                    options: CarouselOptions(
                      height: 90,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 2),
                      viewportFraction: 0.3,
                      initialPage: 0,
                      scrollDirection: Axis.horizontal,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DimenConstant.separator,
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: CustomText(
                      text: 'Select an image of your recipe similar to above',
                      visible: steps.isNotEmpty,
                      color: ColorConstant.primary,
                      size: DimenConstant.mini,
                      align: TextAlign.center,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DimenConstant.separator,
                ),
                SliverToBoxAdapter(
                  child: InkWell(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      backgroundColor: ColorConstant.backgroundDark,
                      showDragHandle: true,
                      builder: (context) => PickImageBottomSheet(
                        onCameraPressed: () async {
                          XFile? imageFile = await picker.pickImage(
                            source: ImageSource.camera,
                          );
                          if (imageFile != null) image = File(imageFile.path);
                          buttonVisibility == true;
                          Navigator.pop(context);
                          setState(() {});
                        },
                        onGalleryPressed: () async {
                          XFile? imageFile = await picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (imageFile != null) image = File(imageFile.path);
                          buttonVisibility == true;
                          Navigator.pop(context);
                          setState(() {});
                        },
                        onDeletePressed: () {
                          image = null;
                          Navigator.pop(context);
                          buttonVisibility = false;
                          setState(() {});
                        },
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 75,
                      backgroundImage: image == null
                          ? AssetImage(ImageConstant.pickImage)
                          : FileImage(image!) as ImageProvider,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: buttonVisibility,
                    child: DimenConstant.separator,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding * 10,
                    ),
                    child: CustomButton.text(
                      visible: buttonVisibility,
                      text: 'Save',
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
