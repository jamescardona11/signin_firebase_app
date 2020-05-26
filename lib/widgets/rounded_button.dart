import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:signinfirebaseapp/utils/app_colors.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const RoundedButtonWidget({
    Key key,
    @required this.label,
    @required this.onPressed,
    this.backgroundColor = AppColors.primary,
  })  : assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
            )
          ],
        ),
        child: Text(
          this.label,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'sans',
            letterSpacing: 1,
            fontSize: 18,
          ),
        ),
      ),
      onPressed: this.onPressed,
    );
  }
}
