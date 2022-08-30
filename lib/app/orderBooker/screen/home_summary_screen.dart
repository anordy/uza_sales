import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/orderBooker/provider/booker_order_provider.dart';
import 'package:uza_sales/app/orderBooker/provider/booker_target_provider.dart';
import 'package:uza_sales/app/orderBooker/widget/booker_daily_target.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:uza_sales/app/orderBooker/model/target_pilot_model.dart';


class HomeSummaryScreen extends StatefulWidget {
  const HomeSummaryScreen({Key key}) : super(key: key);

  @override
  State<HomeSummaryScreen> createState() => _HomeSummaryScreenState();
}

TextEditingController _month = TextEditingController();
String fromStatus = "Today";
TextEditingController _nowController = TextEditingController();
TextEditingController _searchController = TextEditingController();
TextEditingController _today = TextEditingController();


var formatter = NumberFormat('#,##,000.00');

class _HomeSummaryScreenState extends State<HomeSummaryScreen> {
  void initState() {
    super.initState();
    _month.text = Jiffy(DateTime.now()).MMMM;
    print("=========   this month ${_month.text}  ");
  }

  @override
  Widget build(BuildContext context) {
    final summary = Provider.of<BookerTargetProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColor.base,
            height: Utils.displayHeight(context),
            width: Utils.displayWidth(context),
            child: Column(children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 220.0),
                child: InkWell(
                  onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => fromToBuilder());
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColor.border)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment:
                        // MainAxisAlignment.spaceBetween,
                        children: [
                          // Icon(
                          //   Icons.calendar_today,
                          //   size: 14,
                          //   color: AppColor.preBase,
                          // ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "$fromStatus",
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColor.preBase,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 25,),
                            Icon(
                            FontAwesomeIcons.chevronDown,
                           color: AppColor.preBase,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Utils.displayHeight(context) * 0.08,
              ),
              Text(
                "Daily Target Amount",
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
                          
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Distrubuter',
                            style: TextStyle(
                                color: AppColor.text,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          RichText(
                                text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "Target",
                                    style: TextStyle(
                                        color: AppColor.text, fontSize: 16)),
                                TextSpan(
                                    text: '(Tzs)',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 103, 103, 103),
                                        fontSize: 14)),
                              ])),
                           RichText(
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "Archived",
                                style: TextStyle(
                                    color: AppColor.text, fontSize: 16)),
                            TextSpan(
                                text: '(Tzs)',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 103, 103, 103),
                                    fontSize: 14)),
                          ])),
                        
                        ],
                      ),
                    ),
                    
                    
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                        // color: Colors.lightBlue,
                        height: Utils.displayHeight(context) * 0.45,
                        child: ListView.builder(
                            itemCount: targetPilots.length,
                            itemBuilder: (context, i) {
                              return  BookerDailyTarget(pilots: targetPilots[i],);
                            })),
                    // amountTile(
                    //     context,
                    //     'Total Sales',
                    //     '${formatter.format(summary.homeSummary.totalSales?.amount) ?? 0} Tsh',
                    //     'Order (${summary.homeSummary.totalSales?.orders ?? 0})',
                    //     Icon(
                    //       FontAwesomeIcons.dollarSign,
                    //       color: Color(0xFF525252),
                    //     )),
                    // SizedBox(
                    //   height: 15.0,
                    // ),
                    // amountTile(
                    //     context,
                    //     'Total Credited',
                    //     '${formatter.format(summary.homeSummary.totalCredited?.amount) ?? 0} Tsh',
                    //     'Order (${summary.homeSummary.totalCredited?.orders ?? 0})',
                    //     Icon(
                    //       Icons.currency_bitcoin,
                    //       color: Color(0xFF525252),
                    //     )),
                    // SizedBox(
                    //   height: 15.0,
                    // ),
                    // amountTile(
                    //     context,
                    //     'Total Amount Credited',
                    //     '${formatter.format(summary.homeSummary.totalPaid?.amount) ?? 0} Tsh',
                    //     'Order (${summary.homeSummary.totalPaid?.orders ?? 0})',
                    //     Icon(
                    //       FontAwesomeIcons.waveSquare,
                    //       color: Color(0xFF525252),
                    //     ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget makeDismisible({@required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
    // filter bottom sheet
  Widget fromToBuilder() {
    return makeDismisible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.4,
        maxChildSize: 0.4,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 50),
            child: ListView(
              controller: controller,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    print("Past 30 Days");
                    setState(() {
                      fromStatus = "Past 30 Days";
                      var last30Days =
                          Jiffy().subtract(months: 1).format('yyyy-MM-dd');
                      print(last30Days);

                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Past 30 days",
                    style: TextStyle(color: Color(0xFF31373B)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    print("Past 7 Days");
                    setState(() {
                      fromStatus = "Past 7 Days";
                      var last7Days =
                          Jiffy().subtract(weeks: 1).format('yyyy-MM-dd');
                      print(last7Days);
                      
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Past 7 Days",
                    style: TextStyle(color: Color(0xFF31373B)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    print("yesterday");
                    setState(() {
                      fromStatus = "yesterday";
                      var yesterday =
                          Jiffy().subtract(days: 1).format('yyyy-MM-dd');
                      print(yesterday);
                
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "yesterday",
                    style: TextStyle(color: Color(0xFF31373B)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    print("Today");
                    setState(() {
                      fromStatus = "Today";
                      _today.text = Jiffy(DateTime.now()).format('yyyy-MM-dd');
                      print(_today.text);
                    
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Today",
                    style: TextStyle(color: Color(0xFF31373B)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }


// listtile for amount
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
