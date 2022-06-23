import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';

class SubCatShimmer extends StatelessWidget {
  const SubCatShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, top: 8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white),
                  height: Utils.displayHeight(context) * 0.02,
                  width: Utils.displayWidth(context) * 0.2,
                ),
                SizedBox(width: 30),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white),
                  height: Utils.displayHeight(context) * 0.02,
                  width: Utils.displayWidth(context) * 0.2,
                ),
                SizedBox(width: 30),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white),
                  height: Utils.displayHeight(context) * 0.02,
                  width: Utils.displayWidth(context) * 0.2,
                ),
                //  SizedBox(width: 30),
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(3),
                //       color: Colors.white),
                //   height: Utils.displayHeight(context) * 0.02,
                //   width: Utils.displayWidth(context) * 0.05,
                // ),
              ],
            ),
            SizedBox(height: Utils.displayHeight(context) * 0.01),
          ],
        ),
      ),
    );
  }
}
