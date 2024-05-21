import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/cooking_screen/cooking_screen.dart';
import 'package:foodies/view/home_screen/home_screen.dart';
import 'package:foodies/view/profile_view_screen/profile_view_screen.dart';
import 'package:foodies/view/recipe_view_screen/recipe_view_widgets/details_item.dart';
import 'package:foodies/widgets/app_name.dart';
import 'package:foodies/widgets/counter.dart';
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/custom_circle_avatar.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_dialog.dart';
import 'package:foodies/widgets/custom_icon.dart';
import 'package:foodies/widgets/custom_navigator.dart';
import 'package:foodies/widgets/custom_text.dart';
import 'package:foodies/view/recipe_view_screen/recipe_view_widgets/editor_dialog.dart';
import 'package:foodies/widgets/loading.dart';
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
  FirebaseStorage storage = FirebaseStorage.instance;
  RecipeModel recipe = RecipeModel();
  RecipeModel editedRecipe = RecipeModel();
  String? username;
  bool expanded = false, editing = false, loading = false;
  List cuisines = [], categories = [];
  Map<String, dynamic> changes = {};
  ScrollController scrollController = ScrollController();
  ValueNotifier<bool> dietSwitchController = ValueNotifier<bool>(false);
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    getRecipe();
    getCuisine();
    getCategories();
    dietSwitchController = ValueNotifier<bool>(recipe.veg ?? false);
    scrollController.addListener(() {
      expanded = scrollController.hasClients && scrollController.offset > 0;
      setState(() {});
    });
    super.initState();
  }

  // get recipe data from firestore
  getRecipe() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: ColorConstant.backgroundLight,
            surfaceTintColor: Colors.transparent,
            expandedHeight: 360,
            collapsedHeight: kToolbarHeight,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.all(
                DimenConstant.padding * 2 / 3,
              ),
              child: CustomButton.back(
                onPressed: () {
                  if (editing) {
                    if (recipe != editedRecipe) {
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialog(
                          title: 'Editing',
                          content: 'Do you want discard editing?',
                          positiveText: 'Discard',
                          positiveColor: ColorConstant.error,
                          onPositivePressed: () {
                            editing = false;
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                      );
                    } else {
                      editing = false;
                      setState(() {});
                    }
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
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
                        color: ColorConstant.secondaryLight,
                        fontSize: DimenConstant.sText,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              editing && loading
                  ? Loading(size: 18, stroke: 2.5)
                  : CustomButton.icon(
                      visible: recipe.chef == user.uid,
                      background: Colors.transparent,
                      icon:
                          editing ? Icons.done_all_rounded : Icons.edit_rounded,
                      iconColor: editing
                          ? ColorConstant.primary
                          : ColorConstant.secondaryLight,
                      onPressed: () async {
                        if (editing) {
                          if (changes.isNotEmpty) {
                            loading = true;
                            setState(() {});
                            DocumentReference reference =
                                firestore.collection('recipes').doc(widget.id);
                            await reference.update(changes);
                            getRecipe();
                            editing = loading = false;
                            setState(() {});
                          } else {
                            editing = false;
                            setState(() {});
                          }
                        } else {
                          editing = true;
                          setState(() {});
                        }
                      },
                    ),
              Separator(visible: loading),
              CustomButton.icon(
                visible: recipe.chef == user.uid,
                background: Colors.transparent,
                icon: Icons.delete_rounded,
                iconColor: editing
                    ? ColorConstant.error
                    : ColorConstant.secondaryLight,
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    title: 'Delete recipe',
                    content: 'Do you want delete your recipe',
                    positiveText: 'Delete ',
                    positiveColor: ColorConstant.error,
                    onPositivePressed: () async {
                      DocumentReference recipeRef =
                          firestore.collection('recipes').doc(widget.id);
                      Uri uri = Uri.parse(recipe.image ?? '');
                      Reference imageRef = storage.ref().child(uri.path);
                      // await imageRef.delete();
                      await recipeRef.delete();
                      CustomNavigator.pushAndRemoveUntil(
                        context: context,
                        removeUntil: HomeScreen(),
                      );
                    },
                  ),
                ),
              ),
              Separator(),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: ColorConstant.backgroundLight,
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
                      ),
                      Separator(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomText(
                              text: editing
                                  ? editedRecipe.name ?? ''
                                  : recipe.name ?? '',
                              color: ColorConstant.secondaryLight,
                              size: DimenConstant.lText,
                              align: TextAlign.center,
                            ),
                          ),
                          Separator(visible: editing),
                          CustomIcon(
                            icon: Icons.edit_outlined,
                            visible: editing,
                            color: ColorConstant.primary,
                            onPressed: () => EditorDialog.text(
                              context: context,
                              title: 'recipe name',
                              content: editedRecipe.name ?? '',
                              save: (value) {
                                editedRecipe.name = value;
                                if (recipe != editedRecipe) {
                                  changes['name'] = editedRecipe.name;
                                }
                                setState(() {});
                              },
                            ),
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
                                  color: ColorConstant.secondaryLight,
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
                                  color: ColorConstant.secondaryLight,
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
                      editing ? editedRecipe.about ?? '' : recipe.about ?? '',
                      style: TextStyle(
                        color: ColorConstant.secondaryLight,
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
                      onPressed: () => EditorDialog.text(
                        context: context,
                        title: 'description',
                        content: editedRecipe.about ?? '',
                        save: (value) {
                          editedRecipe.about = value;
                          if (recipe != editedRecipe) {
                            changes['about'] = editedRecipe.about;
                          }
                          setState(() {});
                        },
                      ),
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
                    color: ColorConstant.vegPrimary,
                    onPressed: () {
                      editedRecipe.veg = true;
                      changes['veg'] = editedRecipe.veg;
                      setState(() {});
                    },
                    child: editing && (editedRecipe.veg ?? false)
                        ? CustomCircleAvatar(
                            radius: 8,
                            color: ColorConstant.tertiaryLight,
                            child: CustomCircleAvatar(
                              radius: 5,
                              color: ColorConstant.vegPrimary,
                            ),
                          )
                        : null,
                  ),
                  Separator(visible: editing || (recipe.veg ?? false)),
                  CustomCircleAvatar(
                    radius: 10,
                    visible: editing || !(recipe.veg ?? true),
                    color: ColorConstant.nonVegPrimary,
                    onPressed: () {
                      editedRecipe.veg = false;
                      changes['veg'] = editedRecipe.veg;
                      setState(() {});
                    },
                    child: editing && !(editedRecipe.veg ?? true)
                        ? CustomCircleAvatar(
                            radius: 8,
                            color: ColorConstant.tertiaryLight,
                            child: CustomCircleAvatar(
                              radius: 5,
                              color: ColorConstant.nonVegPrimary,
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
                    color: ColorConstant.secondaryLight,
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
                    text: editing
                        ? editedRecipe.cuisine ?? ''
                        : recipe.cuisine ?? '',
                    color: ColorConstant.secondaryLight,
                    size: DimenConstant.sText,
                  ),
                  CustomIcon(
                    icon: Icons.edit_outlined,
                    visible: editing,
                    color: ColorConstant.primary,
                    onPressed: () => EditorDialog.radio(
                      context: context,
                      title: 'cuisine',
                      currentValue: editedRecipe.cuisine ?? '',
                      elements: cuisines,
                      save: (value) {
                        editedRecipe.cuisine = value;
                        if (recipe != editedRecipe) {
                          changes['cuisine'] = editedRecipe.cuisine;
                        }
                        setState(() {});
                      },
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
                      text: editing
                          ? (editedRecipe.categories ?? []).join(', ')
                          : (recipe.categories ?? []).join(', '),
                      color: ColorConstant.secondaryLight,
                      size: DimenConstant.sText,
                      lines: 5,
                    ),
                  ),
                  Separator(),
                  CustomIcon(
                    icon: Icons.edit_outlined,
                    visible: editing,
                    color: ColorConstant.primary,
                    onPressed: () => EditorDialog.checkbox(
                      context: context,
                      title: 'categories',
                      currentValues: editedRecipe.categories ?? [],
                      elements: categories,
                      save: (list) {
                        editedRecipe.categories = list;
                        if (recipe != editedRecipe) {
                          changes['categories'] = editedRecipe.categories;
                        }
                        setState(() {});
                      },
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
                    text: editing ? editedRecipe.time ?? '' : recipe.time ?? '',
                    color: ColorConstant.secondaryLight,
                    size: DimenConstant.sText,
                  ),
                  CustomIcon(
                    icon: Icons.edit_outlined,
                    visible: editing,
                    color: ColorConstant.primary,
                    onPressed: () => EditorDialog.text(
                      context: context,
                      title: 'cooking time',
                      content: editedRecipe.time ?? '',
                      save: (value) {
                        editedRecipe.time = value;
                        if (recipe != editedRecipe) {
                          changes['time'] = editedRecipe.time;
                        }
                        setState(() {});
                      },
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
                      content: editing
                          ? (editedRecipe.ingredients ?? [])[index]
                          : (recipe.ingredients ?? [])[index],
                    ),
                  ),
                  Separator(),
                  CustomIcon(
                    icon: Icons.edit_outlined,
                    visible: editing,
                    color: ColorConstant.primary,
                    size: 20,
                    onPressed: () => EditorDialog.text(
                      context: context,
                      title: 'ingredient',
                      content: (editedRecipe.ingredients ?? [])[index],
                      save: (value) {
                        (editedRecipe.ingredients ?? [])[index] = value;
                        if (recipe != editedRecipe) {
                          changes['ingredients '] = editedRecipe.ingredients;
                        }
                        setState(() {});
                      },
                    ),
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
                      content: editing
                          ? (editedRecipe.steps ?? [])[index]
                          : (recipe.steps ?? [])[index],
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
                      onPressed: () => EditorDialog.text(
                        context: context,
                        title: 'step',
                        content: (editedRecipe.steps ?? [])[index],
                        save: (value) {
                          (editedRecipe.steps ?? [])[index] = value;
                          if (recipe != editedRecipe) {
                            changes['steps'] = editedRecipe.steps;
                          }
                          setState(() {});
                        },
                      ),
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
          color: ColorConstant.tertiaryLight,
        ),
        label: Text(
          'Start Cooking',
          style: TextStyle(
            color: ColorConstant.tertiaryLight,
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
