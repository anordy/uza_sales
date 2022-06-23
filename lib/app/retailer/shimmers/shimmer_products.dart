import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';

class ProductsShimmer extends StatelessWidget {
  const ProductsShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white),
                  height: Utils.displayHeight(context) * 0.065,
                  width: Utils.displayWidth(context) * 0.13,
                ),
                SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white),
                      height: Utils.displayHeight(context) * 0.025,
                      width: Utils.displayWidth(context) * 0.45,
                    ),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white),
                      height: Utils.displayHeight(context) * 0.015,
                      width: Utils.displayWidth(context) * 0.3,
                    )
                  ],
                ),
                SizedBox(
                  width: 13,
                ),
              ],
            ),
            SizedBox(height: Utils.displayHeight(context) * 0.01),
          ],
        ),
      ),
    );
  }
}
