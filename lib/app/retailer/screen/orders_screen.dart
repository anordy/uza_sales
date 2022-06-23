import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/card/order_card.dart';
import 'package:intl/intl.dart';
import 'package:uza_sales/app/retailer/provider/order_provider.dart';
import 'package:uza_sales/app/retailer/shimmers/route_shimmers.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var numberFormat = NumberFormat('#,##,000.00');

  ScrollController _ordersController = new ScrollController();
  TabController _tabController;
  SharedPreferences sharedPreferences;
  List<Widget> list = [
    Tab(
      text: "MY ORDERS",
    ),
    Tab(
      text: "ORDER TO APPROVE",
    ),
  ];
  String _status;
  final statusList = ['Pending', 'Paid'];

  bool changeLanguage = false;
  String currentLocale = "";
  @override
  void initState() {
    super.initState();
    final _orderProvider = Provider.of<OrderProvider>(context, listen: false)
        .fetchOrders('PENDING');
  }

  @override
  Widget build(BuildContext context) {
    final _orderProvider = Provider.of<OrderProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.bgScreen2,
        // appBar: AppBar(
        //   title: Text("Order History"),
        // ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverStickyHeader(
                header: Container(
                  height: 140,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context).orders.toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF292C34),
                                  fontSize: 16),
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => filterOrderStatus());
                              },
                              child: Container(
                                  height: 30,
                                  width: 83,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: Color(0xFFC7D3DD))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.filter_alt_outlined,
                                        color: Color(0xFF000000),
                                        size: 18,
                                      ),
                                      Text(
                                        AppLocalizations.of(context).filter,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 14),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xFFD9D0E3)),
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: TabBar(
                              controller: _tabController,
                              indicator: BoxDecoration(
                                  color: AppColor.base,
                                  borderRadius: BorderRadius.circular(50)),
                              // indicatorColor: AppColor.base,
                              labelColor: Colors.white,
                              unselectedLabelColor: Color(0xFF1F212C),
                              tabs: list,
                              onTap: (index) {
                                // Tab index when user select it, it start from zero
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                    height: Utils.displayHeight(context),
                    color: Colors.transparent,
                    child: TabBarView(controller: _tabController, children: [
                      myOrders(),
                      orderPlaced(),
                    ]),
                  ),
                ])),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget myOrders() {
    final _orderProvider = Provider.of<OrderProvider>(context);
    return Container(
        height: Utils.displayHeight(context),
        // color: Colors.green,
        child: _orderProvider.isOrderLoading
            ? RouteShimmers()
            : _orderProvider.availableOrders.length <= 0 ||
                    _orderProvider.availableOrders == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      CircleAvatar(
                        backgroundColor: AppColor.bgScreen,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.storefront_outlined,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Wow, Such Empty",
                              style:
                                  TextStyle(fontSize: 10, color: AppColor.text),
                            ),
                          ],
                        ),
                        radius: 50,
                      ),
                    ],
                  )
                : ListView.builder(
                    //  controller: _ordersController,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: _orderProvider.availableOrders.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 10.0, top: 10),
                          child: InkWell(
                              onTap: () {},
                              child: OrderCard(
                                  order:
                                      _orderProvider.availableOrders[index])));
                    }));
  }

// ===== ORDER PLACED  =======
  Widget orderPlaced() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
        ),
        CircleAvatar(
          backgroundColor: AppColor.bgScreen,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.storefront_outlined,
                color: Colors.grey,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Wow, Such Empty",
                style: TextStyle(fontSize: 10, color: AppColor.text),
              ),
            ],
          ),
          radius: 50,
        ),
      ],
    ));
  }

  // dismiss widget
  Widget makeDismisible({@required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

  // filter bottom sheet
  Widget filterOrderStatus() {
    final orderProvider = Provider.of<OrderProvider>(context);
    return makeDismisible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.3,
        maxChildSize: 0.3,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 10),
            child: ListView(
              controller: controller,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 25.0),
                Text(
                  "Filter by Status",
                  style: TextStyle(color: Color(0xFF40403F)),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    width: Utils.displayWidth(context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFFC7D3DD))),
                    child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              icon: Icon(FontAwesomeIcons.chevronDown,
                                  color: Colors.black, size: 16),
                              value: _status,
                              hint: Text("Filter By  Status"),
                              isExpanded: true,
                              onChanged: (String newValue) {
                                setState(() {
                                  _status = newValue;
                                  if (_status == "Pending") {
                                    orderProvider.fetchOrders("PENDING");
                                    Navigator.of(context).pop();
                                  } else if (_status == "Paid") {
                                    orderProvider.fetchOrders("PAID");
                                    Navigator.of(context).pop();
                                  } else {
                                    orderProvider.fetchOrders('PENDING');
                                    Navigator.of(context).pop();
                                  }
                                  // if(_status = )
                                  // print(_status);
                                });
                              },
                              items: statusList.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item),
                                  value: item,
                                );
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 16),
                            )))),
                SizedBox(height: 25.0),
                Center(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0)),
                    color: Theme.of(context).primaryColor,
                    height: 50,
                    minWidth: Utils.displayWidth(context) * 0.4,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Apply'.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
