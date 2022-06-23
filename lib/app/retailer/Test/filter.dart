// import 'package:flutter/material.dart';
//  GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onTap: () => Navigator.of(context).pop(),
//         child: GestureDetector(
//           onTap: () {},
//           child: DraggableScrollableSheet(
//           initialChildSize: 0.7,
//           minChildSize: 0.5,
//           maxChildSize: 0.7,
//           builder: (_, controller) => Container(
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 80),
//               child: ListView(
//                 controller: controller,
//                 // crossAxisAlignment: CrossAxisAlignment.start,
//                 // mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     "Filter by Price",
//                     style: TextStyle(color: Color(0xFF40403F)),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
//                     width: Utils.displayWidth(context),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Color(0xFFC7D3DD))),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         isExpanded: true,
//                         icon: Icon(FontAwesomeIcons.chevronDown,
//                             color: Colors.black, size: 16),
//                         // focusColor: Colors.white,
//                         value: value1,
//                         // elevation: 2,
//                         style: TextStyle(color: Colors.white),
//                         iconEnabledColor: Colors.black,
//                         items: lowests.map(buildMenuItem).toList(),
//                         onChanged: (String value) {
//                           setState(() {
//                             this.value1 = value;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 25.0),
//                   Text(
//                     "Filter by Discount",
//                     style: TextStyle(color: Color(0xFF40403F)),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
//                     width: Utils.displayWidth(context),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Color(0xFFC7D3DD))),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         isExpanded: true,
//                         icon: Icon(FontAwesomeIcons.chevronDown,
//                             color: Colors.black, size: 16),
//                         // focusColor: Colors.white,
//                         value: value2,
//                         // elevation: 2,
//                         style: TextStyle(color: Colors.white),
//                         iconEnabledColor: Colors.black,
//                         items: discounts.map(buildMenuItem).toList(),
//                         onChanged: (String value) {
//                           setState(() {
//                             this.value2 = value;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 25.0),
//                   Text(
//                     "Filter by Alphabet",
//                     style: TextStyle(color: Color(0xFF40403F)),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
//                     width: Utils.displayWidth(context),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Color(0xFFC7D3DD))),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         isExpanded: true,
//                         icon: Icon(FontAwesomeIcons.chevronDown,
//                             color: Colors.black, size: 16),
//                         // focusColor: Colors.white,
//                         value: value3,
//                         // elevation: 2,
//                         style: TextStyle(color: Colors.white),
//                         iconEnabledColor: Colors.black,
//                         items: alphabets.map(buildMenuItem).toList(),
//                         onChanged: (String value) {
//                           setState(() {
//                             this.value3 = value;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 45.0,
//                   ),
//                   Center(
//                     child: MaterialButton(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(60.0)),
//                       color: Theme.of(context).primaryColor,
//                       height: 50,
//                       minWidth: Utils.displayWidth(context) * 0.4,
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text(
//                         'Apply'.toUpperCase(),
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
     
//         ),
//       );