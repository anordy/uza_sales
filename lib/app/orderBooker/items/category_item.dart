import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, top: 8.0, right: 5.0),
      child: Container(
        height: 168,
        width: Utils.displayWidth(context) * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.house,
              color: AppColor.preBase,
              size: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "All Stores",
              style: TextStyle(color: Color(0xFFAEAEAE)),
            )
          ],
        ),
      ),
    );
  }
}
