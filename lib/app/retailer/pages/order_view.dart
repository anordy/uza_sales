import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/button/custom_buton.dart';
import 'package:uza_sales/app/retailer/model/order_model.dart';
import 'package:uza_sales/app/retailer/pages/payment_page.dart';
import 'package:uza_sales/app/retailer/provider/order_provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/order_item.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:intl/intl.dart';

class OrderVIew extends StatefulWidget {
  final Order order;
  const OrderVIew({Key key, @required this.order}) : super(key: key);

  @override
  _OrderVIewState createState() => _OrderVIewState();
}

class _OrderVIewState extends State<OrderVIew> {
  var numberFormat = NumberFormat('#,##,000.00');

  @override
  void initState() {
    super.initState();
    //  final _orderProvider =
    //     Provider.of<OrderProvider>(context, listen: false);
    // _orderProvider.fetchOrder(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final _orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order ID:  23324",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      this.widget.order.paymentStatus == "UNPAID"
                          ? Text(
                              "${this.widget.order.paymentStatus}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.base),
                            )
                          : Text(
                              "${this.widget.order.paymentStatus}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.success),
                            ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Divider(
                    color: AppColor.border,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product",
                        style: TextStyle(fontSize: 16, color: AppColor.text),
                      ),
                      Text(
                        "Qty",
                        style: TextStyle(fontSize: 16, color: AppColor.text),
                      ),
                      Text(
                        "Unit",
                        style: TextStyle(
                          color: AppColor.text,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Price",
                        style: TextStyle(fontSize: 16, color: AppColor.text),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Divider(
                    color: AppColor.border,
                  ),
                ),
                Container(
                    // color: Colors.lightBlue,
                    height: Utils.displayHeight(context) * 0.3,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: this.widget.order.items.length,
                        itemBuilder: (context, i) {
                          return OrderItem(items: this.widget.order.items[i]);
                        })),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Divider(
                    color: AppColor.border,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: "Total".toUpperCase(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: ' (VAT & Transport)',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ])),
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: "Tsh  ",
                          style: TextStyle(color: AppColor.base, fontSize: 18)),
                      TextSpan(
                          text:
                              "${numberFormat.format(this.widget.order.grandTotal)}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColor.text)),
                    ]))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 180, right: 20),
                  child: Divider(
                    color: AppColor.border,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Payment",
                        style: TextStyle(fontSize: 14, color: AppColor.text),
                      ),
                      CustomButton(
                          color: AppColor.preBase,
                          inputText: Text(
                            "Pay Now".toUpperCase(),
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          onPressed: () {
                            pushNewScreen(
                              context,
                              screen: PaymentPage(
                                  deliveryDate: widget.order.createdDate),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          })
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text("Order Status"),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.base),
                    ),
                    Container(
                      color: AppColor.base,
                      height: 1,
                      width: Utils.displayWidth(context) * 0.25,
                    ),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black),
                    ),
                    Container(
                      color: Colors.black,
                      height: 1,
                      width: Utils.displayWidth(context) * 0.25,
                    ),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFFC0C0C0)),
                    ),
                    Container(
                      color: Color(0xFFC0C0C0),
                      height: 1,
                      width: Utils.displayWidth(context) * 0.25,
                    ),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFFC0C0C0)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Placed",
                        style: TextStyle(
                          color: AppColor.base,
                          fontSize: 12,
                        )),
                    Text(
                      "Paid",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Processed",
                      style: TextStyle(
                        color: Color(0xFFC0C0C0),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Delivered",
                      style: TextStyle(
                        color: Color(0xFFC0C0C0),
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
