import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/orderBooker/provider/booker_order_provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/loading.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:uza_sales/app/sales/card/order_card.dart';
import 'package:uza_sales/app/sales/provider/salesOrder_provider.dart';

class OrderBookerHistory extends StatefulWidget {
  const OrderBookerHistory({Key key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderBookerHistory> {
  String dateTime;
  DateTime selectedDate = DateTime.now();
  String fromStatus = "Today";
  TextEditingController _nowController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  TextEditingController _today = TextEditingController();

  var numberFormat = NumberFormat('#,##,000.00');

  String _status;
  // This function is called whenever the text field changes

  @override
  void initState() {
    super.initState();
    // _today.text = DateFormat.yMMMd().format(DateTime.now());
    _today.text = Jiffy(DateTime.now()).format('yyyy-MM-dd');

    final _orderProvider =
        Provider.of<BookerOrderProvider>(context, listen: false);
    _orderProvider.fetchOrders(startDate: _today.text, endDate: _today.text);
  }

  @override
  Widget build(BuildContext context) {
    final _orderProvider = Provider.of<BookerOrderProvider>(context);
    return Scaffold(
        backgroundColor: AppColor.bgScreen2,
        body: SafeArea(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    color: AppColor.bgScreen2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            // SizedBox(width: 2,),
                            Text(
                              "Order History".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.title,
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            // SizedBox(width: 100,),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF7F8F9),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(Icons.refresh),
                            ),
                            // IconButton(
                            //     icon: Icon(Icons.refresh),
                            //     onPressed: () {
                            //       Navigator.of(context).pop();
                            //     }),
                          ],
                        ),
                      ],
                    )),
                SizedBox(
                  height: 15.0,
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => fromToBuilder());
                  },
                  child: Container(
                    height: 45,
                    width: Utils.displayWidth(context),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFC7D3DD)),
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("$fromStatus"),
                          Icon(
                            FontAwesomeIcons.chevronDown,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        color: AppColor.preBase,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColor.border)),
                    child: Center(
                      child: Text("Print Z-Report",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    )),
                SizedBox(
                  height: 20.0,
                ),
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "Total Orders: ",
                      style: TextStyle(color: AppColor.text, fontSize: 16)),
                  _orderProvider.isOrderLoading
                      ? TextSpan(
                          text: "0",
                          style: TextStyle(color: AppColor.text, fontSize: 16))
                      : TextSpan(
                          text:
                              "${_orderProvider?.availableOrder?.totalOrders ?? 0}",
                          style: TextStyle(color: AppColor.text, fontSize: 16)),
                ])),
                SizedBox(
                  height: 10.0,
                ),
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "Total Sales: ",
                      style: TextStyle(color: AppColor.text, fontSize: 16)),
                  _orderProvider.isOrderLoading
                      ? TextSpan(
                          text: "0",
                          style: TextStyle(color: AppColor.text, fontSize: 16))
                      : TextSpan(
                          text:
                              "${numberFormat.format(_orderProvider?.availableOrder?.totalSales ?? 0)} Tshs",
                          style: TextStyle(color: AppColor.text, fontSize: 16)),
                ])),
                SizedBox(
                  height: 10.0,
                ),
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "Location Visited: ",
                      style: TextStyle(color: AppColor.text, fontSize: 16)),
                  _orderProvider.isOrderLoading
                      ? TextSpan(
                          text: "0",
                          style: TextStyle(color: AppColor.text, fontSize: 16))
                      : TextSpan(
                          text:
                              "${_orderProvider?.availableOrder?.locationVisited ?? 0} ",
                          style: TextStyle(color: AppColor.text, fontSize: 16)),
                ])),
                SizedBox(
                  height: 15.0,
                ),
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "Shops Added: ",
                      style: TextStyle(color: AppColor.text, fontSize: 16)),
                  TextSpan(
                      text: "0",
                      style: TextStyle(color: AppColor.text, fontSize: 16)),
                ])),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  height: 40,
                  width: Utils.displayWidth(context),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  child: TextFormField(
                    // controller: _searchController,
                    onChanged: (value) {
                      _orderProvider.searchOrder(value);
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: Color(0xFF9B9C9B),
                        ),
                        hintText: "Search",
                        hintStyle: TextStyle(color: Color(0xFF9B9C9B)),
                        border: InputBorder.none),
                  ),
                ),
                // SizedBox(
                //   height: 20.0,
                // ),
                Spacer(),
                // _orderProvider.availableOrder.orders.length <= 0 ?  Text("NO  Activities"):
                Container(
                  // color: Colors.green,
                  height: Utils.displayHeight(context) * 0.35,
                  child: _orderProvider.isOrderLoading
                      ? Loading()
                      : _orderProvider.foundOrder.length <= 0
                          ? Center(child: Text("No Orders  Yet"))
                          : ListView.builder(
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  _orderProvider?.foundOrder?.length ?? 0,
                              itemBuilder: (context, index) {
                                return OrderCard(
                                  order: _orderProvider?.foundOrder[index],
                                );
                              }),
                ),
                SizedBox(
                  height: 3,
                )
              ],
            ),
          ),
        )));
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
    final _orderProv = Provider.of<BookerOrderProvider>(context);
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
                      _orderProv.fetchOrders(
                          startDate: last30Days, endDate: _today.text);
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
                      _orderProv.fetchOrders(
                          startDate: last7Days, endDate: _today.text);
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
                      _orderProv.fetchOrders(
                          startDate: yesterday, endDate: _today.text);
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
                      _orderProv.fetchOrders(
                          startDate: _today.text, endDate: _today.text);
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

  // select date
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppColor.preBase,
                onPrimary: Colors.white,
                surface: AppColor.preBase,
                onSurface: AppColor.text,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        },
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _nowController.text = DateFormat.yMMMd().format(selectedDate);
      });
  }
}
