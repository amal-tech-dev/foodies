import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/controller/add_recipe_controller.dart';
import 'package:foodies/controller/text_input_format_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:provider/provider.dart';

class RecipeSteps extends StatefulWidget {
  RecipeSteps({super.key});

  @override
  State<RecipeSteps> createState() => _RecipeStepsState();
}

class _RecipeStepsState extends State<RecipeSteps> {
  List<String> steps = [];
  TextEditingController stepsController = TextEditingController();

  @override
  void initState() {
    steps = Provider.of<AddRecipeController>(context, listen: false)
        .editedRecipe
        .steps;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Steps',
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.smallText,
          ),
        ),
        Text(
          StringConstant.addSteps,
          style: TextStyle(
            color: ColorConstant.secondaryColor,
            fontSize: DimenConstant.miniText,
          ),
          textAlign: TextAlign.center,
        ),
        DimenConstant.separator,
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: DimenConstant.extraSmallText / 2,
                  ),
                  child: CircleAvatar(
                    backgroundColor: ColorConstant.secondaryColor,
                    radius: 5,
                  ),
                ),
                DimenConstant.separator,
                Expanded(
                  child: Text(
                    steps[index],
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.extraSmallText,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            itemCount: steps.length,
          ),
        ),
        DimenConstant.separator,
        TextField(
          controller: stepsController,
          decoration: InputDecoration(
            label: Text(
              'Add Steps',
              style: TextStyle(
                color: ColorConstant.secondaryColor,
                fontSize: DimenConstant.miniText,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: DimenConstant.edgePadding,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(500),
              borderSide: BorderSide(
                color: ColorConstant.primaryColor,
                width: DimenConstant.borderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(500),
              borderSide: BorderSide(
                color: ColorConstant.secondaryColor,
                width: DimenConstant.borderWidth,
              ),
            ),
            suffix: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                if (stepsController.text.isNotEmpty)
                  steps.add(stepsController.text.trim());
                stepsController.clear();
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimenConstant.edgePadding,
                ),
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.miniText,
                  ),
                ),
              ),
            ),
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
              color: ColorConstant.primaryColor,
              onPressed: () =>
                  Provider.of<AddRecipeController>(context, listen: false)
                      .carouselSliderController
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
              onPressed: () =>
                  Provider.of<AddRecipeController>(context, listen: false)
                      .carouselSliderController
                      .nextPage(),
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
    );
  }
}
