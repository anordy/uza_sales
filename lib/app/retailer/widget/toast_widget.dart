import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';

class ToastWidget extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final Widget icon;
  final String description;
  const ToastWidget(
      {@required this.color,
      @required this.description,
      @required this.height,
      @required this.icon,
      @required this.width});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, right: 60, bottom: 32),
      // alignment: Alignment.topCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFF06BE77),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: color)),
          // width: 250.0,
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                icon,
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: RichText(
                    // overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    text: TextSpan(
                        text: description,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                // Text(
                //   description,
                //   style: TextStyle(color: Color(0xFF06be77),fontSize: 14,fontWeight: FontWeight.bold),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// code sent
class CodeSentToast extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final Widget icon;
  final String description;
  const CodeSentToast(
      {@required this.color,
      @required this.description,
      @required this.height,
      @required this.icon,
      @required this.width});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, right: 60, bottom: 32),
      // alignment: Alignment.topCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFF06BE77),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: color)),
          // width: 250.0,
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 35),
                icon,
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RichText(
                    // overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    text: TextSpan(
                        text: description,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                // Text(
                //   description,
                //   style: TextStyle(color: Color(0xFF06be77),fontSize: 14,fontWeight: FontWeight.bold),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// succesfully loged in

class LoggedInToast extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final Widget icon;
  final String description;
  const LoggedInToast(
      {@required this.color,
      @required this.description,
      @required this.height,
      @required this.icon,
      @required this.width});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, right: 60, bottom: 32),
      // alignment: Alignment.topCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFF06BE77),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: color)),
          // width: 250.0,
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                icon,
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RichText(
                    // overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    text: TextSpan(
                        text: description,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                // Text(
                //   description,
                //   style: TextStyle(color: Color(0xFF06be77),fontSize: 14,fontWeight: FontWeight.bold),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
