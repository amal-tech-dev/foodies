import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/user_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/view/get_started_screen/get_started_screen.dart';
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_text_field.dart';
import 'package:foodies/widgets/loading.dart';
import 'package:foodies/widgets/pick_image_bottom_sheet.dart';
import 'package:foodies/widgets/separator.dart';
import 'package:image_picker/image_picker.dart';

class AddUserDetailsScreen extends StatefulWidget {
  AddUserDetailsScreen({super.key});

  @override
  State<AddUserDetailsScreen> createState() => _AddUserDetailsScreenState();
}

class _AddUserDetailsScreenState extends State<AddUserDetailsScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode bioFocusNode = FocusNode();
  ImagePicker picker = ImagePicker();
  File? profile, cover;
  UserModel model = UserModel();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundDark,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Complete your profile',
          style: TextStyle(
            color: ColorConstant.secondaryDark,
            fontSize: DimenConstant.small,
          ),
        ),
        actions: [
          Loading(
            visible: loading,
            size: 20,
            width: 2.5,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.all(
          DimenConstant.padding,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select a cover image',
                  style: TextStyle(
                    color: ColorConstant.primary,
                    fontSize: DimenConstant.extraSmall,
                  ),
                ),
                Separator(),
                InkWell(
                  onTap: () => PickImageBottomSheet.showModalSheet(
                    context: context,
                    onCameraPressed: () async {
                      XFile? pickedImage = await picker.pickImage(
                        source: ImageSource.camera,
                      );
                      if (pickedImage != null) cover = File(pickedImage.path);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    onGalleryPressed: () async {
                      XFile? pickedImage = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedImage != null) cover = File(pickedImage.path);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    onRemovePressed: () {
                      cover = null;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        DimenConstant.borderRadiusSmall,
                      ),
                      image: DecorationImage(
                        image: cover == null
                            ? AssetImage(ImageConstant.pickImage)
                            : FileImage(cover!) as ImageProvider<Object>,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Separator(),
                Text(
                  'Select your profile picture',
                  style: TextStyle(
                    color: ColorConstant.primary,
                    fontSize: DimenConstant.extraSmall,
                  ),
                ),
                Separator(),
                Center(
                  child: InkWell(
                    onTap: () => PickImageBottomSheet.showModalSheet(
                      context: context,
                      onCameraPressed: () async {
                        XFile? pickedImage = await picker.pickImage(
                          source: ImageSource.camera,
                        );
                        if (pickedImage != null)
                          profile = File(pickedImage.path);
                        setState(() {});
                        Navigator.pop(context);
                      },
                      onGalleryPressed: () async {
                        XFile? pickedImage = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedImage != null)
                          profile = File(pickedImage.path);
                        setState(() {});
                        Navigator.pop(context);
                      },
                      onRemovePressed: () {
                        profile = null;
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(ImageConstant.food),
                      foregroundImage: profile == null
                          ? AssetImage(ImageConstant.profile)
                          : FileImage(profile!) as ImageProvider<Object>,
                    ),
                  ),
                ),
                Separator(),
                CustomContainer(
                  child: CustomTextField.singleLineForm(
                    context: context,
                    hint: 'Display Name',
                    controller: nameController,
                    limit: 40,
                    onSubmit: (value) =>
                        FocusScope.of(context).requestFocus(usernameFocusNode),
                    validator: (value) {
                      if (value!.isEmpty) return 'Name must not be empty';
                      return null;
                    },
                  ),
                ),
                Separator(),
                CustomContainer(
                  child: CustomTextField.singleLineForm(
                    context: context,
                    hint: 'Username',
                    controller: usernameController,
                    focusNode: usernameFocusNode,
                    limit: 15,
                    onSubmit: (value) =>
                        FocusScope.of(context).requestFocus(bioFocusNode),
                    validator: (value) {
                      if (value!.isEmpty) return 'Enter a valid username';
                      if (!checkUsername(value))
                        return 'Only alphabets, numbers and charecters ( . _ ) are allowed';
                      return null;
                    },
                  ),
                ),
                Separator(),
                CustomContainer(
                  child: CustomTextField.multiLineForm(
                    context: context,
                    hint: 'Bio',
                    controller: bioController,
                    focusNode: bioFocusNode,
                    lines: 5,
                    limit: 200,
                    validator: (value) {
                      if (value!.isEmpty) return 'Your bio is empty';
                      return null;
                    },
                  ),
                ),
                Separator(),
                CustomButton.text(
                  text: 'Create Account',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      loading = true;
                      setState(() {});
                      try {
                        User user = auth.currentUser!;
                        model.username =
                            usernameController.text.trim().toLowerCase();
                        model.name = nameController.text.trim();
                        model.bio = bioController.text.trim();
                        if (profile != null) {
                          model.profile =
                              await uploadImage(profile!, 'profiles');
                        }
                        if (cover != null) {
                          model.cover = await uploadImage(cover!, 'covers');
                        }
                        model.followers = [];
                        model.following = [];
                        model.favourites = [];
                        model.recipes = [];
                        model.verified = false;
                        await firestore
                            .collection('users')
                            .doc(user.uid)
                            .set(model.toJson());
                        await user.sendEmailVerification();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GetStartedScreen(),
                          ),
                          (route) => false,
                        );
                      } catch (e) {
                        // Handle the error here
                        print('Error: $e');
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Private method to upload image to Firebase Storage
  Future<String> uploadImage(File imageFile, String folderName) async {
    String fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${imageFile.path.split('/').last}';
    Reference reference = storage.ref().child(folderName).child(fileName);
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // check username contains only lowercase letters, numbers, and underscore
  bool checkUsername(String value) {
    return value.contains(RegExp(r'^[a-z0-9_.]+$'));
  }
}
