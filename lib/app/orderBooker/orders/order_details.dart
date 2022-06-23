import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:uza_sales/app/sales/items/sale_order_items.dart';
import 'package:uza_sales/app/sales/pages/return_goods.dart';
import 'package:uza_sales/app/sales/provider/salesOrder_provider.dart';
import 'package:uza_sales/app/sales/widget/cancel_order_dialog.dart';
import 'package:uza_sales/app/sales/widget/cash_order_dialog.dart';
import 'package:uza_sales/app/sales/model/sales_order_model.dart';
import 'package:uza_sales/app/sales/widget/credit_order_dialog.dart';
import 'package:uza_sales/app/sales/widget/print_receipt_dialog.dart';
import 'package:uza_sales/app/sales/widget/simple_more_widget.dart';

class OrderDetails extends StatefulWidget {
  final Order order;
  const OrderDetails({Key key, @required this.order}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String dateTime;
  String fromStatus = "Today";
  DateTime selectedDate = DateTime.now();
  TextEditingController _orderDate = TextEditingController();
  var formatter = NumberFormat('#,##,000');

  @override
  void initState() {
    super.initState();
    _orderDate.text = Jiffy(this.widget.order.orderDate).format('yyyy-MM-dd');
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<SalesOrderProvider>(context);
    return Scaffold(
        backgroundColor: AppColor.bgScreen2,
        body: SafeArea(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    color: AppColor.bgScreen2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            // SizedBox(width: 2,),
                            Text(
                              "Order Details".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.title,
                                  fontWeight: FontWeight.w600),
                            ),
                            // SizedBox(
                            //   width: 80,
                            // ),
                            Spacer(),
                            InkWell(
                              onTap: () {},
                              child: this.widget.order.orderStatus ==
                                      "CANCELLED"
                                  ? Container(
                                      height: 38,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.preBase),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Center(
                                          child: Text(
                                        "More",
                                        style: TextStyle(fontSize: 16),
                                      )),
                                    )
                                  : SimpleAccountMenu(
                                      strings: [
                                        Text(
                                          "Share Receipt",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColor.title,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Divider(
                                          color: Color(0xFFE5E6E5),
                                        ),
                                        Text("Add Payment - Cash",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: AppColor.title,
                                                fontWeight: FontWeight.w500)),
                                        Divider(
                                          color: Color(0xFFE5E6E5),
                                        ),
                                        Text("Add Payment - Credit",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: AppColor.title,
                                                fontWeight: FontWeight.w500)),
                                        Divider(
                                          color: Color(0xFFE5E6E5),
                                        ),
                                        Text("Return Goods",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: AppColor.title,
                                                fontWeight: FontWeight.w500)),
                                        Divider(
                                          color: Color(0xFFE5E6E5),
                                        ),
                                        Text(
                                            "Update Order:${this.widget.order.orderPaymentStatus}",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: AppColor.title,
                                                fontWeight: FontWeight.w500)),
                                        Divider(
                                          color: Color(0xFFE5E6E5),
                                        ),
                                        Text("Cancel Order",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: AppColor.title,
                                                fontWeight: FontWeight.w500)),
                                        Divider(
                                          color: Color(0xFFE5E6E5),
                                        ),
                                        Text("Print Receipt",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: AppColor.title,
                                                fontWeight: FontWeight.w500))
                                      ],
                                      iconColor: Colors.white,
                                      onChange: (index) {
                                        if (index == 0) {
                                          print("send receipt");
                                          Share.share("Receipt Details");
                                        } else if (index == 2) {
                                          print("add payment cash");
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CashOrderDialog(
                                                    order: this.widget.order,
                                                    desc:
                                                        "Check in was success",
                                                    cancel: "Okay",
                                                    ok: "Confirm",
                                                    cancelChange: () {
                                                      Navigator.pop(context);
                                                    },
                                                    okChange: () {});
                                              });
                                        } else if (index == 4) {
                                          print("add payment credit");
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CreditOrderDialog(
                                                    order: this.widget.order,
                                                    desc:
                                                        "Check in was success",
                                                    cancel: "Okay",
                                                    ok: "Confirm",
                                                    cancelChange: () {
                                                      Navigator.pop(context);
                                                    },
                                                    okChange: () {
                                                      // Navigator.pop(context);
                                                      // pushNewScreen(
                                                      //   context,
                                                      //   screen: SalesHome(),
                                                      //   withNavBar:
                                                      //       false, // OPTIONAL VALUE. True by default.
                                                      //   pageTransitionAnimation:
                                                      //       PageTransitionAnimation
                                                      //           .cupertino,
                                                      // );
                                                    });
                                              });
                                        } else if (index == 6) {
                                          pushNewScreen(
                                            context,
                                            screen: ReturnGoods(
                                              order: this.widget.order,
                                            ),
                                            withNavBar:
                                                true, // OPTIONAL VALUE. True by default.
                                            pageTransitionAnimation:
                                                PageTransitionAnimation
                                                    .cupertino,
                                          );
                                          print("Return Goods");
                                        } else if (index == 6) {
                                          print("Update order");
                                        } else if (index == 10) {
                                          print("cancel order");
                                          if (this
                                                  .widget
                                                  .order
                                                  .orderPaymentStatus ==
                                              "PAID") {
                                            // Navigator.of(context).pop();
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return CancelOrderDialog(
                                                      order: this.widget.order,
                                                      desc:
                                                          "Check in was success",
                                                      cancel: "Okay",
                                                      ok: "Confirm",
                                                      cancelChange: () {
                                                        Navigator.pop(context);
                                                      },
                                                      okChange: () {});
                                                });
                                          }
                                        } else if (index == 12) {
                                          print("print receipt");
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return PrintReceiptDialog(
                                                    order: this.widget.order,
                                                    desc: "",
                                                    cancel: "Okay",
                                                    ok: "Confirm",
                                                    cancelChange: () {
                                                      Navigator.pop(context);
                                                    },
                                                    okChange: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                              });
                                        }
                                      },
                                    ),

                              // Container(
                              //   height: 38,
                              //   width: 70,
                              //   decoration: BoxDecoration(
                              //       border: Border.all(color: AppColor.preBase),
                              //       borderRadius: BorderRadius.circular(10)),
                              //   child: Center(
                              //       child: Text(
                              //     "More",
                              //     style: TextStyle(fontSize: 16),
                              //   )),
                              // ),
                            )
                          ],
                        ),
                      ],
                    )),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  height: Utils.displayHeight(context) * 0.18,
                  width: Utils.displayWidth(context),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 10.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Order Status",
                                style: TextStyle(
                                    color: Color(0xFF9B9C9B), fontSize: 14)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              this.widget.order.orderStatus ?? "",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.text),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 10.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Order Date",
                                style: TextStyle(
                                    color: Color(0xFF9B9C9B), fontSize: 14)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _orderDate.text,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.text),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 10.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Payment Status",
                                style: TextStyle(
                                    color: Color(0xFF9B9C9B), fontSize: 14)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              this.widget.order.orderPaymentStatus,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.text),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                          height: 38,
                          width: 170,
                          decoration: BoxDecoration(
                              color: AppColor.preBase,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            "Print Status: unprinted",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                // Text(
                //   "Summary",
                //   style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 14,
                //       fontWeight: FontWeight.bold),
                // ),
                // SizedBox(
                //   height: 15.0,
                // ),
                // Padding(
                //   padding:
                //       const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text("Order Date",
                //           style: TextStyle(
                //               color: Color(0xFF9B9C9B), fontSize: 14)),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Text(
                //         _orderDate.text,
                //         style: TextStyle(
                //             fontSize: 14,
                //             fontWeight: FontWeight.w500,
                //             color: AppColor.text),
                //       )
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding:
                //       const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text("Order Total",
                //           style: TextStyle(
                //               color: Color(0xFF9B9C9B), fontSize: 14)),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Text(
                //         "${formatter.format(this.widget.order.orderTotal)} Tsh",
                //         style: TextStyle(
                //             fontSize: 14,
                //             fontWeight: FontWeight.w500,
                //             color: AppColor.text),
                //       )
                //     ],
                //   ),
                // ),

                // SizedBox(
                //   height: 15.0,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                //   child: Divider(
                //     color: Colors.grey,
                //   ),
                // ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Delivery",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Status",
                          style: TextStyle(
                              color: Color(0xFF9B9C9B), fontSize: 14)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        this.widget.order.orderStatus,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.text),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Branch",
                          style: TextStyle(
                              color: Color(0xFF9B9C9B), fontSize: 14)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        this.widget.order.supplier,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.text),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("ETA",
                          style: TextStyle(
                              color: Color(0xFF9B9C9B), fontSize: 14)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "02 Sept 2022",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.text),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Items",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                // SizedBox(
                //   height: 10.0,
                // ),
                Spacer(),
                Container(
                    height: Utils.displayHeight(context) * 0.3,
                    width: Utils.displayWidth(context),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 10.0, right: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Product",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.text)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "QTY",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.text),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: Utils.displayHeight(context) * 0.2,
                            // color: Colors.blue,
                            child: ListView.builder(
                                itemCount: this.widget.order.items.length,
                                itemBuilder: (context, i) {
                                  return SaleOrderItems(
                                      item: this.widget.order.items[i]);
                                }),
                          ),
                          Spacer(),
                          Container(
                            height: 40,
                            width: Utils.displayWidth(context),
                            decoration: BoxDecoration(
                                color: AppColor.preBase,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10.0, right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total Cost",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${formatter.format(this.widget.order.orderTotal)} Tsh",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 3,
                ),
              ],
            ),
          ),
        )));
  }

  // select date
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppColor.preBase,
                onPrimary: Colors.white,
                surface: AppColor.preBase,
                onSurface: AppColor.text,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        },
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _orderDate.text = DateFormat.yMMMd().format(selectedDate);
      });
  }
}
