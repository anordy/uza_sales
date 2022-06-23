import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';

class RedeemDialog extends StatefulWidget {
  final String ok, desc;
  final Function okChange, cancelChange;

  const RedeemDialog(
      {Key key,
      @required this.ok,
      @required this.desc,
      @required this.cancelChange,
      @required this.okChange})
      : super(key: key);

  @override
  _CustomToastState createState() => _CustomToastState();
}

class _CustomToastState extends State<RedeemDialog> {
// Declare this variable
  int selectedRadio;

  @override
  void initState() {
    super.initState();
  }

  setSelectedRadio(dynamic val) async {
    setState(() {
      selectedRadio = val['index'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
          margin: EdgeInsets.only(top: 180),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                // BoxShadow(
                //     color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      child: Icon(
                        Icons.error,
                        color: AppColor.base,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Oops!",
                      style: TextStyle(color: AppColor.base, fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  this.widget.desc,
                  style: TextStyle(color: Color(0xFF7D7D7D), fontSize: 18),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  // TextButton(
                  //     onPressed: this.widget.cancelChange,
                  //     child: Text(this.widget.cancel.toUpperCase(),
                  //         style: TextStyle(
                  //           color: Color(0xFFA0A0A0),
                  //           fontSize: 14,
                  //         ))),
                  TextButton(
                      onPressed: this.widget.okChange,
                      child: Text(this.widget.ok.toUpperCase(),
                          style: TextStyle(
                            color: AppColor.base,
                            fontSize: 14,
                          ))),
                ]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
