import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/user_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/profile_view_screen/profile_view_widgets/recipe_image_tile.dart';
import 'package:foodies/widgets/app_name.dart';
import 'package:foodies/widgets/counter.dart';
import 'package:foodies/widgets/pick_image_bottom_sheet.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewScreen extends StatefulWidget {
  String uid;
  ProfileViewScreen({
    super.key,
    required this.uid,
  });

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  UserModel user = UserModel();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  bool currentUser = false, isFollowing = false;
  String profile = ImageConstant.profile, cover = ImageConstant.pickImage;
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
    user = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    if (myUid == widget.uid) currentUser = true;
    profile = user.profile ?? ImageConstant.profile;
    cover = user.cover ?? ImageConstant.pickImage;
    if (user.followers!.contains(myUid))
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
            toolbarColor: ColorConstant.backgroundDark,
            toolbarWidgetColor: ColorConstant.secondaryDark,
            backgroundColor: ColorConstant.tertiaryDark,
            cropFrameColor: ColorConstant.secondaryDark,
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
      color: ColorConstant.primary,
      backgroundColor: ColorConstant.backgroundDark,
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
                  Container(
                    height: MediaQuery.of(context).size.width * 0.5625,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding / 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                          DimenConstant.borderRadiusSmall * 4,
                        ),
                        bottomRight: Radius.circular(
                          DimenConstant.borderRadiusSmall * 4,
                        ),
                      ),
                      image: DecorationImage(
                        image: user.cover != null
                            ? NetworkImage(
                                cover,
                              ) as ImageProvider<Object>
                            : AssetImage(
                                cover,
                              ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (currentUser) {
                        showModalBottomSheet(
                          backgroundColor: ColorConstant.backgroundDark,
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
                              deleteImage('cover', user.cover!);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.5625,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                        horizontal: DimenConstant.padding / 2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            DimenConstant.borderRadiusSmall * 4,
                          ),
                          bottomRight: Radius.circular(
                            DimenConstant.borderRadiusSmall * 4,
                          ),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ColorConstant.tertiaryDark.withOpacity(0.2),
                            ColorConstant.tertiaryDark.withOpacity(0.2),
                            ColorConstant.tertiaryDark.withOpacity(0.1),
                            ColorConstant.tertiaryDark.withOpacity(0.1),
                            ColorConstant.tertiaryDark.withOpacity(0.0),
                          ],
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SafeArea(
                            child: BackButton(
                              color: ColorConstant.secondaryDark,
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
                        Counter(
                          count: user.followers?.length ?? 0,
                          header: 'Followers',
                        ),
                        InkWell(
                          onTap: () {
                            if (currentUser) {
                              showModalBottomSheet(
                                backgroundColor: ColorConstant.backgroundDark,
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
                                    deleteImage('profile', user.profile!);
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            }
                          },
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.15625,
                            backgroundImage: AssetImage(
                              ImageConstant.profile,
                            ),
                            foregroundImage: user.profile != null
                                ? NetworkImage(
                                    profile,
                                  ) as ImageProvider<Object>
                                : AssetImage(
                                    profile,
                                  ),
                          ),
                        ),
                        Counter(
                          count: user.following?.length ?? 0,
                          header: 'Following',
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
                  user.name != StringConstant.appName
                      ? Text(
                          user.name ?? '',
                          style: TextStyle(
                            color: ColorConstant.secondaryDark,
                            fontSize: DimenConstant.large,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : AppName(
                          size: DimenConstant.large,
                        ),
                  SizedBox(
                    width: 5,
                  ),
                  Visibility(
                    visible: user.verified ?? false,
                    child: Icon(
                      Icons.verified_rounded,
                      color: ColorConstant.primary,
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  '@${user.username ?? ''}',
                  style: TextStyle(
                    color: ColorConstant.primary,
                    fontSize: DimenConstant.small,
                    fontFamily: StringConstant.font,
                  ),
                ),
              ),
            ),
            SliverVisibility(
              visible: !currentUser,
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        isFollowing
                            ? ColorConstant.secondaryDark
                            : ColorConstant.primary,
                      ),
                    ),
                    onPressed: () async {
                      DocumentReference followersReference =
                          firestore.collection('users').doc(widget.uid);
                      DocumentReference followingReference =
                          firestore.collection('users').doc(myUid);
                      if (user.followers!.contains(myUid)) {
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
                              ? ColorConstant.tertiaryDark
                              : ColorConstant.tertiaryDark,
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
                    color: ColorConstant.primary,
                    fontSize: DimenConstant.extraSmall,
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
                  user.bio ?? '',
                  style: TextStyle(
                    color: ColorConstant.secondaryDark,
                    fontSize: DimenConstant.extraSmall,
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
                    color: ColorConstant.primary,
                    fontSize: DimenConstant.extraSmall,
                  ),
                ),
              ),
            ),
            (user.recipes ?? []).isEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DimenConstant.padding,
                      ),
                      child: Text(
                        'No recipes yet.',
                        style: TextStyle(
                          color: ColorConstant.secondaryDark,
                          fontSize: DimenConstant.extraSmall,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding,
                    ),
                    sliver: SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: DimenConstant.padding,
                        mainAxisSpacing: DimenConstant.padding,
                        childAspectRatio: 0.95,
                      ),
                      itemBuilder: (context, index) => RecipeImageTile(
                        id: user.recipes![index],
                      ),
                      itemCount: user.recipes!.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
