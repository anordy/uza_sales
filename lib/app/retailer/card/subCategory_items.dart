import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/model/category_model.dart';
import 'package:uza_sales/app/retailer/provider/category_provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';

class SubCategoryItems extends StatefulWidget {
  final SubCategory subCategory;
  final int index;
  const SubCategoryItems(
      {Key key, @required this.index, @required this.subCategory})
      : super(key: key);

  @override
  _SubCategoryItemsState createState() => _SubCategoryItemsState();
}

class _SubCategoryItemsState extends State<SubCategoryItems> {
  int _selectedCategory = 0;
  var rot = 45;

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context);
    return Container(
      width: 80,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Center(
          child: Text(
            widget.subCategory.name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: category.selectedsubCategory == widget.index
                    ? AppColor.base
                    : Color(0xff1F212C),
                fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
