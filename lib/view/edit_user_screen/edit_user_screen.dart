import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/user_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_text_field.dart';
import 'package:foodies/widgets/pick_image_bottom_sheet.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditUserScreen extends StatefulWidget {
  EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
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
  ImageCropper cropper = ImageCropper();
  File? profile, cover;
  String? profileUrl, coverUrl;
  UserModel userModel = UserModel();
  bool loading = false;
  List usernames = [];
  String myUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    getUserData();
    getUsername();
    super.initState();
  }

  // get user data from firestore
  getUserData() async {
    DocumentReference reference = firestore.collection('users').doc(myUid);
    DocumentSnapshot snapshot = await reference.get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    userModel = UserModel.fromJson(data);
    profileUrl = userModel.profile;
    coverUrl = userModel.cover;
    nameController = TextEditingController(text: userModel.name ?? '');
    usernameController = TextEditingController(text: userModel.username ?? '');
    bioController = TextEditingController(text: userModel.bio ?? '');
    setState(() {});
  }

  // get usernames from firestore
  getUsername() async {
    DocumentReference reference =
        firestore.collection('database').doc('username');
    DocumentSnapshot snapshot = await reference.get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    usernames = data['username'];
    setState(() {});
  }

  // update usernames from firestore
  updateUsername() async {
    DocumentReference reference =
        firestore.collection('database').doc('username');
    await reference.update({
      'username': FieldValue.arrayUnion([usernameController.text.trim()])
    });
    await reference.update({
      'username': FieldValue.arrayRemove([userModel.username])
    });
    setState(() {});
  }

  // delete image in firebase
  deleteImage(String field, String url) async {
    await storage.refFromURL(url).delete();
    await firestore.collection('users').doc(myUid).update({field: null});
    getUserData();
    setState(() {});
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
    getUserData();
    setState(() {});
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
            toolbarColor: ColorConstant.background,
            toolbarWidgetColor: ColorConstant.primary,
            backgroundColor: ColorConstant.tertiary,
            cropFrameColor: ColorConstant.primary,
            cropFrameStrokeWidth: 3,
            lockAspectRatio: true,
            hideBottomControls: true,
          ),
        ],
      );
      if (croppedImage != null) {
        if (field == 'cover') {
          cover = File(croppedImage.path);
          coverUrl = null;
        } else {
          profile = File(croppedImage.path);
          profileUrl = null;
        }
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.background,
        surfaceTintColor: Colors.transparent,
        leading: CustomButton.back(),
        title: Text(
          'Edit Account',
          style: TextStyle(
            color: ColorConstant.primary,
            fontSize: DimenConstant.small,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.all(
          DimenConstant.padding,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                InkWell(
                  onTap: () => showModalBottomSheet(
                    backgroundColor: ColorConstant.background,
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
                        cover = null;
                        coverUrl = null;
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.5625,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        DimenConstant.borderRadiusSmall,
                      ),
                      image: DecorationImage(
                        image: cover == null
                            ? coverUrl == null
                                ? AssetImage(ImageConstant.cover)
                                : NetworkImage(coverUrl!)
                                    as ImageProvider<Object>
                            : FileImage(cover!) as ImageProvider<Object>,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                DimenConstant.separator,
                Row(
                  children: [
                    InkWell(
                      onTap: () => showModalBottomSheet(
                        backgroundColor: ColorConstant.background,
                        showDragHandle: true,
                        context: context,
                        builder: (context) => PickImageBottomSheet(
                          onCameraPressed: () async {
                            pickAndCropImage(ImageSource.camera, 'profile');
                            setState(() {});
                            Navigator.pop(context);
                          },
                          onGalleryPressed: () async {
                            pickAndCropImage(ImageSource.gallery, 'profile');
                            setState(() {});
                            Navigator.pop(context);
                          },
                          onDeletePressed: () {
                            profile = null;
                            profileUrl = null;
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(ImageConstant.profile),
                        foregroundImage: profile == null
                            ? profileUrl == null
                                ? AssetImage(ImageConstant.profile)
                                : NetworkImage(profileUrl!)
                                    as ImageProvider<Object>
                            : FileImage(profile!) as ImageProvider<Object>,
                      ),
                    ),
                    DimenConstant.separator,
                    Expanded(
                      child: CustomContainer(
                        child: CustomTextField.singleLineForm(
                          context: context,
                          label: 'Display Name',
                          controller: nameController,
                          limit: 40,
                          onSubmit: (value) => FocusScope.of(context)
                              .requestFocus(usernameFocusNode),
                          validator: (value) {
                            if (value!.isEmpty) return 'Name must not be empty';
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                DimenConstant.separator,
                CustomContainer(
                  child: CustomTextField.singleLineForm(
                    context: context,
                    label: 'Username',
                    controller: usernameController,
                    focusNode: usernameFocusNode,
                    limit: 15,
                    onSubmit: (value) =>
                        FocusScope.of(context).requestFocus(bioFocusNode),
                    validator: (value) {
                      if (value!.isEmpty) return 'Enter a valid username';
                      if (!checkUsername(value))
                        return 'Only alphabets, numbers and charecters ( . _ ) are allowed';
                      if (checkUsernameAvailable(value))
                        return 'The username is not available';
                      return null;
                    },
                  ),
                ),
                DimenConstant.separator,
                CustomContainer(
                  child: CustomTextField.multiLineForm(
                    context: context,
                    label: 'Bio',
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
                DimenConstant.separator,
                CustomButton.text(
                  text: 'Save',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      DocumentReference reference =
                          firestore.collection('users').doc(myUid);
                      if (userModel.name != nameController.text.trim())
                        await reference
                            .update({'name': nameController.text.trim()});
                      if (userModel.username !=
                          usernameController.text.trim()) {
                        await reference.update(
                            {'username': usernameController.text.trim()});
                        updateUsername();
                      }
                      if (userModel.bio != bioController.text.trim())
                        await reference
                            .update({'bio': bioController.text.trim()});
                      if (profile == null && profileUrl == null)
                        deleteImage('profile', userModel.profile!);
                      if (profile != null) updateImage('profile', profile!);
                      if (cover == null && coverUrl == null)
                        deleteImage('cover', userModel.cover!);
                      if (cover != null) updateImage('cover', cover!);
                      Navigator.pop(context);
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

  // check username is already used
  bool checkUsernameAvailable(String value) {
    return usernames.contains(value) && value != userModel.username;
  }
}
