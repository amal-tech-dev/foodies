import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/cooking_screen/cooking_screen.dart';
import 'package:foodies/view/profile_view_screen/profile_view_screen.dart';
import 'package:foodies/view/recipe_view_screen/recipe_view_widgets/details_item.dart';
import 'package:foodies/widgets/app_name.dart';
import 'package:foodies/widgets/counter.dart';
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/custom_circle_avatar.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_icon.dart';
import 'package:foodies/widgets/custom_navigator.dart';
import 'package:foodies/widgets/custom_text.dart';
import 'package:foodies/widgets/custom_text_field.dart';
import 'package:foodies/widgets/separator.dart';

class RecipeViewScreen extends StatefulWidget {
  String id;
  RecipeViewScreen({
    super.key,
    required this.id,
  });

  @override
  State<RecipeViewScreen> createState() => _RecipeViewScreenState();
}

class _RecipeViewScreenState extends State<RecipeViewScreen> {
  User user = FirebaseAuth.instance.currentUser!;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RecipeModel recipe = RecipeModel();
  RecipeModel editedRecipe = RecipeModel();
  String username = '';
  bool expanded = false, editing = false;
  ScrollController controller = ScrollController();
  ValueNotifier<bool> dietSwitchController = ValueNotifier<bool>(false);

  @override
  void initState() {
    getData();
    dietSwitchController = ValueNotifier<bool>(recipe.veg ?? false);
    controller.addListener(() {
      setState(() {
        expanded = controller.hasClients && controller.offset > 0;
      });
    });
    super.initState();
  }

  // get recipe data from firestore
  getData() async {
    DocumentReference reference =
        firestore.collection('recipes').doc(widget.id);
    DocumentSnapshot snapshot = await reference.get();
    recipe = RecipeModel.fromJson(snapshot.data() as Map<String, dynamic>);
    editedRecipe =
        RecipeModel.fromJson(snapshot.data() as Map<String, dynamic>);
    getChef();
    setState(() {});
  }

  // get profile of chef
  getChef() async {
    DocumentReference reference =
        firestore.collection('users').doc(recipe.chef);
    DocumentSnapshot snapshot = await reference.get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    username = data['username'] ?? '';
    setState(() {});
  }

