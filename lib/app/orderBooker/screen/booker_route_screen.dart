import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:jiffy/jiffy.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/orderBooker/card/stock_product_card.dart';
import 'package:uza_sales/app/orderBooker/orders/booker_category_order.dart';
import 'package:uza_sales/app/orderBooker/pages/booker_create_shop.dart';
import 'package:uza_sales/app/orderBooker/provider/stock_availability_provider.dart';
import 'package:uza_sales/app/orderBooker/provider/visit_provider.dart';
import 'package:uza_sales/app/retailer/shimmers/route_shimmers.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:uza_sales/app/sales/card/routes_card.dart';
import 'package:uza_sales/app/sales/map/bymap_list.dart';
import 'package:uza_sales/app/sales/pages/sales_create_shop.dart';
import 'package:uza_sales/app/sales/provider/route_provider.dart';
import 'package:uza_sales/app/sales/screen/sales_otp_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../sales/pages/product_quantity.dart';

class BookerMyRouteScreen extends StatefulWidget {
  const BookerMyRouteScreen({Key key}) : super(key: key);

  @override
  _BookerMyRouteScreenState createState() => _BookerMyRouteScreenState();
}

class _BookerMyRouteScreenState extends State<BookerMyRouteScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _dateController = TextEditingController();
  TabController _tabController;
  int _selectedIndex = 0;
  List<Widget> list = [
    Tab(
      text: "By List",
    ),
    // Tab(
    //   text: "By Map",
    // ),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: list.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
      _dateController.text = Jiffy(DateTime.now()).format('yyyy-MM-dd');
      // Provider.of<RouteProvider>(context,listen: false).fetchRoutes(date: _dateController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _routeProvider = Provider.of<RouteProvider>(context);
    // final category = Provider.of<VisitProvider>(context);

    return Scaffold(
        backgroundColor: AppColor.bgScreen2,
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverStickyHeader(
                header: Container(
                  color: AppColor.bgScreen2,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
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
                                AppLocalizations.of(context).my_routes,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.title,
                                    fontWeight: FontWeight.w600),
                              ),
                              // SizedBox(
                              //   width: 100,
                              // ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  pushNewScreen(
                                    context,
                                    screen: OtpScreen(),
                                    withNavBar:
                                        true, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                          Border.all(color: AppColor.border)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          Icons.shopping_bag,
                                          size: 14,
                                          color: AppColor.preBase,
                                        ),
                                        // SizedBox(
                                        //   height: 5.0,
                                        // ),
                                        Text(
                                          "OTP",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppColor.preBase,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: Utils.displayWidth(context) * 0.68,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6)),
                                child: TextFormField(
                                  onChanged: (value) {
                                    // print(value);
                                    _routeProvider.searchRoute(value);
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.search,
                                        size: 20,
                                        color: Color(0xFF9B9C9B),
                                      ),
                                      hintText: "Search",
                                      hintStyle:
                                          TextStyle(color: Color(0xFF9B9C9B)),
                                      border: InputBorder.none),
                                ),
                              ),
                              // SizedBox(
                              //   width: 5,
                              // ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  pushNewScreen(
                                    context,
                                    screen: BookerCreateShop(),
                                    withNavBar:
                                        true, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: AppColor.preBase,
                                      borderRadius: BorderRadius.circular(9)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context).add,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: Utils.displayWidth(context),
                            decoration: BoxDecoration(
                                color: AppColor.bgScreen2,
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2, color: Color(0xFFE5E6E5)))),
                            child: TabBar(
                              controller: _tabController,
                              indicatorColor: AppColor.preBase,
                              labelColor: AppColor.preBase,
                              unselectedLabelColor: Color(0xFF292C34),
                              tabs: list,
                              onTap: (index) {
                                print("Tabs $index");
                                // Tab index when user select it, it start from zero
                                // _tabController.index = _tabController.previousIndex;
                                // signInDialog(context);
                              },
                            ),
                          )
                        ],
                      )),
                ),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                        controller: _tabController, children: [byList()]),
                  )
                ])),
              ),
            ],
          ),
        ));
  }

  // Widget byList() {
  //  final _routeProvider = Provider.of<RouteProvider>(context);
  //     //  final category = Provider.of<StockAvailabilityProvider>(context);

  //   return _routeProvider.isRouteLoading  ?  _routeProvider.availableRoute.length <= 0 ? RouteShimmers() :Center(child: Text("No Routes available",style: TextStyle(color: Colors.black),),): ListView.builder(
  //       shrinkWrap: false,
  //       physics: NeverScrollableScrollPhysics(),
  //       itemCount: _routeProvider?.availableRoute?.length ?? 0,
  //       itemBuilder: (context, index) {
  //         return Column(
  //           children: _routeProvider.availableRoute[index].stores.map((store) {
  //             var _index = _routeProvider.availableRoute[index].stores.indexOf(store);
  //             _routeProvider.setSelectedRoute(index,_index);
  //                return   MyRoutesCard(stores: _routeProvider.availableRoute[index].stores[_index],routes: _routeProvider.availableRoute[index],);
  //           }).toList(),
  //         );
  //         //  MyRoutesCard(routes: _routeProvider.availableRoute[index],);
  //       }) ;
  // }
  //   }

  Widget byList() {
    final category = Provider.of<CategoryBookerProvider>(context);
    return ListView.builder(
        itemCount: category.availableCategory.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                pushNewScreen(
                  context,
                  screen: BookerCategoryOrder(),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: ProductStockCard(
                  category: category.availableCategory[index],
                ),
              ));
        });
  }
}
