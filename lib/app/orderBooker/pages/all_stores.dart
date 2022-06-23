// import 'package:flutter/material.dart';
// import 'package:flutter_sticky_header/flutter_sticky_header.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:provider/provider.dart';
// import 'package:uza_sales/app/retailer/widget/colors.dart';
// import 'package:uza_sales/app/retailer/widget/utils.dart';
// import 'package:uza_sales/app/sales/card/routes_card.dart';
// import 'package:uza_sales/app/sales/pages/sales_create_shop.dart';
// import 'package:uza_sales/app/sales/provider/route_provider.dart';

// class AllStores extends StatefulWidget {
//   const AllStores({Key key}) : super(key: key);

//   @override
//   _AllStoresState createState() => _AllStoresState();
// }

// class _AllStoresState extends State<AllStores>
//     with SingleTickerProviderStateMixin {
//   TabController _tabController;
//   int _selectedIndex = 0;
//   List<Widget> list = [
//     Tab(
//       text: "My Route",
//     ),
//     Tab(
//       text: "All Locations",
//     ),
//   ];
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: list.length, vsync: this);

//     _tabController.addListener(() {
//       setState(() {
//         _selectedIndex = _tabController.index;
//       });
//       print("Selected Index: " + _tabController.index.toString());
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _routeProvider = Provider.of<RouteProvider>(context);
//     return Scaffold(
//         backgroundColor: AppColor.bgScreen2,
//         body: SafeArea(
//           child: CustomScrollView(
//             slivers: <Widget>[
//               SliverStickyHeader(
//                 header: Container(
//                   color: AppColor.bgScreen2,
//                   child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 15.0, vertical: 10),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               IconButton(
//                                   icon: Icon(Icons.arrow_back_ios),
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   }),
//                               // SizedBox(width: 2,),
//                               Text(
//                                 "All Stores",
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.title,
//                                     fontWeight: FontWeight.w600),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: [
//                               Container(
//                                 height: 40,
//                                 width: Utils.displayWidth(context) * 0.68,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(6)),
//                                 child: TextFormField(
//                                   decoration: InputDecoration(
//                                       prefixIcon: Icon(
//                                         Icons.search,
//                                         size: 20,
//                                         color: Color(0xFF9B9C9B),
//                                       ),
//                                       hintText: "Search",
//                                       hintStyle:
//                                           TextStyle(color: Color(0xFF9B9C9B)),
//                                       border: InputBorder.none),
//                                 ),
//                               ),
//                               // SizedBox(
//                               //   width: 5,
//                               // ),
//                               Spacer(),
//                               InkWell(
//                                 onTap: () {
//                                   pushNewScreen(
//                                     context,
//                                     screen: SalesCreateShop(),
//                                     withNavBar:
//                                         true, // OPTIONAL VALUE. True by default.
//                                     pageTransitionAnimation:
//                                         PageTransitionAnimation.cupertino,
//                                   );
//                                 },
//                                 child: Container(
//                                   height: 40,
//                                   width: 80,
//                                   decoration: BoxDecoration(
//                                       color: AppColor.preBase,
//                                       borderRadius: BorderRadius.circular(9)),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "Add",
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                       Icon(
//                                         Icons.add,
//                                         color: Colors.white,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
                          
//                           SizedBox(
//                             height: 35,
//                           ),
//                           Container(
//                             width: Utils.displayWidth(context),
//                             decoration: BoxDecoration(
//                                 color: AppColor.bgScreen2,
//                                 border: Border(
//                                     bottom: BorderSide(
//                                         width: 2, color: Color(0xFFE5E6E5)))),
//                             child: TabBar(
//                               controller: _tabController,
//                               indicatorColor: AppColor.preBase,
//                               labelColor: AppColor.preBase,
//                               unselectedLabelColor: Color(0xFF9B9C9B),
//                               tabs: list,
//                               onTap: (index) {
//                                 print("Tabs $index");
//                                 // Tab index when user select it, it start from zero
//                                 // _tabController.index = _tabController.previousIndex;
//                                 // signInDialog(context);
//                               },
//                             ),
//                           )
//                         ],
//                       )),
//                 ),
//                 sliver: SliverList(
//                     delegate: SliverChildListDelegate([
//                   Container(
//                     height: Utils.displayHeight(context),
//                     child: TabBarView(
//                         controller: _tabController,
//                         children: [myRoute(), allLocations()]),
//                   )
//                 ])),
//               ),
//             ],
//           ),
//         ));
//   }

//   Widget myRoute() {
//         final _routeProvider = Provider.of<RouteProvider>(context);
//     return ListView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: _routeProvider?.availableRoute?.length ?? 0,
//         itemBuilder: (context, index) {
//           return MyRoutesCard(stores: _routeProvider.availableRoute.stores[index],);
//         });
//   }

//   Widget allLocations() {
//     return Container(
//       child: Center(
//         child: Text("All Locations"),
//       ),
//     );
//   }
// }
