import 'package:flutter/material.dart';

import '../../theme/colors/light_colors.dart';

class TopContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final EdgeInsets padding;
  TopContainer({Key? key, required this.height, required this.width, required this.child, required this.padding}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding!=null ? padding : const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: const BoxDecoration(
          color: LightColors.kDarkYellow,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
          )),
      height: height,
      width: width,
      child: child,
    );
  }
}