  // show editing dialog
  String showEditDialog(String? content) {
    String newContent = '';
    TextEditingController controller = TextEditingController(text: content);
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: ColorConstant.backgroundDark,
        child: CustomContainer(
          padding: DimenConstant.padding,
          backgroundColor: ColorConstant.backgroundDark,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: 'Edit',
                color: ColorConstant.primary,
                size: DimenConstant.sText,
              ),
              Separator(),
              CustomContainer(
                paddingVertical: 0,
                child: CustomTextField.singleLine(
                  context: context,
                  hint: 'Edit',
                  controller: controller,
                  limit: 20,
                  onSubmitted: () {},
                ),
              ),
              Separator(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton.text(
                    text: 'Cancel',
                    textColor: ColorConstant.secondaryDark,
                    background: Colors.transparent,
                    onPressed: () => Navigator.pop(context),
                  ),
                  CustomButton.text(
                    text: 'Save',
                    textColor: ColorConstant.primary,
                    background: Colors.transparent,
                    onPressed: () {
                      newContent = controller.text.trim();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return newContent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: controller,
        slivers: [
          SliverAppBar(
            backgroundColor: ColorConstant.backgroundDark,
            surfaceTintColor: Colors.transparent,
            expandedHeight: 360,
            collapsedHeight: kToolbarHeight,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.all(
                DimenConstant.padding * 2 / 3,
              ),
              child: CustomButton.back(),
            ),
            title: AnimatedOpacity(
              opacity: expanded ? 1.0 : 0.0,
              duration: Duration(
                milliseconds: 250,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: recipe.image != null
                        ? NetworkImage(recipe.image!) as ImageProvider<Object>
                        : AssetImage(
                            ImageConstant.food,
                          ),
                  ),
                  Separator(),
                  Expanded(
                    child: Text(
                      recipe.name ?? '',
                      style: TextStyle(
                        color: ColorConstant.secondaryDark,
                        fontSize: DimenConstant.sText,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              CustomButton.icon(
                visible: recipe.chef == user.uid,
                background: Colors.transparent,
                icon: editing ? Icons.done_all_rounded : Icons.edit_rounded,
                iconColor: editing
                    ? ColorConstant.primary
                    : ColorConstant.secondaryDark,
                onPressed: () {
                  if (editing) {
                    editing = false;
                    setState(() {});
                  } else {
                    editing = true;
                    setState(() {});
                  }
                },
              ),
              CustomButton.icon(
                visible: recipe.chef == user.uid,
                background: Colors.transparent,
                icon: Icons.delete_rounded,
                iconColor:
                    editing ? ColorConstant.error : ColorConstant.secondaryDark,
                onPressed: () {},
              ),
              Separator(),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: ColorConstant.backgroundDark,
                padding: EdgeInsets.symmetric(
                  horizontal: DimenConstant.padding,
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: kToolbarHeight,
                      ),
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: recipe.image != null
                            ? NetworkImage(recipe.image!)
                                as ImageProvider<Object>
                            : AssetImage(
                                ImageConstant.food,
                              ),
                        child: editing
                            ? InkWell(
                                onTap: () {},
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: ColorConstant.tertiaryDark
                                        .withOpacity(0.4),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: ColorConstant.secondaryDark,
                                    size: 30,
                                  ),
                                ),
                              )
                            : null,
                      ),
                      Separator(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            recipe.name ?? '',
                            style: TextStyle(
                              color: ColorConstant.secondaryDark,
                              fontSize: DimenConstant.lText,
                            ),
                          ),
                          Separator(visible: editing),
                          CustomIcon(
                            icon: Icons.edit_outlined,
                            visible: editing,
                            color: ColorConstant.primary,
                            onPressed: () {
                              editedRecipe.name =
                                  showEditDialog(editedRecipe.name);
                              setState(() {});
                            },
                          )
                        ],
                      ),
                      username == StringConstant.appName.toLowerCase()
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppName(
                                  size: DimenConstant.sText,
                                ),
                                CustomText(
                                  text: ' original recipe',
                                  color: ColorConstant.secondaryDark,
                                  size: DimenConstant.sText,
                                  font: StringConstant.font,
                                )
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: '@${username}',
                                  color: ColorConstant.primary,
                                  size: DimenConstant.sText,
                                  font: StringConstant.font,
                                  onPressed: () => CustomNavigator.push(
                                    context: context,
                                    push: ProfileViewScreen(
                                      uid: recipe.chef ?? '',
                                    ),
                                  ),
                                ),
                                CustomText(
                                  text: ' recipe',
                                  color: ColorConstant.secondaryDark,
                                  size: DimenConstant.sText,
                                  font: StringConstant.font,
                                ),
                              ],
                            ),
                      Separator(),
                      Row(
                        children: [
                          Expanded(
                            child: CustomContainer(
                              child: Counter(
                                count: recipe.likes?.length ?? 0,
                                header: 'Likes',
                              ),
                            ),
                          ),
                          Separator(),
                          Expanded(
                            child: CustomContainer(
                              child: Counter(
                                count: recipe.views ?? 0,
                                header: 'Views',
                              ),
                            ),
                          ),
                          Separator(),
                          Expanded(
                            child: CustomContainer(
                              child: Counter(
                                count: recipe.shared ?? 0,
                                header: 'Shared',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimenConstant.padding,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      recipe.about ?? '',
                      style: TextStyle(
                        color: ColorConstant.secondaryDark,
                        fontSize: DimenConstant.sText,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Separator(visible: editing),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: DimenConstant.padding,
                    ),
                    child: CustomIcon(
                      icon: Icons.edit_outlined,
                      visible: editing,
                      color: ColorConstant.primary,
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
                horizontal: DimenConstant.padding,
              ),
              child: Row(
                children: [
                  CustomCircleAvatar(
                    radius: 10,
                    visible: editing || (recipe.veg ?? false),
                    color: ColorConstant.vegSecondary,
                    onPressed: () {
                      editedRecipe.veg = true;
                      setState(() {});
                    },
                    child: editing && (editedRecipe.veg ?? false)
                        ? Center(
                            child: CustomIcon(
                              icon: Icons.done_rounded,
                              size: 15,
                            ),
                          )
                        : null,
                  ),
                  Separator(visible: editing || (recipe.veg ?? false)),
                  CustomCircleAvatar(
                    radius: 10,
                    visible: editing || !(recipe.veg ?? true),
                    color: ColorConstant.nonVegSecondary,
                    onPressed: () {
                      editedRecipe.veg = false;
                      setState(() {});
                    },
                    child: editing && !(editedRecipe.veg ?? true)
                        ? Center(
                            child: CustomIcon(
                              icon: Icons.done_rounded,
                              size: 15,
                            ),
                          )
                        : null,
                  ),
                  Separator(visible: editing || !(recipe.veg ?? true)),
                  CustomText(
                    text: editing
                        ? editedRecipe.veg ?? true
                            ? 'Vegetarian'
                            : 'Non-Vegetarian'
                        : recipe.veg ?? true
                            ? 'Vegetarian'
                            : 'Non-Vegetarian',
                    color: ColorConstant.secondaryDark,
                    size: DimenConstant.sText,
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
                horizontal: DimenConstant.padding,
              ),
              child: Text(
                'Cuisine',
                style: TextStyle(
                  color: ColorConstant.primary,
                  fontSize: DimenConstant.mText,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimenConstant.padding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: recipe.cuisine ?? '',
                    color: ColorConstant.secondaryDark,
                    size: DimenConstant.sText,
                  ),
                  CustomIcon(
                    icon: Icons.edit_outlined,
                    visible: editing,
                    color: ColorConstant.primary,
                    onPressed: () {},
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
                horizontal: DimenConstant.padding,
              ),
              child: Text(
                'Categories',
                style: TextStyle(
                  color: ColorConstant.primary,
                  fontSize: DimenConstant.mText,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimenConstant.padding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomText(
                      text: (recipe.categories ?? []).join(', '),
                      color: ColorConstant.secondaryDark,
                      size: DimenConstant.sText,
                    ),
                  ),
                  Separator(),
                  CustomIcon(
                    icon: Icons.edit_outlined,
                    visible: editing,
                    color: ColorConstant.primary,
                    onPressed: () {},
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
                horizontal: DimenConstant.padding,
              ),
              child: Text(
                'Cooking Time',
                style: TextStyle(
                  color: ColorConstant.primary,
                  fontSize: DimenConstant.mText,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimenConstant.padding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: recipe.time ?? '',
                    color: ColorConstant.secondaryDark,
                    size: DimenConstant.sText,
                  ),
                  CustomIcon(
                    icon: Icons.edit_outlined,
                    visible: editing,
                    color: ColorConstant.primary,
                    onPressed: () {},
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
                horizontal: DimenConstant.padding,
              ),
              child: Text(
                'Ingredients',
                style: TextStyle(
                  color: ColorConstant.primary,
                  fontSize: DimenConstant.mText,
                ),
              ),
            ),
          ),
          SliverList.separated(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimenConstant.padding,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: DetailsItem(
                      content: recipe.ingredients?[index] ?? '',
                    ),
                  ),
                  Separator(),
                  CustomIcon(
                    icon: Icons.edit_outlined,
                    visible: editing,
                    color: ColorConstant.primary,
                    size: 20,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, index) => Separator(),
            itemCount: recipe.ingredients?.length ?? 0,
          ),
          SliverToBoxAdapter(
            child: Separator(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimenConstant.padding,
              ),
              child: Text(
                'Steps',
                style: TextStyle(
                  color: ColorConstant.primary,
                  fontSize: DimenConstant.mText,
                ),
              ),
            ),
          ),
          SliverList.separated(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimenConstant.padding,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DetailsItem(
                      content: recipe.steps?[index] ?? '',
                    ),
                  ),
                  Separator(),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: DimenConstant.padding,
                    ),
                    child: CustomIcon(
                      icon: Icons.edit_outlined,
                      visible: editing,
                      color: ColorConstant.primary,
                      size: 20,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, index) => Separator(),
            itemCount: recipe.steps?.length ?? 0,
          ),
          SliverToBoxAdapter(
            child: Separator(
              height: 100,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorConstant.primary,
        isExtended: !expanded,
        extendedIconLabelSpacing: DimenConstant.padding,
        extendedPadding: EdgeInsets.symmetric(
          horizontal: DimenConstant.padding * 1.6,
        ),
        icon: Icon(
          Icons.fastfood_rounded,
          color: ColorConstant.tertiaryDark,
        ),
        label: Text(
          'Start Cooking',
          style: TextStyle(
            color: ColorConstant.tertiaryDark,
            fontSize: DimenConstant.xsText,
          ),
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CookingScreen(
              recipe: recipe,
            ),
          ),
        ),
      ),
    );
  }
}
