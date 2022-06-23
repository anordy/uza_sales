import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:uza_sales/app/sales/model/myStock_model.dart';

class MyStockItems extends StatefulWidget {
  final StocksContent stocksContent;
  const MyStockItems({Key key, @required this.stocksContent}) : super(key: key);

  @override
  _MyStockItemsState createState() => _MyStockItemsState();
}

class _MyStockItemsState extends State<MyStockItems> {
  String type;
  final types = ['Carton', 'Dozen', 'Piece', 'Bags'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: 60,
        width: Utils.displayWidth(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              this.widget.stocksContent.productName,
              style: TextStyle(
                  color: AppColor.text,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            // Container(
            //   height: 40,
            //   width: 1,
            //   color: Colors.grey,
            // ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                // border: Border.all(color: AppColor.border)
              ),
              width: Utils.displayWidth(context) * 0.3,
              child: Center(
                  child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                          // alignedDropdown: true,
                          child: DropdownButton<String>(
                icon: Icon(FontAwesomeIcons.chevronDown,
                    color: Color(0xFF545557)),
                iconSize: 15,
                value: type,
                hint: Text("${this.widget.stocksContent.unit}"),
                isExpanded: true,
                onChanged: (String value) {
                  setState(() {
                    type = value;
                  });
                },
                items: types.map(buildMenuItem).toList(),
                style: TextStyle(color: Colors.black45, fontSize: 16),
              )))),
            ),

            Container(
              // color: Colors.grey,
              height: 50,
              width: Utils.displayWidth(context) * 0.2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "${this.widget.stocksContent.quantity}",
                      hintStyle: TextStyle(color: AppColor.preBase)),
                ),
              ),
            ),

            // Text("63.0 Carton(s)",style: TextStyle(color: AppColor.preBase,fontSize: 14),)
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}
