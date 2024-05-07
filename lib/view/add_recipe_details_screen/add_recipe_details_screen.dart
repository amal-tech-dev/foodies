import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/add_recipe_details_screen/add_recipe_details_widgets/page_item.dart';
import 'package:foodies/view/add_recipe_details_screen/add_recipe_details_widgets/slidable_item.dart';
import 'package:foodies/view/home_screen/home_screen.dart';
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_scaffold_messenger.dart';
import 'package:foodies/widgets/custom_text.dart';
import 'package:foodies/widgets/custom_text_field.dart';
import 'package:foodies/widgets/loading.dart';
import 'package:foodies/widgets/pick_image_bottom_sheet.dart';
import 'package:foodies/widgets/separator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddRecipeDetailsScreen extends StatefulWidget {
  AddRecipeDetailsScreen({super.key});

  @override
  State<AddRecipeDetailsScreen> createState() => _AddRecipeDetailsScreenState();
}

class _AddRecipeDetailsScreenState extends State<AddRecipeDetailsScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  User user = FirebaseAuth.instance.currentUser!;
  RecipeModel recipe = RecipeModel();
  PageController pageController = PageController();
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController ingredientController = TextEditingController();
  TextEditingController stepController = TextEditingController();
  bool buttonVisibility = false, editing = false, loading = false;
  List cuisines = [], categories = [], selectedCategories = [];
  String? selectedCuisine, imageUrl;
  List<String> ingredients = [], steps = [], imageUrls = [];
  List<bool> checkValues = [];
  int radioValue = -1, editingIndex = -1;
  File? image;
  ImagePicker picker = ImagePicker();
  ImageCropper cropper = ImageCropper();

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

  // pick image and crop for requirements
  pickAndCropImage(ImageSource source) async {
    XFile? pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      CroppedFile? croppedImage = await cropper.cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop recipe image',
            toolbarColor: ColorConstant.backgroundDark,
            toolbarWidgetColor: ColorConstant.secondaryDark,
            backgroundColor: ColorConstant.tertiaryDark,
            cropFrameColor: ColorConstant.secondaryDark,
            cropFrameStrokeWidth: 3,
            lockAspectRatio: true,
            hideBottomControls: true,
          ),
        ],
      );
      if (croppedImage != null) image = File(croppedImage.path);
    }
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
            fontSize: DimenConstant.mText,
          ),
        ),
        actions: [
          Loading(visible: loading, size: 22, stroke: 3),
          Separator(width: DimenConstant.padding * 2),
        ],
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
                  child: Separator(),
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
                  child: Separator(),
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
              children: [
                SliverToBoxAdapter(
                  child: CustomContainer(
                    height: 100,
                    padding: DimenConstant.padding * 2,
                    gradients: [
                      ColorConstant.vegSecondary,
                      ColorConstant.vegPrimary,
                    ],
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
                          fontSize: DimenConstant.mText,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Separator(),
                ),
                SliverToBoxAdapter(
                  child: CustomContainer(
                    height: 100,
                    paddingTop: DimenConstant.padding * 2,
                    paddingLeft: DimenConstant.padding * 2,
                    paddingRight: DimenConstant.padding * 2,
                    paddingBottom: DimenConstant.padding * 2,
                    gradients: [
                      ColorConstant.nonVegSecondary,
                      ColorConstant.nonVegPrimary,
                    ],
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
                          fontSize: DimenConstant.mText,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            PageItem(
              header: StringConstant.addRecipeTime,
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
                  child: Separator(),
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
              children: [
                SliverToBoxAdapter(
                  child: CustomContainer(
                    height: 250,
                    child: Column(
                      children: [
                        Text(
                          'Cuisines',
                          style: TextStyle(
                            color: ColorConstant.secondaryDark,
                            fontSize: DimenConstant.sText,
                          ),
                        ),
                        Text(
                          selectedCuisine ?? 'Select a Cuisine',
                          style: TextStyle(
                            color: ColorConstant.primary,
                            fontSize: DimenConstant.xsText,
                          ),
                        ),
                        Separator(),
                        Expanded(
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
                                        fontSize: DimenConstant.xsText,
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
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Separator(),
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
              children: [
                SliverToBoxAdapter(
                  child: CustomContainer(
                    height: 250,
                    child: Column(
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(
                            color: ColorConstant.secondaryDark,
                            fontSize: DimenConstant.sText,
                          ),
                        ),
                        Text(
                          selectedCategories.isEmpty
                              ? 'Select atleast one category'
                              : selectedCategories.join(', '),
                          style: TextStyle(
                            color: ColorConstant.primary,
                            fontSize: DimenConstant.xsText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Separator(),
                        Expanded(
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
                                        fontSize: DimenConstant.xsText,
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
                                          selectedCategories.add(categories[i]);
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
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Separator(),
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
              children: [
                SliverToBoxAdapter(
                  child: Center(
                    child: CustomText(
                      visible: ingredients.isNotEmpty,
                      text:
                          'Slide ingredients to edit or delete. Press ingredient to undo edit.',
                      color: ColorConstant.primary,
                      size: DimenConstant.xsText,
                      align: TextAlign.center,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: ingredients.isNotEmpty,
                    child: Separator(),
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
                            Separator(),
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
                                size: DimenConstant.xsText,
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
                  separatorBuilder: (context, index) => Separator(),
                  itemCount: ingredients.length + 1,
                ),
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: buttonVisibility,
                    child: Separator(),
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
              children: [
                SliverToBoxAdapter(
                  child: Center(
                    child: CustomText(
                      visible: steps.isNotEmpty,
                      text:
                          'Slide steps to edit or delete. Press step to undo edit.',
                      color: ColorConstant.primary,
                      size: DimenConstant.xsText,
                      align: TextAlign.center,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: steps.isNotEmpty,
                    child: Separator(),
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
                            Separator(),
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
                                size: DimenConstant.xsText,
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
                  separatorBuilder: (context, index) => Separator(),
                  itemCount: steps.length + 1,
                ),
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: buttonVisibility,
                    child: Separator(),
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
                  child: Separator(),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: CustomText(
                      text: 'Select an image of your recipe similar to above',
                      visible: steps.isNotEmpty,
                      color: ColorConstant.primary,
                      size: DimenConstant.xsText,
                      align: TextAlign.center,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Separator(),
                ),
                SliverToBoxAdapter(
                  child: InkWell(
                    onTap: () => PickImageBottomSheet.showModalSheet(
                      context: context,
                      onCameraPressed: () async {
                        pickAndCropImage(ImageSource.camera);
                        buttonVisibility = true;
                        setState(() {});
                        Navigator.pop(context);
                      },
                      onGalleryPressed: () async {
                        pickAndCropImage(ImageSource.gallery);
                        buttonVisibility = true;
                        setState(() {});
                        Navigator.pop(context);
                      },
                      onRemovePressed: () {
                        image = null;
                        Navigator.pop(context);
                        buttonVisibility = false;
                        setState(() {});
                      },
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
                    child: Separator(),
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
                      onPressed: () => pageController.nextPage(
                        duration: Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.bounceInOut,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            PageItem(
              header: StringConstant.addRecipeSave,
              children: [
                SliverToBoxAdapter(
                  child: CustomContainer(
                    padding: DimenConstant.padding * 1.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                ImageConstant.food,
                              ),
                              foregroundImage:
                                  image != null ? FileImage(image!) : null,
                            ),
                            Separator(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: recipe.name ?? '',
                                  color: ColorConstant.secondaryDark,
                                  size: DimenConstant.sText,
                                ),
                                CustomText(
                                  text: recipe.cuisine ?? '',
                                  color: ColorConstant.primary,
                                  size: DimenConstant.xsText,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Separator(),
                        CustomText(
                          text: recipe.about ?? '',
                          color: ColorConstant.secondaryDark,
                          size: DimenConstant.xsText,
                          align: TextAlign.justify,
                        ),
                        Separator(),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: recipe.veg ?? true
                                  ? ColorConstant.vegPrimary
                                  : ColorConstant.nonVegPrimary,
                            ),
                            Separator(),
                            CustomText(
                              text: 'Vegetarian',
                              color: ColorConstant.secondaryDark,
                              size: DimenConstant.xsText,
                            ),
                          ],
                        ),
                        Separator(),
                        CustomText(
                          text: 'Categories',
                          color: ColorConstant.primary,
                          size: DimenConstant.sText,
                        ),
                        CustomText(
                          text: (recipe.categories ?? []).join(', '),
                          color: ColorConstant.secondaryDark,
                          size: DimenConstant.xsText,
                        ),
                        Separator(),
                        CustomText(
                          text: 'Cooking Time',
                          color: ColorConstant.primary,
                          size: DimenConstant.sText,
                        ),
                        CustomText(
                          text: recipe.time ?? '',
                          color: ColorConstant.secondaryDark,
                          size: DimenConstant.xsText,
                        ),
                        Separator(),
                        CustomText(
                          text: 'Ingredients',
                          color: ColorConstant.primary,
                          size: DimenConstant.sText,
                        ),
                        ...List.generate(
                          recipe.ingredients?.length ?? 0,
                          (index) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: (DimenConstant.xsText / 2) - 2.5,
                                ),
                                child: CircleAvatar(
                                  radius: 5,
                                  backgroundColor: ColorConstant.primary,
                                ),
                              ),
                              Separator(),
                              CustomText(
                                text: recipe.ingredients![index],
                                color: ColorConstant.secondaryDark,
                                size: DimenConstant.xsText,
                              ),
                            ],
                          ),
                        ),
                        Separator(),
                        CustomText(
                          text: 'Steps',
                          color: ColorConstant.primary,
                          size: DimenConstant.sText,
                        ),
                        ...List.generate(
                          recipe.steps?.length ?? 0,
                          (index) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: (DimenConstant.xsText / 2) - 2.5,
                                ),
                                child: CircleAvatar(
                                  radius: 5,
                                  backgroundColor: ColorConstant.primary,
                                ),
                              ),
                              Separator(),
                              CustomText(
                                text: recipe.steps![index],
                                color: ColorConstant.secondaryDark,
                                size: DimenConstant.xsText,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Separator(),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding * 8,
                    ),
                    child: CustomButton.text(
                      visible: !loading,
                      text: 'Save',
                      onPressed: () async {
                        loading = true;
                        setState(() {});
                        recipe.chef = user.uid;
                        recipe.image = await uploadImage(image!);
                        recipe.shared = 0;
                        recipe.views = 0;
                        recipe.likes = [];
                        DocumentReference reference = await firestore
                            .collection('recipes')
                            .add(recipe.toJson());
                        await firestore
                            .collection('users')
                            .doc(user.uid)
                            .update({
                          'recipes': FieldValue.arrayUnion([reference.id])
                        });
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                          (route) => false,
                        );
                      },
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

  // upload image to firebase storage
  Future<String> uploadImage(File image) async {
    String file =
        '${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}';
    Reference reference = storage.ref().child('food_items').child(file);
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
