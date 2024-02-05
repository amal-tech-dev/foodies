import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/cooking_screen/cooking_widgets/pantry_item.dart';

class CheckPantry extends StatefulWidget {
  List ingredients;
  VoidCallback onPressed;
  CheckPantry({
    super.key,
    required this.ingredients,
    required this.onPressed,
  });

  @override
  _CheckPantryState createState() => _CheckPantryState();
}

class _CheckPantryState extends State<CheckPantry> {
  ScrollController scrollController = ScrollController();
  int checkingIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        DimenConstant.edgePadding,
      ),
      child: Column(
        children: [
          Text(
            StringConstant.cookingPantry,
            style: TextStyle(
              color: ColorConstant.secondaryColor,
              fontSize: DimenConstant.smallText,
            ),
            textAlign: TextAlign.center,
          ),
          DimenConstant.separator,
          Expanded(
            child: ListView.separated(
              controller: scrollController,
              itemBuilder: (context, index) => PantryItem(
                item: widget.ingredients[index],
                isChecking: checkingIndex == index ? true : false,
                isChecked: checkingIndex > index ? true : false,
              ),
              separatorBuilder: (context, index) => DimenConstant.separator,
              itemCount: widget.ingredients.length,
            ),
          ),
          DimenConstant.separator,
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                ColorConstant.secondaryColor,
              ),
            ),
            onPressed: checkingIndex < 0
                ? () {
                    checkingIndex++;
                    setState(() {});
                  }
                : checkingIndex > widget.ingredients.length - 1
                    ? widget.onPressed
                    : () {
                        scrollController.animateTo(
                          checkingIndex.toDouble() * 20,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                        checkingIndex++;
                        setState(() {});
                      },
            child: Text(
              checkingIndex == -1
                  ? 'Start'
                  : checkingIndex == widget.ingredients.length
                      ? 'Heat up the kitchen'
                      : 'Next',
              style: TextStyle(
                color: ColorConstant.tertiaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
