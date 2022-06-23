import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:uza_sales/app/sales/model/sales_order_model.dart';

class SaleOrderItems extends StatelessWidget {
  final SaleItem item;
  const SaleOrderItems({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,##,000');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5),
          child: Divider(
            color: Colors.grey,
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(this.item.productName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                width: 10,
              ),
              Text(
                "x ${this.item.count} ${this.item.unit}",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.text),
              )
            ],
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5),
          child: Divider(
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),

        // Container(
        //   height: 40,
        //   width: Utils.displayWidth(context),
        //   decoration: BoxDecoration(
        //       color: AppColor.preBase,
        //       borderRadius: BorderRadius.only(
        //           bottomLeft: Radius.circular(6),
        //           bottomRight: Radius.circular(6))),
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Text("Total Cost",
        //             style: TextStyle(color: Colors.white, fontSize: 14)),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         Text(
        //           "${formatter.format(this.item.totalPrice)} Tsh",
        //           style: TextStyle(
        //               fontSize: 14,
        //               fontWeight: FontWeight.w500,
        //               color: Colors.white),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
