import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uza_sales/app/retailer/model/product_model.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';

class ProductQuantityCard extends StatefulWidget {
  final Product product;
  const ProductQuantityCard({Key key, @required this.product})
      : super(key: key);

  @override
  _ProductQuantityCardState createState() => _ProductQuantityCardState();
}

class _ProductQuantityCardState extends State<ProductQuantityCard> {
  String type;
  final types = ['Carton', 'Dozen', 'Piece', 'Bags'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: 45,
        width: Utils.displayWidth(context),
        // decoration: BoxDecoration(
        //     border: Border.all(color: Color(0xFFC7D3DD)),
        //     borderRadius: BorderRadius.circular(50.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                this.widget.product.name,
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
                  hint: Text("Carton(s)"),
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
                        hintText: "5",
                        hintStyle: TextStyle(color: AppColor.preBase)),
                  ),
                ),
              ),

              // Text("63.0 Carton(s)",style: TextStyle(color: AppColor.preBase,fontSize: 14),)
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}
