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
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_icon.dart';
import 'package:foodies/widgets/custom_navigator.dart';
import 'package:foodies/widgets/custom_text.dart';
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
  String username = '';
  bool expanded = false, editing = false;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    getData();
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
                        fontSize: DimenConstant.extraSmall,
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
                              fontSize: DimenConstant.medium,
                            ),
                          ),
                          Separator(visible: editing),
                          CustomIcon(
                            icon: Icons.edit_outlined,
                            visible: editing,
                            color: ColorConstant.primary,
                            onPressed: () {},
                          )
                        ],
                      ),
                      username != StringConstant.appName.toLowerCase()
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppName(
                                  size: DimenConstant.extraSmall,
                                ),
                                CustomText(
                                  text: ' original recipe',
                                  color: ColorConstant.secondaryDark,
                                  size: DimenConstant.extraSmall,
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
                                  size: DimenConstant.extraSmall,
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
                                  size: DimenConstant.extraSmall,
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
              child: Text(
                recipe.about ?? '',
                style: TextStyle(
                  color: ColorConstant.secondaryDark,
                  fontSize: DimenConstant.extraSmall,
                ),
                textAlign: TextAlign.justify,
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
                  CircleAvatar(
                    backgroundColor: recipe.veg ?? true
                        ? ColorConstant.vegSecondary
                        : ColorConstant.nonVegSecondary,
                    radius: 10,
                  ),
                  Separator(),
                  Text(
                    recipe.veg ?? true ? 'Vegetarian' : 'Non-Vegetarian',
                    style: TextStyle(
                      color: ColorConstant.secondaryDark,
                      fontSize: DimenConstant.extraSmall,
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
              child: Text(
                'Cuisine',
                style: TextStyle(
                  color: ColorConstant.primary,
                  fontSize: DimenConstant.small,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimenConstant.padding,
              ),
              child: CustomText(
                text: recipe.cuisine ?? '',
                color: ColorConstant.secondaryDark,
                size: DimenConstant.extraSmall,
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
                  fontSize: DimenConstant.small,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimenConstant.padding,
              ),
              child: CustomText(
                text: (recipe.categories ?? []).join(', '),
                color: ColorConstant.secondaryDark,
                size: DimenConstant.extraSmall,
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
                  fontSize: DimenConstant.small,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimenConstant.padding,
              ),
              child: CustomText(
                text: recipe.time ?? '',
                color: ColorConstant.secondaryDark,
                size: DimenConstant.extraSmall,
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
                  fontSize: DimenConstant.small,
                ),
              ),
            ),
          ),
          SliverList.separated(
            itemBuilder: (context, index) => DetailsItem(
              content: recipe.ingredients?[index] ?? '',
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
                  fontSize: DimenConstant.small,
                ),
              ),
            ),
          ),
          SliverList.separated(
            itemBuilder: (context, index) => DetailsItem(
              content: recipe.steps?[index] ?? '',
            ),
            separatorBuilder: (context, index) => Separator(),
            itemCount: recipe.steps?.length ?? 0,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
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
            fontSize: DimenConstant.mini,
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
