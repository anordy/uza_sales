import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:uza_sales/app/sales/model/sales_order_model.dart';
import 'package:uza_sales/app/sales/orders/order_details.dart';
import 'package:uza_sales/app/sales/provider/salesOrder_provider.dart';

class OrderCard extends StatefulWidget {
  final Order order;
  const OrderCard({Key key, @required this.order}) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  TextEditingController checkIn = TextEditingController();
  TextEditingController checkOut = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkIn.text = Jiffy(this.widget.order.checkIn).format('hh:mm');
    checkOut.text = Jiffy(this.widget.order.checkOut).format('hh:mm');
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<SalesOrderProvider>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 266,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: Utils.displayWidth(context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        color: AppColor.preBase),
                    child: Center(
                      child: Text(
                        this?.widget?.order?.storeName?.toUpperCase() ?? "",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("check-in",
                            style: TextStyle(
                                color: Color(0xFF9E9E9E), fontSize: 14)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          checkIn.text,
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
                        Text("check-out",
                            style: TextStyle(
                                color: Color(0xFF9E9E9E), fontSize: 14)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          checkOut.text,
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
                        left: 20.0, right: 20.0, top: 15.0),
                    child: Divider(
                      color: AppColor.border,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order-Id",
                            style: TextStyle(
                                color: Color(0xFF9E9E9E), fontSize: 14)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget?.order?.orderId ?? "",
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
                        Text("Order Status",
                            style: TextStyle(
                                color: Color(0xFF9E9E9E), fontSize: 14)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget?.order?.orderStatus ?? "",
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
                    padding: const EdgeInsets.only(
                      left: 20.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        //  orderProvider.setOrder(this.widget.order);
                        pushNewScreen(
                          context,
                          screen: OrderDetails(
                            order: this.widget.order,
                          ),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Container(
                        height: 40,
                        width: 90,
                        decoration: BoxDecoration(
                            color: AppColor.preBase,
                            borderRadius: BorderRadius.circular(72)),
                        child: Center(
                            child: Text(
                          "View Order",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
