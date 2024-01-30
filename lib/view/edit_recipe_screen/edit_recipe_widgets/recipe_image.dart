import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodies/controller/add_recipe_controller.dart';
import 'package:foodies/generated/assets.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/edit_recipe_screen/edit_recipe_widgets/pick_image_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RecipeImage extends StatefulWidget {
  RecipeImage({super.key});

  @override
  State<RecipeImage> createState() => _RecipeImageState();
}

class _RecipeImageState extends State<RecipeImage> {
  final List examples = [
    Assets.foodImagesPrawnYellowRice,
    Assets.foodImagesBbqChicken,
    Assets.foodImagesPrawnSalad,
  ];
  String selectedImage = Assets.imagesPickImage;
  ImagePicker picker = ImagePicker();
  File? image;

  @override
  void initState() {
    selectedImage = Provider.of<AddRecipeController>(context, listen: false)
        .editedRecipe
        .image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Almost there!',
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.smallText,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: DimenConstant.edgePadding * 3),
          child: Text(
            StringConstant.addImage,
            style: TextStyle(
              color: ColorConstant.secondaryColor,
              fontSize: DimenConstant.miniText,
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
              splashColor: Colors.transparent,
              onTap: () => showModalBottomSheet(
                backgroundColor: ColorConstant.backgroundColor,
                showDragHandle: true,
                context: context,
                builder: (context) => PickImageBottomSheet(
                  onCameraPressed: () async {
                    final pickedImage = await picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (pickedImage != null) image = File(pickedImage.path);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  onGalleryPressed: () async {
                    final pickedImage = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedImage != null) image = File(pickedImage.path);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  onDeletePressed: () {
                    selectedImage = Assets.imagesPickImage;
                    image = null;
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
              ),
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.35,
                backgroundImage: AssetImage(Assets.imagesPickImage),
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
              color: ColorConstant.primaryColor,
              onPressed: () {
                FocusScope.of(context).unfocus();
                Provider.of<AddRecipeController>(context, listen: false)
                    .carouselSliderController
                    .previousPage();
              },
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
                    .carouselSliderController
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
    );
  }
}
