import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/controller/text_input_format_controller.dart';
import 'package:foodies/generated/assets.dart';
import 'package:foodies/model/user_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/get_started_screen/get_started_screen.dart';
import 'package:foodies/widgets/pick_image_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';

class AddUserDetailsScreen extends StatefulWidget {
  AddUserDetailsScreen({super.key});

  @override
  State<AddUserDetailsScreen> createState() => _AddUserDetailsScreenState();
}

class _AddUserDetailsScreenState extends State<AddUserDetailsScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode bioFocusNode = FocusNode();
  String emptyCover = Assets.imagesCover;
  String emptyProfile = Assets.imagesProfile;
  ImagePicker picker = ImagePicker();
  File? profile, cover;
  UserModel userModel = UserModel();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundColor,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Complete your profile',
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.smallText,
          ),
        ),
        actions: [
          Visibility(
            visible: isLoading,
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: ColorConstant.secondaryColor,
                strokeWidth: 2.5,
                strokeCap: StrokeCap.round,
              ),
            ),
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
                  'Select a cover image (optional)',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.extraSmallText,
                  ),
                ),
                DimenConstant.separator,
                InkWell(
                  onTap: () => showModalBottomSheet(
                    backgroundColor: ColorConstant.backgroundColor,
                    showDragHandle: true,
                    context: context,
                    builder: (context) => PickImageBottomSheet(
                      onCameraPressed: () async {
                        final pickedImage = await picker.pickImage(
                          source: ImageSource.camera,
                        );
                        if (pickedImage != null) cover = File(pickedImage.path);
                        setState(() {});
                        Navigator.pop(context);
                      },
                      onGalleryPressed: () async {
                        final pickedImage = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedImage != null) cover = File(pickedImage.path);
                        setState(() {});
                        Navigator.pop(context);
                      },
                      onDeletePressed: () {
                        cover = null;
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        DimenConstant.borderRadius,
                      ),
                      image: DecorationImage(
                        image: cover == null
                            ? AssetImage(emptyCover)
                            : FileImage(cover!) as ImageProvider<Object>,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                DimenConstant.separator,
                Text(
                  'Select your profile picture (optional)',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.extraSmallText,
                  ),
                ),
                DimenConstant.separator,
                Center(
                  child: InkWell(
                    onTap: () => showModalBottomSheet(
                      backgroundColor: ColorConstant.backgroundColor,
                      showDragHandle: true,
                      context: context,
                      builder: (context) => PickImageBottomSheet(
                        onCameraPressed: () async {
                          final pickedImage = await picker.pickImage(
                            source: ImageSource.camera,
                          );
                          if (pickedImage != null)
                            profile = File(pickedImage.path);
                          setState(() {});
                          Navigator.pop(context);
                        },
                        onGalleryPressed: () async {
                          final pickedImage = await picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (pickedImage != null)
                            profile = File(pickedImage.path);
                          setState(() {});
                          Navigator.pop(context);
                        },
                        onDeletePressed: () {
                          profile = null;
                          setState(() {});
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(Assets.imagesFood),
                      foregroundImage: profile == null
                          ? AssetImage(emptyProfile)
                          : FileImage(profile!) as ImageProvider<Object>,
                    ),
                  ),
                ),
                DimenConstant.separator,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: DimenConstant.padding,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstant.tertiaryColor,
                    borderRadius: BorderRadius.circular(
                      DimenConstant.borderRadius,
                    ),
                  ),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      label: Text(
                        'Display Name',
                        style: TextStyle(
                          color: ColorConstant.secondaryColor,
                          fontSize: DimenConstant.miniText,
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.miniText,
                    ),
                    cursorColor: ColorConstant.secondaryColor,
                    cursorRadius: Radius.circular(
                      DimenConstant.cursorRadius,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                      TextInputFormatController(),
                    ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textCapitalization: TextCapitalization.sentences,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    onFieldSubmitted: (value) =>
                        FocusScope.of(context).requestFocus(usernameFocusNode),
                    validator: (value) {
                      if (value!.isEmpty) return 'Name must not be empty';
                      return null;
                    },
                  ),
                ),
                DimenConstant.separator,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: DimenConstant.padding,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstant.tertiaryColor,
                    borderRadius: BorderRadius.circular(
                      DimenConstant.borderRadius,
                    ),
                  ),
                  child: TextFormField(
                    controller: usernameController,
                    focusNode: usernameFocusNode,
                    decoration: InputDecoration(
                      label: Text(
                        'Username',
                        style: TextStyle(
                          color: ColorConstant.secondaryColor,
                          fontSize: DimenConstant.miniText,
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.miniText,
                    ),
                    cursorColor: ColorConstant.secondaryColor,
                    cursorRadius: Radius.circular(
                      DimenConstant.cursorRadius,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                    ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    onFieldSubmitted: (value) =>
                        FocusScope.of(context).requestFocus(bioFocusNode),
                    validator: (value) {
                      if (value!.isEmpty) return 'Enter a valid username';
                      if (!checkUsername(value))
                        return 'Only alphabets, numbers and underscore are allowed';
                      return null;
                    },
                  ),
                ),
                DimenConstant.separator,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: DimenConstant.padding,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstant.tertiaryColor,
                    borderRadius: BorderRadius.circular(
                      DimenConstant.borderRadius,
                    ),
                  ),
                  child: TextFormField(
                    controller: bioController,
                    focusNode: bioFocusNode,
                    decoration: InputDecoration(
                      label: Text(
                        'Bio (optional)',
                        style: TextStyle(
                          color: ColorConstant.secondaryColor,
                          fontSize: DimenConstant.miniText,
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.miniText,
                    ),
                    cursorColor: ColorConstant.secondaryColor,
                    cursorRadius: Radius.circular(
                      DimenConstant.cursorRadius,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(200),
                      TextInputFormatController(),
                    ],
                    textCapitalization: TextCapitalization.sentences,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    onFieldSubmitted: (value) =>
                        FocusScope.of(context).unfocus(),
                  ),
                ),
                DimenConstant.separator,
                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(
                      Size(
                        MediaQuery.of(context).size.width,
                        45,
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      ColorConstant.secondaryColor,
                    ),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        User user = firebaseAuth.currentUser!;
                        await uploadImagesAndUpdateModel(profile, cover);
                        userModel.username = usernameController.text.trim();
                        userModel.name = nameController.text.trim();
                        userModel.bio = bioController.text.isNotEmpty
                            ? bioController.text.trim()
                            : null;
                        await firebaseFirestore
                            .collection('users')
                            .doc(user.uid)
                            .set(userModel.toJson());
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
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      color: ColorConstant.tertiaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to upload profile and cover images to Firebase Storage
  Future<void> uploadImagesAndUpdateModel(
      File? profileImage, File? coverImage) async {
    if (profileImage != null) {
      userModel.profile = await uploadImage(profileImage, 'profiles');
    }
    if (coverImage != null) {
      userModel.cover = await uploadImage(coverImage, 'covers');
    }
  }

  // Private method to upload image to Firebase Storage
  Future<String> uploadImage(File imageFile, String folderName) async {
    final storage = FirebaseStorage.instance;
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${imageFile.path.split('/').last}';
    final Reference reference = storage.ref().child(folderName).child(fileName);
    final UploadTask uploadTask = reference.putFile(imageFile);
    final TaskSnapshot taskSnapshot = await uploadTask;
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // check username contains only lowercase letters, numbers, and underscore
  bool checkUsername(String value) {
    return value.contains(RegExp(r'^[a-z0-9_]+$'));
  }
}
