import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/controller/text_input_format_controller.dart';
import 'package:foodies/model/user_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/view/get_started_screen/get_started_screen.dart';
import 'package:foodies/widgets/pick_image_bottom_sheet.dart';
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
  UserModel userModel = UserModel();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.background,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Complete your profile',
          style: TextStyle(
            color: ColorConstant.primary,
            fontSize: DimenConstant.small,
          ),
        ),
        actions: [
          Visibility(
            visible: isLoading,
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: ColorConstant.secondary,
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
                    color: ColorConstant.secondary,
                    fontSize: DimenConstant.extraSmall,
                  ),
                ),
                DimenConstant.separator,
                InkWell(
                  onTap: () => showModalBottomSheet(
                    backgroundColor: ColorConstant.background,
                    showDragHandle: true,
                    context: context,
                    builder: (context) => PickImageBottomSheet(
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
                            ? AssetImage(ImageConstant.cover)
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
                    color: ColorConstant.secondary,
                    fontSize: DimenConstant.extraSmall,
                  ),
                ),
                DimenConstant.separator,
                Center(
                  child: InkWell(
                    onTap: () => showModalBottomSheet(
                      backgroundColor: ColorConstant.background,
                      showDragHandle: true,
                      context: context,
                      builder: (context) => PickImageBottomSheet(
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
                        onDeletePressed: () {
                          profile = null;
                          setState(() {});
                          Navigator.pop(context);
                        },
                      ),
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
                DimenConstant.separator,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: DimenConstant.padding,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstant.tertiary,
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
                          color: ColorConstant.secondary,
                          fontSize: DimenConstant.mini,
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: ColorConstant.primary,
                      fontSize: DimenConstant.mini,
                    ),
                    cursorColor: ColorConstant.secondary,
                    cursorRadius: Radius.circular(
                      DimenConstant.cursorRadius,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                      TextInputFormatController(),
                    ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textCapitalization: TextCapitalization.words,
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
                    color: ColorConstant.tertiary,
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
                          color: ColorConstant.secondary,
                          fontSize: DimenConstant.mini,
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: ColorConstant.primary,
                      fontSize: DimenConstant.mini,
                    ),
                    cursorColor: ColorConstant.secondary,
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
                        return 'Only alphabets, numbers and charecters ( . _ ) are allowed';
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
                    color: ColorConstant.tertiary,
                    borderRadius: BorderRadius.circular(
                      DimenConstant.borderRadius,
                    ),
                  ),
                  child: TextFormField(
                    controller: bioController,
                    focusNode: bioFocusNode,
                    decoration: InputDecoration(
                      label: Text(
                        'Bio',
                        style: TextStyle(
                          color: ColorConstant.secondary,
                          fontSize: DimenConstant.mini,
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: ColorConstant.primary,
                      fontSize: DimenConstant.mini,
                    ),
                    cursorColor: ColorConstant.secondary,
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
                    validator: (value) {
                      if (value!.isEmpty) return 'Your bio is empty';
                      return null;
                    },
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
                      ColorConstant.secondary,
                    ),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        User user = auth.currentUser!;
                        userModel.username =
                            usernameController.text.trim().toLowerCase();
                        userModel.name = nameController.text.trim();
                        userModel.bio = bioController.text.trim();
                        if (profile != null) {
                          userModel.profile =
                              await uploadImage(profile!, 'profiles');
                        }
                        if (cover != null) {
                          userModel.cover = await uploadImage(cover!, 'covers');
                        }
                        userModel.followers = [];
                        userModel.following = [];
                        userModel.menu = [];
                        userModel.recipes = [];
                        userModel.verified = false;
                        await firestore
                            .collection('users')
                            .doc(user.uid)
                            .set(userModel.toJson());
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
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      color: ColorConstant.tertiary,
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
