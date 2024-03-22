import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
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
  RecipeModel recipe = RecipeModel();
  PageController pageController = PageController();
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorConstant.background,
        surfaceTintColor: Colors.transparent,
        leading: CustomButton.back(),
        title: Text(
          'Add Recipe',
          style: TextStyle(
            color: ColorConstant.primary,
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
              children: [
                CustomContainer(
                  child: CustomTextField.singleLine(
                    context: context,
                    label: 'Recipe Name',
                    controller: nameController,
                    limit: 20,
                  ),
                ),
                DimenConstant.separator,
                CustomButton.text(
                  text: 'Next',
                  onPressed: () {
                    recipe.name = nameController.text.trim();
                    setState(() {});
                    pageController.nextPage(
                      duration: Duration(
                        milliseconds: 500,
                      ),
                      curve: Curves.bounceInOut,
                    );
                  },
                ),
              ],
            ),
            PageItem(
              header: StringConstant.addRecipeAbout,
              children: [
                CustomContainer(
                  child: CustomTextField.multiLine(
                    context: context,
                    label: 'About',
                    controller: aboutController,
                    lines: 5,
                    limit: 100,
                  ),
                ),
                DimenConstant.separator,
                CustomButton.text(
                  text: 'Next',
                  onPressed: () {
                    recipe.about = aboutController.text.trim();
                    setState(() {});
                    pageController.nextPage(
                      duration: Duration(
                        milliseconds: 500,
                      ),
                      curve: Curves.bounceInOut,
                    );
                  },
                ),
              ],
            ),
            PageItem(
              header: StringConstant.addRecipeDiet,
              children: [
                CustomContainer(
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
                  child: Center(
                    child: Text(
                      'Vegetarian',
                      style: TextStyle(
                        color: ColorConstant.primary,
                        fontSize: DimenConstant.small,
                      ),
                    ),
                  ),
                ),
                DimenConstant.separator,
                CustomContainer(
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
                  child: Center(
                    child: Text(
                      'Non-Vegetarian',
                      style: TextStyle(
                        color: ColorConstant.primary,
                        fontSize: DimenConstant.small,
                      ),
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
