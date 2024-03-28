import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final Color? color;
  EdgeInsets? padding;
  final BoxDecoration ?decoration;
  final VoidCallback ontap;

  CustomContainer({this.child, this.width, this.height, this.color, this.decoration,this.padding,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: padding,
        width: width,
        height: height,
        color: color,
        decoration: decoration,
        child: child,
      ),
    );
  }
}

