import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:uza_sales/app/orderBooker/orders/order_booker_history.dart';
import 'package:uza_sales/app/orderBooker/pages/booker_home.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:uza_sales/app/sales/orders/order_history.dart';

class BookerPaymentPage extends StatelessWidget {
  final String deliveryDate;
  const BookerPaymentPage({Key key, @required this.deliveryDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgScreen,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
          child: Container(
        height: Utils.displayHeight(context),
        width: Utils.displayWidth(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            CircleAvatar(
              radius: 100,
              backgroundColor: Color(0xFFF1F1F1),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Your order is on the way",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  color: AppColor.text),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              // color: Colors.green,
              width: Utils.displayWidth(context) * 0.6,
              child: RichText(
                maxLines: 3,
                text: TextSpan(
                  text:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id euismod mollis porttitor dui pulvinar euismod iaculis sem vitae.",
                  style: TextStyle(
                    color: Color(0xFFA0A0A0),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Est Delivery:",
              style: TextStyle(fontSize: 13, color: AppColor.text),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              this.deliveryDate,
              style: TextStyle(fontSize: 15, color: AppColor.text),
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0)),
              color: AppColor.preBase,
              height: 55,
              minWidth: Utils.displayWidth(context) * 0.65,
              onPressed: () {
                pushNewScreen(
                  context,
                  screen: OrderBookerHistory(),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Text(
                'Track My Order'.toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                pushNewScreen(
                  context,
                  screen: BookerHome(),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Text(
                'Order Something Else'.toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    color: AppColor.text),
              ),
            ),
            Spacer(),
          ],
        ),
      )),
    );
  }
}
