import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';

class RecipeImageTile extends StatefulWidget {
  String id;
  RecipeImageTile({
    super.key,
    required this.id,
  });

  @override
  State<RecipeImageTile> createState() => _RecipeImageTileState();
}

class _RecipeImageTileState extends State<RecipeImageTile> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? name, image;

  @override
  void initState() {
    getRecipe();
    super.initState();
  }

  // get recipe from firebase
  getRecipe() async {
    DocumentReference reference =
        firestore.collection('recipes').doc(widget.id);
    DocumentSnapshot snapshot = await reference.get();
    Map<String, dynamic> recipe = snapshot.data() as Map<String, dynamic>;
    name = recipe['name'];
    image = recipe['image'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: MediaQuery.of(context).size.width / 6,
          backgroundImage: AssetImage(
            ImageConstant.food,
          ),
          foregroundImage: image == null
              ? AssetImage(
                  ImageConstant.food,
                )
              : NetworkImage(
                  image!,
                ) as ImageProvider<Object>,
        ),
        DimenConstant.separator,
        Text(
          name ?? '',
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.extraSmallText,
          ),
        ),
      ],
    );
  }
}
