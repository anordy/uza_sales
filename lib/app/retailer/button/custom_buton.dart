import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final Widget inputText;
  final double height;
  final double width;
  final Color color;
  final Function onPressed;
  const CustomButton({ Key key,@required this.inputText, this.height, this.width ,@required this.onPressed, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0)),
              color: color,
              height: height,
              minWidth: width,
              onPressed: onPressed,
              child: inputText
            ),
    );
  }
}