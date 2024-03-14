import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/controller/text_input_format_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/widgets/custom_container.dart';

class AddRecipeDetailsScreen extends StatefulWidget {
  AddRecipeDetailsScreen({super.key});

  @override
  State<AddRecipeDetailsScreen> createState() => _AddRecipeDetailsScreenState();
}

class _AddRecipeDetailsScreenState extends State<AddRecipeDetailsScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  FocusNode aboutFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorConstant.background,
        surfaceTintColor: Colors.transparent,
        leading: BackButton(
          color: ColorConstant.primary,
        ),
        title: Text(
          'Add Recipe',
          style: TextStyle(
            color: ColorConstant.primary,
            fontSize: DimenConstant.small,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: DimenConstant.separator,
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  DimenConstant.separator,
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      ImageConstant.food,
                    ),
                  ),
                  DimenConstant.separator,
                  Expanded(
                    child: CustomContainer(
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          label: Text(
                            'Recipe Name',
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
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).requestFocus(aboutFocusNode),
                        validator: (value) {
                          if (value!.isEmpty) return 'Name must not be empty';
                          return null;
                        },
                      ),
                    ),
                  ),
                  DimenConstant.separator,
                ],
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
                child: CustomContainer(
                  child: TextFormField(
                    controller: aboutController,
                    focusNode: aboutFocusNode,
                    decoration: InputDecoration(
                      label: Text(
                        'About',
                        style: TextStyle(
                          color: ColorConstant.secondary,
                          fontSize: DimenConstant.mini,
                        ),
                      ),
                      alignLabelWithHint: true,
                      border: InputBorder.none,
                    ),
                    maxLines: 5,
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
                        FocusScope.of(context).unfocus(),
                    validator: (value) {
                      if (value!.isEmpty) return 'Name must not be empty';
                      return null;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
