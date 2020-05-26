import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:signinfirebaseapp/utils/app_colors.dart';

class CircleButtonWidget extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final String iconPath;
  final VoidCallback onPressed;

  const CircleButtonWidget({
    Key key,
    this.size = 55,
    this.backgroundColor = AppColors.primary,
    this.iconPath,
    @required this.onPressed,
  })  : assert(iconPath != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: this.onPressed,
      child: Container(
        width: size,
        height: size,
        padding: EdgeInsets.all(15),
        child: SvgPicture.asset(
          iconPath,
          color: Colors.white,
        ),
        decoration: BoxDecoration(
          color: this.backgroundColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
