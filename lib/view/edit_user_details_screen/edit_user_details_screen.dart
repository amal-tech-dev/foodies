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
import 'package:foodies/widgets/pick_image_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';

class EditUserDetailsScreen extends StatefulWidget {
  EditUserDetailsScreen({super.key});

  @override
  State<EditUserDetailsScreen> createState() => _EditUserDetailsScreenState();
}

class _EditUserDetailsScreenState extends State<EditUserDetailsScreen> {
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
  String? profileUrl, coverUrl;
  UserModel userModel = UserModel();
  bool isLoading = false;
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
    profileUrl = userModel.profile ?? '';
    coverUrl = userModel.cover ?? '';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundColor,
        surfaceTintColor: Colors.transparent,
        leading: BackButton(
          color: ColorConstant.primaryColor,
        ),
        title: Text(
          'Edit Account',
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.smallText,
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
                    backgroundColor: ColorConstant.backgroundColor,
                    showDragHandle: true,
                    context: context,
                    builder: (context) => PickImageBottomSheet(
                      onCameraPressed: () async {
                        XFile? pickedImage = await picker.pickImage(
                          source: ImageSource.camera,
                        );
                        if (pickedImage != null) {
                          cover = File(pickedImage.path);
                          coverUrl = null;
                        }
                        setState(() {});
                        Navigator.pop(context);
                      },
                      onGalleryPressed: () async {
                        XFile? pickedImage = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedImage != null) {
                          cover = File(pickedImage.path);
                          coverUrl = null;
                        }
                        setState(() {});
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
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        DimenConstant.borderRadius,
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
                        backgroundColor: ColorConstant.backgroundColor,
                        showDragHandle: true,
                        context: context,
                        builder: (context) => PickImageBottomSheet(
                          onCameraPressed: () async {
                            XFile? pickedImage = await picker.pickImage(
                              source: ImageSource.camera,
                            );
                            if (pickedImage != null) {
                              profile = File(pickedImage.path);
                              profileUrl = null;
                            }
                            setState(() {});
                            Navigator.pop(context);
                          },
                          onGalleryPressed: () async {
                            XFile? pickedImage = await picker.pickImage(
                              source: ImageSource.gallery,
                            );
                            if (pickedImage != null) {
                              profile = File(pickedImage.path);
                              profileUrl = null;
                            }
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
                      child: Column(
                        children: [
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textCapitalization: TextCapitalization.words,
                              onTapOutside: (event) =>
                                  FocusScope.of(context).unfocus(),
                              onFieldSubmitted: (value) =>
                                  FocusScope.of(context)
                                      .requestFocus(usernameFocusNode),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Name must not be empty';
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onTapOutside: (event) =>
                                  FocusScope.of(context).unfocus(),
                              onFieldSubmitted: (value) =>
                                  FocusScope.of(context)
                                      .requestFocus(bioFocusNode),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Enter a valid username';
                                if (!checkUsername(value))
                                  return 'Only alphabets, numbers and charecters ( . _ ) are allowed';
                                if (checkUsernameAvailable(value))
                                  return 'The username is not available';
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                        'Bio',
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
                    validator: (value) {
                      if (value!.isEmpty) return 'Your bio is empty';
                      return null;
                    },
                  ),
                ),
                DimenConstant.separator,
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      ColorConstant.secondaryColor,
                    ),
                  ),
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
                      if (profile != null) {
                        if (profile == null && profileUrl == null)
                          deleteImage('profile', userModel.profile!);
                        else
                          updateImage('profile', profile!);
                      }
                      if (cover != null) {
                        if (cover == null && coverUrl == null)
                          deleteImage('cover', userModel.cover!);
                        else
                          updateImage('cover', cover!);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding,
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: ColorConstant.tertiaryColor,
                      ),
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

  // check username is already used
  bool checkUsernameAvailable(String value) {
    return usernames.contains(value) && value != userModel.username;
  }
}