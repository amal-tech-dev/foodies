import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  double radius;
  bool? visible;
  Color? color;
  ImageProvider<Object>? image;
  VoidCallback? onPressed;
  Widget? child;
  CustomCircleAvatar({
    super.key,
    required this.radius,
    this.visible,
    this.color,
    this.image,
    this.onPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible ?? true,
      child: InkWell(
        onTap: onPressed,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: color,
          backgroundImage: image,
          child: child,
        ),
      ),
    );
  }
}
