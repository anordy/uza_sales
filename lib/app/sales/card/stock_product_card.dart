import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uza_sales/app/retailer/model/category_model.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';

class ProductStockCard extends StatelessWidget {
  final Category category;
  const ProductStockCard({Key key, @required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: 45,
        width: Utils.displayWidth(context),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFC7D3DD)),
            borderRadius: BorderRadius.circular(50.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(this.category.name,
                  style: TextStyle(color: AppColor.text, fontSize: 14)),
              CircleAvatar(
                radius: 15,
                backgroundColor: AppColor.preBase,
                child: Icon(
                  FontAwesomeIcons.chevronRight,
                  size: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
