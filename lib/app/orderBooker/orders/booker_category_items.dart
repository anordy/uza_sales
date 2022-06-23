import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/model/category_model.dart';
import 'package:uza_sales/app/retailer/provider/category_provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';

class BookerCategoryItems extends StatefulWidget {
  final Category category;
  final int index;
  const BookerCategoryItems(
      {Key key, @required this.index, @required this.category})
      : super(key: key);

  @override
  _SaleCategoryItemsState createState() => _SaleCategoryItemsState();
}

class _SaleCategoryItemsState extends State<BookerCategoryItems> {
  var rot = 45;

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context);
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 110,
              height: 40,
              decoration: BoxDecoration(
                  color: category.selectedCategory == widget.index
                      ? AppColor.preBase
                      : Colors.white,
                  // border: Border.all(color: AppColor.border)
                  border: Border(
                      bottom: BorderSide(color: AppColor.border),
                      right: BorderSide(color: AppColor.border))),
              child: Center(
                child: Text(
                  this.widget.category.name,
                  style: TextStyle(
                      fontSize: 13,
                      color: category.selectedCategory == widget.index
                          ? Colors.white
                          : Color(0xff1F212C)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: Container(
            width: 110,
            height: 10,
            color: Colors.transparent,
            child: Center(
              child: Transform.rotate(
                angle: (rot * (pi / 180)),
                child: Container(
                  height: 8,
                  width: 8,
                  color: category.selectedCategory == widget.index
                      ? AppColor.preBase
                      : Colors.transparent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
