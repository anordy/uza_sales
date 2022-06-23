// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:uza_sales/app/model/category_model.dart';
// import 'package:uza_sales/app/pages/products_page.dart';
// import 'package:uza_sales/app/widget/utils.dart';

// class CategoryCard extends StatelessWidget {
//   final Category categories;
//   const CategoryCard({Key key, @required this.categories}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         navigate(context);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(color: Color(0xFFDBD8DD)),
//             borderRadius: BorderRadius.circular(8)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: Utils.displayHeight(context) * 0.1,
//               width: Utils.displayWidth(context),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(8),
//                       topRight: Radius.circular(8)),
//                   color: Color(0xFFDBD8DD)),
//               child: ClipRRect(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(8),
//                       topRight: Radius.circular(8)),
//                   child: Image.asset(
//                     this.categories.image,
//                     fit: BoxFit.cover,
//                   )),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0, top: 2),
//               child: Text(
//                 this.categories.name,
//                 style: TextStyle(
//                     color: Color(0xFF2D0C57), fontWeight: FontWeight.bold),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0, top: 2),
//               child: Text(
//                 this.categories.deals,
//                 style: TextStyle(color: Color(0xFF9586A8)),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   navigate(BuildContext context) {
//     pushNewScreen(
//       context,
//       screen: ProductsPage(),
//       withNavBar: true, // OPTIONAL VALUE. True by default.
//       pageTransitionAnimation: PageTransitionAnimation.cupertino,
//     );
//   }
// }
