

import 'package:flutter/material.dart';
import 'package:uza_sales/app/orderBooker/model/target_pilot_model.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';

class BookerDailyTarget extends StatelessWidget {
  final TargetPilot pilots;
  const BookerDailyTarget({Key key,@required this.pilots}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
        // color: Colors.green,
        child: Column(
          children: [
            Row(children: [
              SizedBox(
                width: 10,
              ),
              Container(
                height: 40,
                width: Utils.displayWidth(context) * 0.28,
                // color: Colors.tealAccent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 12),
                  child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: '${pilots.distrubuterName}',
                          style:
                              TextStyle(color: AppColor.text, fontSize: 14))),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 40,
                width: Utils.displayWidth(context) * 0.26,
                // color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 10),
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    // maxLines: 2,
                    text: TextSpan(
                        text: '${pilots.targetAmount}',
                        style: TextStyle(color: AppColor.text, fontSize: 16)),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 40,
                width: Utils.displayWidth(context) * 0.26,
                // color: Colors.tealAccent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                  child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: '${pilots.archivedTarget}',
                          style:
                              TextStyle(color: AppColor.text, fontSize: 14))),
                ),
              )
            ]),
            Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
