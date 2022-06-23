import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uza_sales/app/retailer/model/order_model.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class OrderItem extends StatelessWidget {
  final Item items;

  OrderItem({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var numberFormat = NumberFormat('#,##,000.00');

    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 15.0),
      child: Container(
        // color: Colors.green,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 5,
            ),
            Container(
              height: 40,
              width: Utils.displayWidth(context) * 0.25,
              // color: Colors.tealAccent,
              child: Center(
                child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        text: items.productName,
                        style: TextStyle(color: AppColor.text, fontSize: 14))),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              height: 40,
              width: Utils.displayWidth(context) * 0.2,
              // color: Colors.amber,
              child: Center(
                child: Text(
                  "${items.count}",
                  style: TextStyle(color: AppColor.text, fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              height: 40,
              width: Utils.displayWidth(context) * 0.18,
              // color: Colors.grey,
              child: Center(
                child: Text(
                  "${items.unit.capitalize()}",
                  style: TextStyle(color: AppColor.text, fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              height: 40,
              width: Utils.displayWidth(context) * 0.2,
              // color: Colors.tealAccent,
              child: Center(
                child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        text: '${numberFormat.format(items.totalPrice)}',
                        style: TextStyle(color: AppColor.text, fontSize: 14))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
