// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:uza_sales/app/retailer/widget/colors.dart';
// // import 'package:syncfusion_flutter_charts/charts.dart' hide LabelPlacement;
// import 'package:syncfusion_flutter_sliders/sliders.dart';
// import 'package:uza_sales/app/sales/items/target_items.dart';

// class MyTargetScreen extends StatefulWidget {
//   const MyTargetScreen({Key key}) : super(key: key);

//   @override
//   _MyTargetScreenState createState() => _MyTargetScreenState();
// }

// class _MyTargetScreenState extends State<MyTargetScreen> {
//   double _value = 25;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColor.bgScreen2,
//         body: SafeArea(
//           child: Container(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
//               child: Column(
//                 children: [
//                   Container(
//                     color: AppColor.bgScreen2,
//                     child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 IconButton(
//                                     icon: Icon(Icons.arrow_back_ios),
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     }),
//                                 // SizedBox(width: 2,),
//                                 Text(
//                                   "My Target",
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       color: AppColor.title,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                                 // SizedBox(
//                                 //   width: 80,
//                                 // ),
//                                 Spacer(),
//                                 Container(
//                                   height: 40,
//                                   width: 120,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(5),
//                                       border: Border.all(color: AppColor.border)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Icon(
//                                           Icons.calendar_today,
//                                           size: 14,
//                                           color: AppColor.preBase,
//                                         ),
//                                         SizedBox(
//                                           height: 5.0,
//                                         ),
//                                         Text(
//                                           "This month",
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               color: AppColor.preBase,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ],
//                         )
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Text(
//                     "Tsh 10,230,000",
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: AppColor.title,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   SfSlider(
//                     min: 0,
//                     max: 100,
//                     value: _value,
//                     thumbIcon: Text(
//                       "$_value %",
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                     //  interval: 20,
//                     showTicks: false,
                    
//                     activeColor: AppColor.preBase,
//                     inactiveColor: Colors.white,
//                     showLabels: false,
//                     enableTooltip: true,
//                     minorTicksPerInterval: 1,
//                     onChanged: (dynamic value) {
//                       setState(() {
//                         _value = value;
//                       });
//                     },
//                   ),
//                   SizedBox(height: 20,),
//                   Text(
//                     "Tsh 4,120,000 / Tsh 10,230,000",
//                     style: TextStyle(
//                         fontSize: 14,
//                         color: AppColor.title,
//                         ),
//                   ),
//                   SizedBox(height: 20.0,),
//                    Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 50.0, horizontal: 15),
//                       child: GridView.count(
//                           crossAxisCount: 2,
//                           primary: true,
//                           shrinkWrap: true,
//                           crossAxisSpacing: 2,
//                           mainAxisSpacing: 2,
//                           childAspectRatio: (16 / 14),
//                           physics: ScrollPhysics(),
//                           children: List.generate(4, (index) {
//                             return InkWell(
//                                 // onTap: () {
//                                 //   pushNewScreen(
//                                 //     context,
//                                 //     screen: AllStores(),
//                                 //     withNavBar:
//                                 //         true, // OPTIONAL VALUE. True by default.
//                                 //     pageTransitionAnimation:
//                                 //         PageTransitionAnimation.cupertino,
//                                 //   );
//                                 // },
//                                 child: TargetItems());
//                           })),
//                     )
                  
                  
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }
