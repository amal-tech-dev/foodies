import 'package:foodies/utils/color_constant.dart';
import 'package:image_cropper/image_cropper.dart';

class CropperUiSettings {
  static AndroidUiSettings android = AndroidUiSettings(
    toolbarTitle: 'Crop Image',
    toolbarColor: ColorConstant.backgroundLight,
    toolbarWidgetColor: ColorConstant.secondaryLight,
    backgroundColor: ColorConstant.tertiaryLight,
    cropFrameColor: ColorConstant.secondaryLight,
    cropFrameStrokeWidth: 3,
    lockAspectRatio: true,
    hideBottomControls: true,
  );
}
