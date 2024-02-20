import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/user_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';

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
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.71875,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.5625,
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
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.5625,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ColorConstant.tertiaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BackButton(
                        color: ColorConstant.primaryColor,
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
                        padding: const EdgeInsets.all(2.0),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(
                DimenConstant.padding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          userModel.name!,
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
                            '@${userModel.username!}',
                            style: TextStyle(
                              color: ColorConstant.secondaryColor,
                              fontSize: DimenConstant.smallText,
                            ),
                          ),
                          DimenConstant.separator,
                          Visibility(
                            visible: userModel.verified!,
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
                      Text(
                        'Recipes',
                        style: TextStyle(
                          color: ColorConstant.secondaryColor,
                          fontSize: DimenConstant.extraSmallText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      DimenConstant.separator,
                      (userModel.recipes ?? []).isEmpty
                          ? Text(
                              'No recipes yet.',
                              style: TextStyle(
                                color: ColorConstant.primaryColor,
                                fontSize: DimenConstant.extraSmallText,
                              ),
                              textAlign: TextAlign.justify,
                            )
                          : SizedBox(
                              height: 60,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(
                                    ImageConstant.food,
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    DimenConstant.separator,
                                itemCount: 10,
                              ),
                            ),
                      DimenConstant.separator,
                      Text(
                        'Bio',
                        style: TextStyle(
                          color: ColorConstant.secondaryColor,
                          fontSize: DimenConstant.extraSmallText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      DimenConstant.separator,
                      Text(
                        userModel.bio!,
                        style: TextStyle(
                          color: ColorConstant.primaryColor,
                          fontSize: DimenConstant.extraSmallText,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                  Visibility(
                    visible: myProfile,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(
                                DimenConstant.padding,
                              ),
                              decoration: BoxDecoration(
                                color: ColorConstant.tertiaryColor,
                                borderRadius: BorderRadius.circular(
                                  DimenConstant.borderRadius,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Edit Account',
                                  style: TextStyle(
                                    color: ColorConstant.secondaryColor,
                                    fontSize: DimenConstant.extraSmallText,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        DimenConstant.separator,
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(
                                DimenConstant.padding,
                              ),
                              decoration: BoxDecoration(
                                color: ColorConstant.tertiaryColor,
                                borderRadius: BorderRadius.circular(
                                  DimenConstant.borderRadius,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Delete Account',
                                  style: TextStyle(
                                    color: ColorConstant.errorColor,
                                    fontSize: DimenConstant.extraSmallText,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
