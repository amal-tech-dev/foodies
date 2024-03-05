import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodies/controller/add_recipe_controller.dart';
import 'package:foodies/controller/text_input_format_controller.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/add_recipe_details_screen/add_recipe_details_widgets/dismissible_list_item.dart';
import 'package:provider/provider.dart';

class RecipeSteps extends StatefulWidget {
  RecipeSteps({super.key});

  @override
  State<RecipeSteps> createState() => _RecipeStepsState();
}

class _RecipeStepsState extends State<RecipeSteps> {
  List<String> steps = [];
  bool editing = false;
  int editingIndex = -1;
  TextEditingController stepsController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    steps = Provider.of<AddRecipeController>(context, listen: false)
        .editedRecipe
        .steps!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Steps',
          style: TextStyle(
            color: ColorConstant.primary,
            fontSize: DimenConstant.small,
          ),
        ),
        Text(
          StringConstant.addSteps,
          style: TextStyle(
            color: ColorConstant.secondary,
            fontSize: DimenConstant.mini,
          ),
          textAlign: TextAlign.center,
        ),
        DimenConstant.separator,
        Expanded(
          child: SlidableAutoCloseBehavior(
            child: ListView.separated(
              itemBuilder: (context, index) => DismissibleListItem(
                item: steps[index],
                editing: editingIndex == index ? true : false,
                onItemPressed: () {
                  if (editingIndex == index) {
                    editing = false;
                    editingIndex = -1;
                    stepsController.clear();
                  }
                  setState(() {});
                },
                onEditPressed: () {
                  editing = true;
                  editingIndex = index;
                  stepsController = TextEditingController(
                    text: steps[index],
                  );
                  FocusScope.of(context).requestFocus(focusNode);
                  setState(() {});
                },
                onDeletePressed: () {
                  steps.removeAt(index);
                  setState(() {});
                },
              ),
              separatorBuilder: (context, index) => DimenConstant.separator,
              itemCount: steps.length,
            ),
          ),
        ),
        DimenConstant.separator,
        TextField(
          focusNode: focusNode,
          controller: stepsController,
          decoration: InputDecoration(
            label: Text(
              'Add Steps',
              style: TextStyle(
                color: ColorConstant.secondary,
                fontSize: DimenConstant.mini,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: DimenConstant.padding,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
              borderSide: BorderSide(
                color: ColorConstant.primary,
                width: DimenConstant.borderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
              borderSide: BorderSide(
                color: ColorConstant.secondary,
                width: DimenConstant.borderWidth,
              ),
            ),
            suffix: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                if (stepsController.text.isNotEmpty) {
                  if (editing) {
                    steps.removeAt(editingIndex);
                    steps.insert(
                      editingIndex,
                      stepsController.text.trim(),
                    );
                    editing = false;
                    editingIndex = -1;
                  } else {
                    steps.add(stepsController.text.trim());
                  }
                }
                stepsController.clear();
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimenConstant.padding,
                ),
                child: Text(
                  editing ? 'Update' : 'Add',
                  style: TextStyle(
                    color: ColorConstant.secondary,
                    fontSize: DimenConstant.mini,
                  ),
                ),
              ),
            ),
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
            LengthLimitingTextInputFormatter(100),
            TextInputFormatController(),
          ],
          textCapitalization: TextCapitalization.sentences,
          onSubmitted: (value) {
            if (stepsController.text.isNotEmpty)
              steps.add(stepsController.text.trim());
            stepsController.clear();
            setState(() {});
          },
        ),
        DimenConstant.separator,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              color: ColorConstant.primary,
              onPressed: () {
                FocusScope.of(context).unfocus();
                Provider.of<AddRecipeController>(context, listen: false).update(
                  recipe: RecipeModel(
                    name:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .name,
                    cuisine:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .cuisine,
                    description:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .description,
                    time:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .time,
                    image:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .image,
                    chef:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .chef,
                    veg:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .veg,
                    categories:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .categories,
                    ingredients:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .ingredients,
                    steps: steps,
                  ),
                );
                Provider.of<AddRecipeController>(context, listen: false)
                    .pageViewController
                    .previousPage();
              },
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
                Provider.of<AddRecipeController>(context, listen: false).update(
                  recipe: RecipeModel(
                    name:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .name,
                    cuisine:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .cuisine,
                    description:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .description,
                    time:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .time,
                    image:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .image,
                    chef:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .chef,
                    veg:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .veg,
                    categories:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .categories,
                    ingredients:
                        Provider.of<AddRecipeController>(context, listen: false)
                            .editedRecipe
                            .ingredients,
                    steps: steps,
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
    );
  }
}
