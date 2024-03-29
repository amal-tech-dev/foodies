import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/add_recipe_details_screen/add_recipe_details_widgets/page_item.dart';
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_text_field.dart';

class AddRecipeDetailsScreen extends StatefulWidget {
  AddRecipeDetailsScreen({super.key});

  @override
  State<AddRecipeDetailsScreen> createState() => _AddRecipeDetailsScreenState();
}

class _AddRecipeDetailsScreenState extends State<AddRecipeDetailsScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RecipeModel recipe = RecipeModel();
  PageController pageController = PageController();
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController ingredientController = TextEditingController();
  TextEditingController stepController = TextEditingController();
  ScrollController cuisineScrollController = ScrollController();
  ScrollController categoriesScrollController = ScrollController();
  bool buttonVisibility = false;
  List cuisines = [], categories = [], selectedCategories = [];
  String? selectedCuisine;
  List<String> ingredients = [], steps = [];
  int radioValue = -1;

  @override
  void initState() {
    getCuisine();
    getCategories();
    nameController.addListener(
      () => updateButtonVisibility(nameController),
    );
    aboutController.addListener(
      () => updateButtonVisibility(aboutController),
    );
    timeController.addListener(
      () => updateButtonVisibility(timeController),
    );
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
    setState(() {});
  }

  // update button visibility
  updateButtonVisibility(TextEditingController controller) {
    buttonVisibility = controller.text.isNotEmpty;
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
            color: ColorConstant.primaryDark,
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
          scrollDirection: Axis.vertical,
          children: [
            PageItem(
              header: StringConstant.addRecipeName,
              image: ImageConstant.chef,
              children: [
                SliverToBoxAdapter(
                  child: CustomContainer(
                    child: CustomTextField.singleLine(
                      context: context,
                      label: 'Recipe Name',
                      controller: nameController,
                      limit: 20,
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
                      label: 'About',
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
                    width: double.infinity,
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
                          color: ColorConstant.primaryDark,
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
                    width: double.infinity,
                    paddingTop: DimenConstant.padding * 2,
                    paddingLeft: DimenConstant.padding * 2,
                    paddingRight: DimenConstant.padding * 2,
                    paddingBottom: DimenConstant.padding * 2,
                    gradient: LinearGradient(
                      colors: [
                        ColorConstant.nonvegPrimary,
                        ColorConstant.nonvegSecondary,
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
                          color: ColorConstant.primaryDark,
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
                    child: CustomTextField.singleLine(
                      context: context,
                      label: 'Cooking Time',
                      controller: timeController,
                      limit: 20,
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
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        surfaceTintColor: Colors.transparent,
                        child: SizedBox(
                          height: 500,
                          child: CustomContainer(
                            paddingLeft: DimenConstant.padding * 2,
                            border: true,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    controller: cuisineScrollController,
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        selectedCuisine = cuisines[index];
                                        radioValue = index;
                                        buttonVisibility = true;
                                        setState(() {});
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              cuisines[index],
                                              style: TextStyle(
                                                color:
                                                    ColorConstant.primaryDark,
                                                fontSize:
                                                    DimenConstant.extraSmall,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Radio(
                                            value: index,
                                            groupValue: radioValue,
                                            activeColor:
                                                ColorConstant.secondaryDark,
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
                                CustomButton.text(
                                  text: 'Done',
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedCuisine ?? 'Cuisines',
                          style: TextStyle(
                            color: ColorConstant.primaryDark,
                            fontSize: DimenConstant.extraSmall,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          color: ColorConstant.secondaryDark,
                          size: 35,
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
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        surfaceTintColor: Colors.transparent,
                        child: SizedBox(
                          height: 500,
                          child: CustomContainer(
                            paddingLeft: DimenConstant.padding * 2,
                            border: true,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        selectedCategories
                                                .contains(categories[index])
                                            ? selectedCategories
                                                .remove(categories[index])
                                            : selectedCategories
                                                .add(categories[index]);
                                        buttonVisibility =
                                            selectedCategories.isEmpty
                                                ? false
                                                : true;
                                        setState(() {});
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            categories[index],
                                            style: TextStyle(
                                              color: ColorConstant.primaryDark,
                                              fontSize:
                                                  DimenConstant.extraSmall,
                                            ),
                                          ),
                                          Checkbox(
                                            value: selectedCategories
                                                .contains(categories[index]),
                                            activeColor:
                                                ColorConstant.secondaryDark,
                                            checkColor:
                                                ColorConstant.tertiaryDark,
                                            onChanged: (value) {
                                              value ?? false
                                                  ? selectedCategories
                                                      .add(categories[index])
                                                  : selectedCategories.remove(
                                                      categories[index]);
                                              buttonVisibility =
                                                  selectedCategories.isEmpty
                                                      ? false
                                                      : true;
                                              setState(() {});
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    itemCount: categories.length,
                                  ),
                                ),
                                CustomButton.text(
                                  text: 'Done',
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Categories',
                              style: TextStyle(
                                color: ColorConstant.primaryDark,
                                fontSize: DimenConstant.extraSmall,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down_rounded,
                              color: ColorConstant.secondaryDark,
                              size: 35,
                            ),
                          ],
                        ),
                        Visibility(
                          visible: selectedCategories.isNotEmpty,
                          child: Text(
                            selectedCategories.join(' | '),
                            style: TextStyle(
                              color: ColorConstant.secondaryDark,
                              fontSize: DimenConstant.mini,
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
            // PageItem(
            //   header: StringConstant.addRecipeIngredients,
            //   image: ImageConstant.chef,
            //   children: [
            //     SliverList.separated(
            //       itemBuilder: (context, index) => SlidableItem(
            //         item: ingredients[index],
            //         editing: false,
            //         onItemPressed: () {},
            //         onEditPressed: () {},
            //         onDeletePressed: () {},
            //       ),
            //       separatorBuilder: (context, index) => DimenConstant.separator,
            //       itemCount: ingredients.length,
            //     ),
            //     SliverToBoxAdapter(
            //       child: DimenConstant.separator,
            //     ),
            //     SliverToBoxAdapter(
            //       child: CustomContainer(
            //         child: Row(
            //           children: [
            //             Expanded(
            //               child: CustomTextField.singleLine(
            //                 context: context,
            //                 label: 'Add Ingredient',
            //                 controller: ingredientController,
            //                 limit: 20,
            //               ),
            //             ),
            //             DimenConstant.separator,
            //             CustomButton.icon(
            //               visible: ingredientController.text.isNotEmpty,
            //               icon: Icons.add_rounded,
            //               iconColor: ColorConstant.secondary,
            //               background: Colors.transparent,
            //               onPressed: () {},
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //     SliverToBoxAdapter(
            //       child: DimenConstant.separator,
            //     ),
            //     SliverToBoxAdapter(
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(
            //           horizontal: DimenConstant.padding * 10,
            //         ),
            //         child: CustomButton.text(
            //           visible: !buttonVisibility,
            //           text: 'Next',
            //           onPressed: () {
            //             recipe.categories = [...selectedCategories];
            //             buttonVisibility = false;
            //             setState(() {});
            //             pageController.nextPage(
            //               duration: Duration(
            //                 milliseconds: 500,
            //               ),
            //               curve: Curves.bounceInOut,
            //             );
            //           },
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
