import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:uza_sales/app/sales/model/sales_order_model.dart';
import 'package:uza_sales/app/sales/provider/salesOrder_provider.dart';

class CashOrderDialog extends StatefulWidget {
  final Order order;
  final String cancel, ok, desc;
  final Function okChange, cancelChange;

  const CashOrderDialog(
      {Key key,
      @required this.cancel,
      @required this.ok,
      @required this.desc,
      @required this.cancelChange,
      @required this.okChange,
      @required this.order})
      : super(key: key);

  @override
  _ComfirmDialogState createState() => _ComfirmDialogState();
}

class _ComfirmDialogState extends State<CashOrderDialog> {
// Declare this variable
  int selectedRadio;
  String reason;
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
    final _orderProvider = Provider.of<SalesOrderProvider>(context);
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
          margin: EdgeInsets.only(top: 230),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Thanks For Shopping with Us!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        onPressed: this.widget.cancelChange,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                // Container(
                //   height: 45,
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 10,
                //   ),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(6),
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
                //     value: reason,
                //     hint: Text("Select Reason"),
                //     isExpanded: true,
                //     onChanged: (String value) {
                //       setState(() {
                //         reason = value;
                //         print("============ reasons ============");
                //         print(reason);
                //       });
                //     },
                //     items: reasons.map(buildMenuItem).toList(),
                //     style: TextStyle(color: Colors.black45, fontSize: 16),
                //   )))),
                // ),

                SizedBox(
                  height: 10.0,
                ),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                    color: AppColor.preBase,
                    height: 40,
                    minWidth: Utils.displayWidth(context),
                    onPressed: () {
                      _orderProvider.payCash(
                          cashedAmount: this.widget.order.orderTotal,
                          orderId: this.widget.order.orderId,
                          creditedAmount: 0);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      this.widget.ok,
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}
