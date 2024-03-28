import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  double? height, width;
  String? text;
  Color? color;
  final Widget child;

  final VoidCallback? onTap;

  AppButton(
      {Key? key,
      this.text,
      this.height,
      this.width,
      required this.onTap,
      this.color,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: color),
        child: Center(child: child),
      ),
    );
  }
}
