import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/orderBooker/provider/booker_target_provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';

class HomeSummaryScreen extends StatefulWidget {
  const HomeSummaryScreen({Key key}) : super(key: key);

  @override
  State<HomeSummaryScreen> createState() => _HomeSummaryScreenState();
}

var formatter = NumberFormat('#,##,000.00');

class _HomeSummaryScreenState extends State<HomeSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    final summary = Provider.of<BookerTargetProvider>(context);
    return Scaffold(
      body:  Stack(
        children: [
          Container(
            color: AppColor.base,
            height: Utils.displayHeight(context),
            width: Utils.displayWidth(context),
            child: Column(children: [
              SizedBox(
                height: Utils.displayHeight(context) * 0.12,
              ),
              Text(
                "Target Amount",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: "Tzs  ",
                    style: TextStyle(color: AppColor.bgScreen2, fontSize: 25)),
                TextSpan(
                    text: "560,000",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold)),
              ])),
            ]),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.bgScreen2,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40))),
              height: Utils.displayHeight(context) * 0.6,
              width: Utils.displayWidth(context),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 40.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Home Summary',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    amountTile(
                        context,
                        'Total Sales',
                        '${formatter.format(summary.homeSummary.totalSales?.amount) ?? 0} Tsh',
                        'Order (${summary.homeSummary.totalSales?.orders ?? 0})',
                        Icon(
                          FontAwesomeIcons.dollarSign,
                          color: Color(0xFF525252),
                        )),
                    SizedBox(
                      height: 15.0,
                    ),
                    amountTile(
                        context,
                        'Total Credited',
                        '${formatter.format(summary.homeSummary.totalCredited?.amount) ?? 0} Tsh',
                        'Order (${summary.homeSummary.totalCredited?.orders ?? 0})',
                        Icon(
                          Icons.currency_bitcoin,
                          color: Color(0xFF525252),
                        )),
                    SizedBox(
                      height: 15.0,
                    ),
                    amountTile(
                        context,
                        'Total Amount Credited',
                        '${formatter.format(summary.homeSummary.totalPaid?.amount) ?? 0} Tsh',
                        'Order (${summary.homeSummary.totalPaid?.orders ?? 0})',
                        Icon(
                          FontAwesomeIcons.waveSquare,
                          color: Color(0xFF525252),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget amountTile(BuildContext context, String title, String amount,
      String order, Widget icon) {
    return Container(
      height: Utils.displayHeight(context) * 0.1,
      width: Utils.displayWidth(context),
      decoration: BoxDecoration(
        color: AppColor.bgScreen,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: CircleAvatar(
            radius: 30, backgroundColor: Color(0xFFF3F3F3), child: icon),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF525252)),
        ),
        subtitle: Text(
          order,
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        trailing: Text(
          amount,
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
