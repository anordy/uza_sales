import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:uza_sales/app/sales/model/sales_order_model.dart';
import 'package:uza_sales/app/sales/provider/salesOrder_provider.dart';

class ReturnGoods extends StatefulWidget {
  final Order order;
  const ReturnGoods({Key key, @required this.order}) : super(key: key);

  @override
  _ReturnGoodsState createState() => _ReturnGoodsState();
}

class _ReturnGoodsState extends State<ReturnGoods> {
  TextEditingController _quantityController = TextEditingController();
  String category;
  final items = ['Soft Drinks', 'Liquor', 'Beuty & Cosmetics'];
  String product;
  final products = ['Heineken', 'Pepsi', 'Coca Cola', 'Azam Embe'];
  String unit;
  final units = ['Cartons', 'Pc', 'Pack'];
  String reason;
  final reasons = ['Expired', 'Broken'];

  @override
  Widget build(BuildContext context) {
    final _returnProv = Provider.of<SalesOrderProvider>(context);
    return Scaffold(
        backgroundColor: AppColor.bgScreen2,
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverStickyHeader(
                header: Container(
                  color: AppColor.bgScreen2,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
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
                                "Return Goods",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.title,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      )),
                ),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Container(
                      height: Utils.displayHeight(context) * 0.7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text("Product Category"),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // Container(
                            //   height: 50,
                            //   padding: EdgeInsets.symmetric(
                            //     horizontal: 10,
                            //   ),
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(50),
                            //       border: Border.all(color: AppColor.border)),
                            //   width: Utils.displayWidth(context),
                            //   child: Center(
                            //       child: DropdownButtonHideUnderline(
                            //           child: ButtonTheme(
                            //               // alignedDropdown: true,
                            //               child: DropdownButton<String>(
                            //     icon: Icon(FontAwesomeIcons.chevronDown,
                            //         color: Color(0xFFCECECE)),
                            //     iconSize: 15,
                            //     value: category,
                            //     hint: Text("Select Category"),
                            //     isExpanded: true,
                            //     onChanged: (String value) {
                            //       setState(() {
                            //         category = value;
                            //       });
                            //     },
                            //     items: items.map(buildMenuItem).toList(),
                            //     style: TextStyle(
                            //         color: Colors.black45, fontSize: 16),
                            //   )))),
                            // ),

                            SizedBox(
                              height: 20.0,
                            ),
                            Text("Product"),
                            SizedBox(
                              height: 20,
                            ),

                            Container(
                              height: 50,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: AppColor.border)),
                              width: Utils.displayWidth(context),
                              child: Center(
                                  child: DropdownButtonHideUnderline(
                                      child: ButtonTheme(
                                          // alignedDropdown: true,
                                          child: DropdownButton<String>(
                                icon: Icon(FontAwesomeIcons.chevronDown,
                                    color: Color(0xFFCECECE)),
                                iconSize: 15,
                                value: product,
                                hint: Text("Select Products"),
                                isExpanded: true,
                                onChanged: (String value) {
                                  setState(() {
                                    product = value;
                                  });
                                },
                                items: this
                                    .widget
                                    .order
                                    .items
                                    .map(buildMenuProduct)
                                    .toList(),
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 16),
                              )))),
                            ),

                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Unit"),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 50,
                                      width: Utils.displayWidth(context) * 0.35,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: AppColor.border)),
                                      child: Center(
                                          child: DropdownButtonHideUnderline(
                                              child: ButtonTheme(
                                                  // alignedDropdown: true,
                                                  child: DropdownButton<String>(
                                        icon: Icon(FontAwesomeIcons.chevronDown,
                                            color: Color(0xFFCECECE)),
                                        iconSize: 15,
                                        value: unit,
                                        hint: Text("Units"),
                                        isExpanded: true,
                                        onChanged: (String value) {
                                          setState(() {
                                            unit = value;
                                          });
                                        },
                                        items: this
                                            .widget
                                            .order
                                            .items
                                            .map(buildMenuUnits)
                                            .toList(),
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 16),
                                      )))),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Quantity"),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 45,
                                      width: Utils.displayWidth(context) * 0.35,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xFFC7D3DD)),
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller: _quantityController,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "${this.widget.order.items[0].count}"),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.chevronUp,
                                                    color: Color(0xFFCECECE),
                                                    size: 15,
                                                  ),
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .chevronDown,
                                                    color: Color(0xFFCECECE),
                                                    size: 15,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text("Reason"),
                            SizedBox(
                              height: 20,
                            ),

                            Container(
                              height: 50,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: AppColor.border)),
                              width: Utils.displayWidth(context),
                              child: Center(
                                  child: DropdownButtonHideUnderline(
                                      child: ButtonTheme(
                                          // alignedDropdown: true,
                                          child: DropdownButton<String>(
                                icon: Icon(FontAwesomeIcons.chevronDown,
                                    color: Color(0xFFCECECE)),
                                iconSize: 15,
                                value: reason,
                                hint: Text("Select Reason"),
                                isExpanded: true,
                                onChanged: (String value) {
                                  setState(() {
                                    reason = value;
                                  });
                                },
                                items: reasons.map(buildMenuItem).toList(),
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 16),
                              )))),
                            ),

                            Spacer(),
                            Center(
                              child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(60.0)),
                                  color: AppColor.preBase,
                                  height: 50,
                                  minWidth: Utils.displayWidth(context) * 0.6,
                                  onPressed: () {
                                    _returnProv.returnGoods(
                                      orderId: this.widget.order.orderId,
                                      productId: "",
                                      unit: unit,
                                      reason: reason,
                                      quantity: _quantityController.text,
                                    );
                                    showToastWidget(
                                      ToastWidget(
                                          icon: Icon(
                                            Icons.done,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          height: 50,
                                          width: 250,
                                          color: AppColor.success,
                                          description: "Success"),
                                      duration: Duration(seconds: 2),
                                      position: ToastPosition.bottom,
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Confirm Return",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ])),
              ),
            ],
          ),
        ));
  }

// product names
  DropdownMenuItem<String> buildMenuProduct(SaleItem product) =>
      DropdownMenuItem(
        value: product.productName,
        child: Text("${product.productName}"),
      );
// product units
  DropdownMenuItem<String> buildMenuUnits(SaleItem product) => DropdownMenuItem(
        value: product.type,
        child: Text("${product.type}"),
      );

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}
