import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodies/controller/add_recipe_controller.dart';
import 'package:foodies/generated/assets.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/widgets/pick_image_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RecipeImage extends StatefulWidget {
  RecipeImage({super.key});

  @override
  State<RecipeImage> createState() => _RecipeImageState();
}

class _RecipeImageState extends State<RecipeImage> {
  List<String> examples = [];
  String selectedImage = ImageConstant.food;
  ImagePicker picker = ImagePicker();
  File? image;

  @override
  void initState() {
    selectedImage = Provider.of<AddRecipeController>(context, listen: false)
        .editedRecipe
        .image!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Almost there!',
          style: TextStyle(
            color: ColorConstant.primary,
            fontSize: DimenConstant.small,
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: DimenConstant.padding * 3),
          child: Text(
            StringConstant.addImage,
            style: TextStyle(
              color: ColorConstant.secondary,
              fontSize: DimenConstant.mini,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            examples.length,
            (index) => CircleAvatar(
              radius: (MediaQuery.of(context).size.width - 40) / 6,
              foregroundImage: AssetImage(
                examples[index],
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: InkWell(
              onTap: () => showModalBottomSheet(
                backgroundColor: ColorConstant.background,
                showDragHandle: true,
                context: context,
                builder: (context) => PickImageBottomSheet(
                  onCameraPressed: () async {
                    XFile? pickedImage = await picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (pickedImage != null) image = File(pickedImage.path);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  onGalleryPressed: () async {
                    XFile? pickedImage = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedImage != null) image = File(pickedImage.path);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  onDeletePressed: () {
                    selectedImage = Assets.imagesFood;
                    image = null;
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
              ),
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.35,
                backgroundImage: AssetImage(Assets.imagesFood),
                foregroundImage: image == null
                    ? AssetImage(selectedImage)
                    : FileImage(image!) as ImageProvider<Object>,
              ),
            ),
          ),
        ),
        DimenConstant.separator,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              color: ColorConstant.primary,
              onPressed: () {
                FocusScope.of(context).unfocus();
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
