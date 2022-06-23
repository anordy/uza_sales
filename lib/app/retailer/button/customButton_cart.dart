import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';

class CustomButttonCart extends StatelessWidget {
  final Function addtoCart;
  final String label1;
  final String label2;
  final Function buyNow;
  const CustomButttonCart(
      {Key key,
      @required this.addtoCart,
      @required this.buyNow,
      @required this.label1,
      @required this.label2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: addtoCart,
          child: Container(
            height: 60,
            width: Utils.displayWidth(context) * 0.4,
            decoration: BoxDecoration(
                color: AppColor.base,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Center(
              child: Text(
                label1,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: buyNow,
          child: Container(
            height: 60,
            width: Utils.displayWidth(context) * 0.4,
            decoration: BoxDecoration(
                color: AppColor.sideBase,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Center(
              child: Text(
                label2,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
