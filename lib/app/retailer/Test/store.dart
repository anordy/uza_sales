// import 'dart:async';
// import 'dart:ui';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sticky_header/flutter_sticky_header.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:uza_sales/app/widget/colors.dart';
// import 'package:uza_sales/app/widget/utils.dart';

// class CreateShop extends StatefulWidget {
//   @override
//   _CreateShop createState() => _CreateShop();
// }

// class _CreateShop extends State<CreateShop>
//     with SingleTickerProviderStateMixin {
//   TabController _tabController;
//   int _selectedIndex = 0;

//   List<Widget> list = [
//     //Tab(icon: Icon(Icons.card_travel)),
//     //Tab(icon: Icon(Icons.add_shopping_cart)),
//     Tab(
//       text: "STORE",
//     ),
//     Tab(
//       text: "OWNER",
//     ),
//     Tab(
//       text: "STORE KEEPER",
//     ),
//   ];

//   int _value;

//   @override
//   void initState() {
//     super.initState();
//     // Create TabController for getting the index of current tab
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
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverStickyHeader(
//             header: Padding(
//               padding:
//                   const EdgeInsets.only(left: 15.0, right: 15.0, top: 35.0),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Create Shop".toUpperCase(),
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF292C34)),
//                       ),
//                       Container(
//                         height: 40,
//                         width: 90,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Color(0xFFC7D3DD))),
//                         child: Center(
//                             child: Text(
//                           "Next".toUpperCase(),
//                           style: TextStyle(color: AppColor.base),
//                         )),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 45,
//                   ),
//                   Container(
//                       width: Utils.displayWidth(context),
//                       color: Color(0xFFFFFFFF),
//                       child: 
//                       TabBar(
//                         labelColor: AppColor.base,
//                         indicatorColor: AppColor.base,
//                         unselectedLabelColor: Color(0xFF9B9C9B),
//                         onTap: (index) {
//                           // Tab index when user select it, it start from zero
//                         },
//                         tabs: list,
//                         controller: _tabController,
//                       ))
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   // download course
//   downloadCourseDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (_) => Material(
//         type: MaterialType.transparency,
//         child: Center(
//           // Aligns the container to center
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 height: 65,
//                 width: 65,
//                 decoration: BoxDecoration(
//                     color: Color(0xFF2F95C4),
//                     borderRadius: BorderRadius.circular(50)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Image.asset(
//                     'assets/images/loader.png',
//                     // width: 50.0,
//                     //height: 240.0,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 25),
//               Text(
//                 'Plese wait you',
//                 style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),
//               ),
//               Text(
//                 'content is downloading...',
//                 style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget all() {
//     return Container(
//       decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
//       height: Utils.displayHeight(context),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 30.0, top: 30.0, right: 30.0),
//         child: Column(
//           children: [
//             Container(
//                 height: 60,
//                 width: Utils.displayWidth(context),
//                 decoration: BoxDecoration(
//                     color: Color(0xFF232323),
//                     borderRadius: BorderRadius.circular(35)),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Airtel Mobile  Money',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFFFFFFFF))),
//                           Text(
//                             'sat 06, June 24 at 21:29',
//                             style: TextStyle(
//                                 color: Color(0xFF828282), fontSize: 12),
//                           ),
//                         ],
//                       ),
//                       //SizedBox(width: 50),
//                       Spacer(flex: 1),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 15.0),
//                         child: RichText(
//                             text: TextSpan(children: <TextSpan>[
//                           TextSpan(
//                               text: 'Tsh',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFF828282))),
//                           TextSpan(
//                               text: ' +75,000',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFFE15062))),
//                         ])),
//                       ),
//                       SizedBox(width: 20),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 15.0),
//                         child: Icon(
//                           FontAwesomeIcons.expandAlt,
//                           color: Color(0xFFE15062),
//                           size: 15,
//                         ),
//                       )
//                     ],
//                   ),
//                 )),
//             SizedBox(height: 10),
//             Container(
//                 height: 60,
//                 width: Utils.displayWidth(context),
//                 decoration: BoxDecoration(
//                     color: Color(0xFF232323),
//                     borderRadius: BorderRadius.circular(35)),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Airtel Mobile  Money',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFFFFFFFF))),
//                           Text(
//                             'sat 06, June 24 at 21:29',
//                             style: TextStyle(
//                                 color: Color(0xFF828282), fontSize: 12),
//                           ),
//                         ],
//                       ),
//                       //SizedBox(width: 50),
//                       Spacer(flex: 1),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 15.0),
//                         child: RichText(
//                             text: TextSpan(children: <TextSpan>[
//                           TextSpan(
//                               text: 'Tsh',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFF828282))),
//                           TextSpan(
//                               text: ' +75,000',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFFE15062))),
//                         ])),
//                       ),
//                       SizedBox(width: 20),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 15.0),
//                         child: Icon(
//                           FontAwesomeIcons.expandAlt,
//                           color: Color(0xFFE15062),
//                           size: 15,
//                         ),
//                       )
//                     ],
//                   ),
//                 )),
//             SizedBox(height: 10),
//             Container(
//                 height: 60,
//                 width: Utils.displayWidth(context),
//                 decoration: BoxDecoration(
//                     color: Color(0xFF232323),
//                     borderRadius: BorderRadius.circular(35)),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Airtel Mobile  Money',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFFFFFFFF))),
//                           Text(
//                             'sat 06, June 24 at 21:29',
//                             style: TextStyle(
//                                 color: Color(0xFF828282), fontSize: 12),
//                           ),
//                         ],
//                       ),
//                       //SizedBox(width: 50),
//                       Spacer(flex: 1),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 15.0),
//                         child: RichText(
//                             text: TextSpan(children: <TextSpan>[
//                           TextSpan(
//                               text: 'Tsh',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFF828282))),
//                           TextSpan(
//                               text: ' +75,000',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFF1DCE1A))),
//                         ])),
//                       ),
//                       SizedBox(width: 20),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 15.0),
//                         child: Icon(
//                           FontAwesomeIcons.expandAlt,
//                           color: Color(0xFF1DCE1A),
//                           size: 15,
//                         ),
//                       )
//                     ],
//                   ),
//                 )),
//             SizedBox(height: 10),
//             Container(
//                 height: 60,
//                 width: Utils.displayWidth(context),
//                 decoration: BoxDecoration(
//                     color: Color(0xFF232323),
//                     borderRadius: BorderRadius.circular(35)),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Airtel Mobile  Money',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFFFFFFFF))),
//                           Text(
//                             'sat 06, June 24 at 21:29',
//                             style: TextStyle(
//                                 color: Color(0xFF828282), fontSize: 12),
//                           ),
//                         ],
//                       ),
//                       //SizedBox(width: 50),
//                       Spacer(flex: 1),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 15.0),
//                         child: RichText(
//                             text: TextSpan(children: <TextSpan>[
//                           TextSpan(
//                               text: 'Tsh',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFF828282))),
//                           TextSpan(
//                               text: ' +75,000',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFFE15062))),
//                         ])),
//                       ),
//                       SizedBox(width: 20),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 15.0),
//                         child: Icon(
//                           FontAwesomeIcons.expandAlt,
//                           color: Color(0xFFE15062),
//                           size: 15,
//                         ),
//                       )
//                     ],
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget investiment() {
//     return Container(
//       decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
//       height: Utils.displayHeight(context),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
//         child: Column(
//           children: [
//             Container(
//                 height: 60,
//                 width: Utils.displayWidth(context),
//                 decoration: BoxDecoration(
//                     color: Color(0xFF232323),
//                     borderRadius: BorderRadius.circular(35)),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Airtel Mobile  Money',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFFFFFFFF))),
//                           Text(
//                             'sat 06, June 24 at 21:29',
//                             style: TextStyle(
//                                 color: Color(0xFF828282), fontSize: 12),
//                           ),
//                         ],
//                       ),
//                       SizedBox(width: 50),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 15.0),
//                         child: RichText(
//                             text: TextSpan(children: <TextSpan>[
//                           TextSpan(
//                               text: 'Tsh',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFF828282))),
//                           TextSpan(
//                               text: ' +75,000',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFFE15062))),
//                         ])),
//                       ),
//                       SizedBox(width: 20),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 15.0),
//                         child: Icon(
//                           FontAwesomeIcons.expandAlt,
//                           color: Color(0xFFE15062),
//                           size: 15,
//                         ),
//                       )
//                     ],
//                   ),
//                 )),
//             SizedBox(height: 10),
//             Container(
//                 height: 60,
//                 width: Utils.displayWidth(context),
//                 decoration: BoxDecoration(
//                     color: Color(0xFF232323),
//                     borderRadius: BorderRadius.circular(35)),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Airtel Mobile  Money',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFFFFFFFF))),
//                           Text(
//                             'sat 06, June 24 at 21:29',
//                             style: TextStyle(
//                                 color: Color(0xFF828282), fontSize: 12),
//                           ),
//                         ],
//                       ),
//                       SizedBox(width: 50),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 15.0),
//                         child: RichText(
//                             text: TextSpan(children: <TextSpan>[
//                           TextSpan(
//                               text: 'Tsh',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFF828282))),
//                           TextSpan(
//                               text: ' +75,000',
//                               style: TextStyle(
//                                   fontSize: 12, color: Color(0xFFE15062))),
//                         ])),
//                       ),
//                       SizedBox(width: 20),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 15.0),
//                         child: Icon(
//                           FontAwesomeIcons.expandAlt,
//                           color: Color(0xFFE15062),
//                           size: 15,
//                         ),
//                       )
//                     ],
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget planReturn() {
//     return Container(
//       decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
//       height: Utils.displayHeight(context),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             '🤙🏼',
//             style: TextStyle(fontSize: 30),
//           ),
//           SizedBox(height: 15),
//           Text(
//             'chill!',
//             style: TextStyle(color: Color(0xFFE5E5E5), fontSize: 15),
//           ),
//           SizedBox(height: 30),
//           Text(
//             'Your next Return is',
//             style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13),
//           ),
//           Text(
//             'about 12 Days to come',
//             style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13),
//           )
//         ],
//       ),
//     );
//   }
// }
