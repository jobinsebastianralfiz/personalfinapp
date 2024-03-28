import 'package:flutter/material.dart';



class AppText extends StatelessWidget {
  String? data;
  double? size;
  Color? color;
  FontWeight? fw;
  TextAlign? align;
  AppText({Key? key, required this.data, this.size=18, this.color, this.fw,this.align=TextAlign.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(

      data.toString(),
      textAlign: align,
     // overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: size, color: color,fontWeight: fw),
    );
  }
}
