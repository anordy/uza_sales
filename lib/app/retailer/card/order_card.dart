import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:uza_sales/app/retailer/model/order_model.dart';
import 'package:uza_sales/app/retailer/pages/order_view.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard({Key key, @required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var numberFormat = NumberFormat('#,##,000.00');

    return Container(
      height: 125,
      width: Utils.displayWidth(context),
      decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 5,
              color: Colors.black.withOpacity(0.2),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 8.0, left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      AppLocalizations.of(context).order_id,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("2423345442",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF959595)))
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      AppLocalizations.of(context).order_date,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("${order.createdDate}",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF959595)))
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      AppLocalizations.of(context).amount,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("${numberFormat.format(order.grandTotal)}",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF959595))),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      AppLocalizations.of(context).status,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("${order.status}".capitalize(),
                        style: TextStyle(
                            fontSize: 16,
                            color: order.status == "PENDING"
                                ? Color(0xFFED1E1E)
                                : Color(0xFF959595)))
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 28,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.base)),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.white,
                    height: 28,
                    minWidth: 87,
                    onPressed: () {
                      // pushNewScreen(
                      //     context,
                      //     screen: OrderVIew(order: order,),
                      //     withNavBar: true, // OPTIONAL VALUE. True by default.
                      //     pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      // );
                    },
                    child: Text(
                      "Receipt",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: AppColor.base,
                  height: 28,
                  minWidth: 87,
                  onPressed: () {
                    pushNewScreen(
                      context,
                      screen: OrderVIew(
                        order: order,
                      ),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context).view,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
