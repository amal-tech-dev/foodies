import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/user_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/edit_user_details_screen/edit_user_details_screen.dart';
import 'package:foodies/view/login_screen/login_screen.dart';
import 'package:foodies/view/profile_screen/profile_widgets/recipe_image_tile.dart';

class UserProfileScreen extends StatefulWidget {
  String uid;
  UserProfileScreen({
    super.key,
    required this.uid,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserModel userModel = UserModel();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool myProfile = false;
  num followers = 0, following = 0;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  // get data for specific uid
  getUserData() async {
    DocumentReference reference = firestore.collection('users').doc(widget.uid);
    DocumentSnapshot snapshot = await reference.get();
    userModel = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    if (auth.currentUser!.uid == widget.uid) myProfile = true;
    followers = userModel.followers!.length;
    following = userModel.following!.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.71875,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.5625,
                padding: EdgeInsets.symmetric(
                  horizontal: DimenConstant.padding / 2,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      DimenConstant.borderRadius * 4,
                    ),
                    bottomRight: Radius.circular(
                      DimenConstant.borderRadius * 4,
                    ),
                  ),
                  image: DecorationImage(
                    image: userModel.cover != null
                        ? NetworkImage(
                            userModel.cover!,
                          ) as ImageProvider<Object>
                        : AssetImage(
                            ImageConstant.cover,
                          ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButton(
                        color: ColorConstant.primaryColor,
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            ColorConstant.tertiaryColor.withOpacity(0.1),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: myProfile,
                        child: IconButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              ColorConstant.tertiaryColor.withOpacity(0.1),
                            ),
                          ),
                          onPressed: () => showMenu(
                            color: ColorConstant.backgroundColor,
                            context: context,
                            position: RelativeRect.fromLTRB(
                              100,
                              90,
                              0,
                              0,
                            ),
                            items: [
                              PopupMenuItem(
                                height: 40,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditUserDetailsScreen(),
                                  ),
                                ),
                                child: Text(
                                  'Edit Account',
                                  style: TextStyle(
                                    color: ColorConstant.primaryColor,
                                    fontSize: DimenConstant.extraSmallText,
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                height: 40,
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor:
                                        ColorConstant.backgroundColor,
                                    surfaceTintColor: Colors.transparent,
                                    title: Text(
                                      'Delete account',
                                      style: TextStyle(
                                        color: ColorConstant.primaryColor,
                                        fontSize: DimenConstant.smallText,
                                      ),
                                    ),
                                    content: Text(
                                      StringConstant.deleteAccount,
                                      style: TextStyle(
                                        color: ColorConstant.secondaryColor,
                                        fontSize: DimenConstant.miniText,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    actions: [
                                      InkWell(
                                        onTap: () => Navigator.pop(context),
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: ColorConstant.primaryColor,
                                            fontSize: DimenConstant.miniText,
                                          ),
                                        ),
                                      ),
                                      DimenConstant.separator,
                                      InkWell(
                                        onTap: () async {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen(),
                                            ),
                                            (route) => false,
                                          );
                                          DocumentReference reference =
                                              firestore
                                                  .collection('users')
                                                  .doc(auth.currentUser!.uid);
                                          await reference.delete();
                                          await auth.currentUser!.delete();
                                          await auth.signOut();
                                        },
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: ColorConstant.errorColor,
                                            fontSize: DimenConstant.miniText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                child: Text(
                                  'Delete Account',
                                  style: TextStyle(
                                    color: ColorConstant.errorColor,
                                    fontSize: DimenConstant.extraSmallText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          icon: Icon(
                            Icons.more_vert_rounded,
                            color: ColorConstant.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: DimenConstant.padding,
                right: DimenConstant.padding,
                bottom: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        StreamBuilder(
                          stream: firestore
                              .collection('users')
                              .doc(widget.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              List list = data['followers'];
                              followers = list.length as num;
                            }
                            return AnimatedFlipCounter(
                              value: followers,
                              textStyle: TextStyle(
                                color: ColorConstant.primaryColor,
                                fontSize: DimenConstant.extraSmallText,
                              ),
                            );
                          },
                        ),
                        Text(
                          'Followers',
                          style: TextStyle(
                            color: ColorConstant.primaryColor,
                            fontSize: DimenConstant.miniText,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.15625,
                      backgroundColor: ColorConstant.backgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(3.5),
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.15625,
                          backgroundImage: userModel.profile != null
                              ? NetworkImage(
                                  userModel.profile!,
                                ) as ImageProvider<Object>
                              : AssetImage(
                                  ImageConstant.profile,
                                ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        StreamBuilder(
                          stream: firestore
                              .collection('users')
                              .doc(widget.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              List list = data['following'];
                              following = list.length as num;
                            }
                            return AnimatedFlipCounter(
                              value: following,
                              textStyle: TextStyle(
                                color: ColorConstant.primaryColor,
                                fontSize: DimenConstant.extraSmallText,
                              ),
                            );
                          },
                        ),
                        Text(
                          'Following',
                          style: TextStyle(
                            color: ColorConstant.primaryColor,
                            fontSize: DimenConstant.miniText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          DimenConstant.separator,
          Center(
            child: Text(
              userModel.name ?? '',
              style: TextStyle(
                color: ColorConstant.primaryColor,
                fontSize: DimenConstant.largeText,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '@${userModel.username ?? ''}',
                style: TextStyle(
                  color: ColorConstant.secondaryColor,
                  fontSize: DimenConstant.smallText,
                ),
              ),
              DimenConstant.separator,
              Visibility(
                visible: userModel.verified ?? false,
                child: Icon(
                  Icons.verified_rounded,
                  color: ColorConstant.secondaryColor,
                ),
              ),
            ],
          ),
          Visibility(
            visible: !myProfile,
            child: Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    ColorConstant.secondaryColor,
                  ),
                ),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimenConstant.padding * 2,
                  ),
                  child: Text(
                    'Follow',
                    style: TextStyle(
                      color: ColorConstant.tertiaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DimenConstant.padding,
            ),
            child: Text(
              'Bio',
              style: TextStyle(
                color: ColorConstant.secondaryColor,
                fontSize: DimenConstant.extraSmallText,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          DimenConstant.separator,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DimenConstant.padding,
            ),
            child: Text(
              userModel.bio ?? '',
              style: TextStyle(
                color: ColorConstant.primaryColor,
                fontSize: DimenConstant.extraSmallText,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          DimenConstant.separator,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DimenConstant.padding,
            ),
            child: Text(
              'Recipes',
              style: TextStyle(
                color: ColorConstant.secondaryColor,
                fontSize: DimenConstant.extraSmallText,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          DimenConstant.separator,
          (userModel.recipes ?? []).isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimenConstant.padding,
                  ),
                  child: Text(
                    'No recipes yet.',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.extraSmallText,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: DimenConstant.padding,
                      right: DimenConstant.padding,
                      bottom: DimenConstant.padding,
                    ),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: DimenConstant.padding,
                        mainAxisSpacing: DimenConstant.padding,
                      ),
                      itemBuilder: (context, index) => RecipeImageTile(
                        id: userModel.recipes![index],
                      ),
                      itemCount: userModel.recipes!.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
