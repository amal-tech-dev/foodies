import 'dart:io';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/user_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/view/profile_screen/profile_widgets/recipe_image_tile.dart';
import 'package:foodies/widgets/pick_image_bottom_sheet.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

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
  FirebaseStorage storage = FirebaseStorage.instance;
  bool currentUser = false, isFollowing = false;
  num followers = 0, following = 0;
  String profile = ImageConstant.profile, cover = ImageConstant.cover;
  String myUid = FirebaseAuth.instance.currentUser!.uid;
  ImagePicker picker = ImagePicker();
  ImageCropper cropper = ImageCropper();
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

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
    if (myUid == widget.uid) currentUser = true;
    profile = userModel.profile ?? ImageConstant.profile;
    cover = userModel.cover ?? ImageConstant.cover;
    followers = userModel.followers!.length;
    following = userModel.following!.length;
    if (userModel.followers!.contains(myUid))
      isFollowing = true;
    else
      isFollowing = false;
    setState(() {});
  }

  // delete image in firebase
  deleteImage(String field, String url) async {
    await storage.refFromURL(url).delete();
    await firestore.collection('users').doc(myUid).update({field: null});
    refreshKey.currentState?.show();
  }

  // update image in firebase
  updateImage(String field, File image) async {
    Reference reference = storage
        .ref()
        .child(field)
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
    await reference.putFile(image);
    String imageReference = await reference.getDownloadURL();
    await firestore
        .collection('users')
        .doc(myUid)
        .update({field: imageReference});
    refreshKey.currentState?.show();
  }

  // pick image and crop for requirements
  pickAndCropImage(ImageSource source, String field) async {
    XFile? pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      CroppedFile? croppedImage = await cropper.cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: CropAspectRatio(
          ratioX: field == 'cover' ? 16 : 1,
          ratioY: field == 'cover' ? 9 : 1,
        ),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop ${field} image',
            toolbarColor: ColorConstant.backgroundColor,
            toolbarWidgetColor: ColorConstant.primaryColor,
            backgroundColor: ColorConstant.tertiaryColor,
            cropFrameColor: ColorConstant.primaryColor,
            cropFrameStrokeWidth: 3,
            lockAspectRatio: true,
            hideBottomControls: true,
          ),
        ],
      );
      if (croppedImage != null) {
        File image = File(croppedImage.path);
        updateImage(field, image);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: refreshKey,
      color: ColorConstant.secondaryColor,
      backgroundColor: ColorConstant.backgroundColor,
      onRefresh: () async => await getUserData(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.71875,
                    width: MediaQuery.of(context).size.width,
                  ),
                  InkWell(
                    onTap: () {
                      if (currentUser) {
                        showModalBottomSheet(
                          backgroundColor: ColorConstant.backgroundColor,
                          showDragHandle: true,
                          context: context,
                          builder: (context) => PickImageBottomSheet(
                            onCameraPressed: () async {
                              pickAndCropImage(ImageSource.camera, 'cover');
                              Navigator.pop(context);
                            },
                            onGalleryPressed: () async {
                              pickAndCropImage(ImageSource.gallery, 'cover');
                              Navigator.pop(context);
                            },
                            onDeletePressed: () {
                              deleteImage('cover', userModel.cover!);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      }
                    },
                    child: Container(
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
                                  cover,
                                ) as ImageProvider<Object>
                              : AssetImage(
                                  cover,
                                ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: SafeArea(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DimenConstant.separator,
                            BackButton(
                              color: ColorConstant.primaryColor,
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  ColorConstant.backgroundColor
                                      .withOpacity(0.1),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                  Map<String, dynamic> data = snapshot.data!
                                      .data() as Map<String, dynamic>;
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
                        InkWell(
                          onTap: () {
                            if (currentUser) {
                              showModalBottomSheet(
                                backgroundColor: ColorConstant.backgroundColor,
                                showDragHandle: true,
                                context: context,
                                builder: (context) => PickImageBottomSheet(
                                  onCameraPressed: () async {
                                    pickAndCropImage(
                                        ImageSource.camera, 'profile');
                                    Navigator.pop(context);
                                  },
                                  onGalleryPressed: () async {
                                    pickAndCropImage(
                                        ImageSource.gallery, 'profile');
                                    Navigator.pop(context);
                                  },
                                  onDeletePressed: () {
                                    deleteImage('profile', userModel.profile!);
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            }
                          },
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.15625,
                            backgroundColor: ColorConstant.backgroundColor,
                            child: Padding(
                              padding: const EdgeInsets.all(3.5),
                              child: CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width * 0.15625,
                                backgroundImage: AssetImage(
                                  ImageConstant.profile,
                                ),
                                foregroundImage: userModel.profile != null
                                    ? NetworkImage(
                                        profile,
                                      ) as ImageProvider<Object>
                                    : AssetImage(
                                        profile,
                                      ),
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
                                  Map<String, dynamic> data = snapshot.data!
                                      .data() as Map<String, dynamic>;
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
            ),
            SliverToBoxAdapter(
              child: DimenConstant.separator,
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userModel.name ?? '',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.largeText,
                    ),
                    textAlign: TextAlign.center,
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
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  '@${userModel.username ?? ''}',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.smallText,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Visibility(
                visible: !currentUser,
                child: Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        isFollowing
                            ? ColorConstant.primaryColor
                            : ColorConstant.secondaryColor,
                      ),
                    ),
                    onPressed: () async {
                      DocumentReference followersReference =
                          firestore.collection('users').doc(widget.uid);
                      DocumentReference followingReference =
                          firestore.collection('users').doc(myUid);
                      if (userModel.followers!.contains(myUid)) {
                        await followingReference.update({
                          'following': FieldValue.arrayRemove([myUid])
                        });
                        await followersReference.update({
                          'followers': FieldValue.arrayRemove([widget.uid])
                        });
                      } else {
                        await followingReference.update({
                          'following': FieldValue.arrayUnion([myUid])
                        });
                        await followersReference.update({
                          'followers': FieldValue.arrayUnion([widget.uid])
                        });
                      }
                      getUserData();
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DimenConstant.padding * 2,
                      ),
                      child: Text(
                        isFollowing ? 'Following' : 'Follow',
                        style: TextStyle(
                          color: isFollowing
                              ? ColorConstant.tertiaryColor
                              : ColorConstant.tertiaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: DimenConstant.separator,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimenConstant.padding,
                ),
                child: Text(
                  'Bio',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.extraSmallText,
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
                  userModel.bio ?? '',
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: DimenConstant.extraSmallText,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: DimenConstant.separator,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimenConstant.padding,
                ),
                child: Text(
                  'Recipes',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.extraSmallText,
                  ),
                ),
              ),
            ),
            (userModel.recipes ?? []).isEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
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
                    ),
                  )
                : SliverGrid.builder(
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
          ],
        ),
      ),
    );
  }
}
