// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:oktoast/oktoast.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:uza_sales/app/retailer/Test/email_screen.dart';
// import 'package:uza_sales/app/retailer/pages/about_uza.dart';
// import 'package:uza_sales/app/retailer/pages/auth/welcome_page.dart';
// import 'package:uza_sales/app/retailer/pages/profile_setting.dart';
// import 'package:uza_sales/app/retailer/provider/ads_provider.dart';
// import 'package:uza_sales/app/retailer/provider/locale_provider.dart';
// import 'package:uza_sales/app/retailer/screen/chat_screen.dart';
// import 'package:uza_sales/app/retailer/screen/notification_screen.dart';
// import 'package:uza_sales/app/retailer/widget/colors.dart';
// import 'package:uza_sales/app/retailer/button/custom_buton.dart';
// import 'package:uza_sales/app/retailer/widget/language_widget.dart';
// import 'package:uza_sales/app/retailer/widget/policies_widget.dart';
// import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
// import 'package:uza_sales/app/retailer/widget/utils.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:share/share.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AccountScreen extends StatefulWidget {
//   const AccountScreen({Key key}) : super(key: key);

//   @override
//   _AccountScreenState createState() => _AccountScreenState();
// }

// class _AccountScreenState extends State<AccountScreen> {
//   String phone = "255716121688";
//   String adminPhone = "+255716121689";
//   String accessToken;
//   String shopName;
//   String address;
//   _loadUsers() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     setState(() {
//       this.phone = sharedPreferences.getString('phone');
//       this.accessToken = sharedPreferences.getString('accessToken');
//       this.address = sharedPreferences.getString('address');
//       this.shopName = sharedPreferences.getString('shopName');
//       if (this.address == null) {
//         this.address = "Dar es salaam, Tanzaniia";
//       }
//       if (this.shopName == null) {
//         this.shopName = "Default Shop";
//       }
//       if (this.phone == null) {
//         this.phone = "255 716 121 688";
//       }
//       print("*****  phone number");
//       print("phone: ${this.phone}");
//     });
//   }

//   String greeting() {
//     var hour = DateTime.now().hour;
//     if (hour < 12) {
//       return 'Good Morning';
//     }
//     if (hour < 17) {
//       return 'Good Afternoon';
//     }
//     return 'Good Evening';
//   }

//   SharedPreferences sharedPreferences;
//   bool changeLanguage = false;
//   String currentLocale = "";

//   bool isSwitched = false;
//   @override
//   void initState() {
//     super.initState();
//     _loadUsers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _localeProvider = Provider.of<LocaleProvider>(context);
//     final _adsProvider = Provider.of<AdsProvider>(context);
//     return Scaffold(
//         backgroundColor: Color(0xFFE5E5E5),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // SizedBox(
//                 //   height: 40,
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(left: 20.0),
//                 //   child: Column(
//                 //     crossAxisAlignment: CrossAxisAlignment.start,
//                 //     children: [
//                 //       Text(
//                 //         AppLocalizations.of(context).hello,
//                 //         style: TextStyle(
//                 //             color: Colors.white,
//                 //             fontSize: 18,
//                 //             fontWeight: FontWeight.bold),
//                 //       ),
//                 //       SizedBox(height: 5),
//                 //       Text(
//                 //         greeting(),
//                 //         style: TextStyle(
//                 //             color: Colors.white,
//                 //             fontSize: 18,
//                 //             fontWeight: FontWeight.bold),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 // SizedBox(
//                 //   height: 55.0,
//                 // ),
//                 Container(
//                   // height: Utils.displayHeight(context),
//                   width: Utils.displayWidth(context),
//                   decoration: BoxDecoration(
//                     color: Color(0xFFE5E5E5),
//                     // borderRadius: BorderRadius.only(
//                     // topLeft: Radius.circular(50.0),
//                     // topRight: Radius.circular(50.0))
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 40,
//                       ),
//                       CircleAvatar(
//                         backgroundColor: Colors.white,
//                         radius: 35,
//                         child: CircleAvatar(
//                           backgroundColor: Colors.grey,
//                           radius: 30,
//                           child: Icon(
//                             Icons.person,
//                             color: Colors.black,
//                             size: 40,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       InkWell(
//                         onTap: () {
//                             pushNewScreen(
//                               context,
//                               screen: ProfileSetting(),
//                               withNavBar:
//                                   true, // OPTIONAL VALUE. True by default.
//                               pageTransitionAnimation:
//                                   PageTransitionAnimation.cupertino,
//                             );
//                         },
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.edit,
//                                 color: AppColor.preBase,
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text("Edit Profile",
//                                   style: TextStyle(color: AppColor.preBase))
//                             ]),
//                       ),
//                            SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "${this.shopName}",
//                             style: TextStyle(
//                                 color: Color(0xFF2D0C57),
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           // SizedBox(width: 5),
//                           // Icon(Icons.check,
//                           //     size: 18, color: Color(0xFF2D0C57))
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "${this.address}",
//                             style: TextStyle(color: Color(0xFFAEAEAE)),
//                           ),
//                           // SizedBox(width: 5),
//                           // Icon(Icons.edit,
//                           //     size: 18, color: Color(0xFF40403F))
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),

//                       Text(
//                         "${this.phone}",
//                         style: TextStyle(color: Color(0xFFAEAEAE)),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Container(
//                           height: Utils.displayHeight(context) * 0.15,
//                           width: Utils.displayWidth(context),
//                           decoration: BoxDecoration(
//                               color: Color(0xFFFFFFFF),
//                               borderRadius: BorderRadius.circular(13),
//                               boxShadow: [
//                                 BoxShadow(
//                                   offset: Offset(0, 1),
//                                   blurRadius: 5,
//                                   color: Colors.black.withOpacity(0.2),
//                                 )
//                               ]),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.only(left: 20.0, top: 5),
//                                 child: Text(
//                                     AppLocalizations.of(context).help_support,
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold)),
//                               ),
//                               SizedBox(height: 10),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 20.0, right: 20.0),
//                                 child: Divider(
//                                   color: Colors.grey[400],
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   InkWell(
//                                     onTap: () {
//                                       openwhatsapp();
//                                     },
//                                     child: Container(
//                                       height: 50,
//                                       width: 45,
//                                       decoration: BoxDecoration(
//                                           color: Color(0xFFFFFFFF),
//                                           borderRadius:
//                                               BorderRadius.circular(5)),
//                                       child: Icon(FontAwesomeIcons.whatsapp,
//                                           color: Color(0xFF25D366)),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () => launch("tel: $adminPhone"),
//                                     child: Container(
//                                       height: 50,
//                                       width: 45,
//                                       decoration: BoxDecoration(
//                                           color: Color(0xFFFFFFFF),
//                                           borderRadius:
//                                               BorderRadius.circular(5)),
//                                       child: Icon(Icons.call,
//                                           color: Color(0xFF25D366)),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       pushNewScreen(
//                                         context,
//                                         screen: EmailSender(),
//                                         withNavBar:
//                                             true, // OPTIONAL VALUE. True by default.
//                                         pageTransitionAnimation:
//                                             PageTransitionAnimation.cupertino,
//                                       );
//                                     },
//                                     child: Container(
//                                       height: 50,
//                                       width: 45,
//                                       decoration: BoxDecoration(
//                                           color: Color(0xFFFFFFFF),
//                                           borderRadius:
//                                               BorderRadius.circular(5)),
//                                       child: Icon(Icons.mail_outline,
//                                           color: Color(0xFFFF1717)),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       pushNewScreen(
//                                         context,
//                                         screen: ChatScreen(),
//                                         withNavBar:
//                                             true, // OPTIONAL VALUE. True by default.
//                                         pageTransitionAnimation:
//                                             PageTransitionAnimation.cupertino,
//                                       );
//                                     },
//                                     child: Container(
//                                       height: 50,
//                                       width: 45,
//                                       decoration: BoxDecoration(
//                                           color: Color(0xFFFFFFFF),
//                                           borderRadius:
//                                               BorderRadius.circular(5)),
//                                       child: Icon(Icons.message_outlined,
//                                           color: Color(0xFF2D0C57)),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),

//                       // Align(
//                       //   alignment: Alignment.centerLeft,
//                       //   child: Padding(
//                       //     padding: const EdgeInsets.only(left: 20.0),
//                       //     child: Text(
//                       //       AppLocalizations.of(context).general,
//                       //       style: TextStyle(
//                       //           color: Color(0xFF2D0C57),
//                       //           fontSize: 12,
//                       //           fontWeight: FontWeight.bold),
//                       //     ),
//                       //   ),
//                       // ),
//                       // SizedBox(
//                       //   height: 10,
//                       // ),

//                       // Padding(
//                       //   padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                       //   child: InkWell(
//                       //     onTap: () {
//                       //       pushNewScreen(
//                       //         context,
//                       //         screen: ProfileSetting(),
//                       //         withNavBar:
//                       //             true, // OPTIONAL VALUE. True by default.
//                       //         pageTransitionAnimation:
//                       //             PageTransitionAnimation.cupertino,
//                       //       );
//                       //     },
//                       //     child: Container(
//                       //       height: 55,
//                       //       width: Utils.displayWidth(context),
//                       //       decoration: BoxDecoration(
//                       //         color: AppColor.bgScreen,
//                       //         borderRadius: BorderRadius.circular(30),
//                       //       ),
//                       //       child: ListTile(
//                       //         leading: CircleAvatar(
//                       //             backgroundColor: Color(0xFFF3F3F3),
//                       //             child: Icon(
//                       //               Icons.edit,
//                       //               color: Color(0xFF525252),
//                       //             )),
//                       //         title: Text(
//                       //           AppLocalizations.of(context).profile_settings,
//                       //           style: TextStyle(
//                       //               fontSize: 14,
//                       //               fontWeight: FontWeight.w400,
//                       //               color: Color(0xFF525252)),
//                       //         ),
//                       //         trailing: Icon(Icons.chevron_right),
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ),

//                       SizedBox(
//                         height: 10,
//                       ),

//                       Padding(
//                         padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                         child: Container(
//                           height: 55,
//                           width: Utils.displayWidth(context),
//                           decoration: BoxDecoration(
//                             color: AppColor.bgScreen,
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                           child: ListTile(
//                             leading: CircleAvatar(
//                                 backgroundColor: Color(0xFFF3F3F3),
//                                 child: Icon(
//                                   Icons.notifications,
//                                   color: Color(0xFF525252),
//                                 )),
//                             title: Text(
//                               "Notifications",
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                   color: Color(0xFF525252)),
//                             ),
//                             trailing: CircleAvatar(
//                                 radius: 15,
//                                 backgroundColor: AppColor.preBase,
//                                 child: Text(
//                                   "15",
//                                   style: TextStyle(color: Colors.white),
//                                 )),
//                             onTap: () {
//                               pushNewScreen(
//                                 context,
//                                 screen: NotificationScreen(),
//                                 withNavBar:
//                                     true, // OPTIONAL VALUE. True by default.
//                                 pageTransitionAnimation:
//                                     PageTransitionAnimation.cupertino,
//                               );
//                             },
//                           ),
//                         ),
//                       ),

//                       SizedBox(
//                         height: 10,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                         child: InkWell(
//                           onTap: () {},
//                           child: Container(
//                             height: 55,
//                             width: Utils.displayWidth(context),
//                             decoration: BoxDecoration(
//                               color: AppColor.bgScreen,
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                             child: ListTile(
//                               leading: CircleAvatar(
//                                   backgroundColor: Color(0xFFF3F3F3),
//                                   child: Icon(
//                                     Icons.language,
//                                     color: Color(0xFF525252),
//                                   )),
//                               title: Text(
//                                 AppLocalizations.of(context).change_language,
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xFF525252)),
//                               ),
//                               trailing: LanguagePickerWidget(),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),

//                       Padding(
//                         padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                         // child: InkWell(
//                         // onTap: () {
//                         //   navigate(context, FaqWidget(), true);
//                         // },
//                         child: Container(
//                           height: 55,
//                           width: Utils.displayWidth(context),
//                           decoration: BoxDecoration(
//                             color: AppColor.bgScreen,
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                           child: ListTile(
//                             leading: CircleAvatar(
//                                 backgroundColor: Color(0xFFF3F3F3),
//                                 child: Icon(
//                                   Icons.policy,
//                                   color: Color(0xFF525252),
//                                 )),
//                             title: Text(
//                               AppLocalizations.of(context).policies,
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400,
//                                   color: Color(0xFF525252)),
//                             ),
//                             trailing: Icon(Icons.chevron_right),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),

//                       Padding(
//                         padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                         child: InkWell(
//                           onTap: () {
//                             Share.share("App Link");
//                           },
//                           child: Container(
//                             height: 55,
//                             width: Utils.displayWidth(context),
//                             decoration: BoxDecoration(
//                               color: AppColor.bgScreen,
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                             child: ListTile(
//                               leading: CircleAvatar(
//                                   backgroundColor: Color(0xFFF3F3F3),
//                                   child: Icon(
//                                     Icons.share,
//                                     color: Color(0xFF525252),
//                                   )),
//                               title: Text(
//                                 AppLocalizations.of(context).share,
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xFF525252)),
//                               ),
//                               trailing: Icon(Icons.chevron_right),
//                             ),
//                           ),
//                         ),
//                       ),

//                       SizedBox(
//                         height: 10,
//                       ),

//                       Padding(
//                         padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                         child: InkWell(
//                           onTap: () {
//                             pushNewScreen(
//                               context,
//                               screen: AboutUza(),
//                               withNavBar:
//                                   true, // OPTIONAL VALUE. True by default.
//                               pageTransitionAnimation:
//                                   PageTransitionAnimation.cupertino,
//                             );
//                           },
//                           child: Container(
//                             height: 55,
//                             width: Utils.displayWidth(context),
//                             decoration: BoxDecoration(
//                               color: AppColor.bgScreen,
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                             child: ListTile(
//                               leading: CircleAvatar(
//                                   backgroundColor: Color(0xFFF3F3F3),
//                                   child: Icon(
//                                     Icons.add_box_outlined,
//                                     color: Color(0xFF525252),
//                                   )),
//                               title: Text(
//                                 AppLocalizations.of(context).about_uza,
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xFF525252)),
//                               ),
//                               trailing: Icon(Icons.chevron_right),
//                             ),
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: 25),

//                       CustomButton(
//                         color: AppColor.preBase,
//                         height: 50,
//                         width: Utils.displayWidth(context) * 0.4,
//                         inputText: Text(
//                           AppLocalizations.of(context).log_out.toUpperCase(),
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                         onPressed: () {
//                           _signOut();
//                         },
//                       ),
//                       SizedBox(height: 10),
//                       // RichText(
//                       //     text: TextSpan(children: <TextSpan>[
//                       //   TextSpan(
//                       //       text: "Uza",
//                       //       style: TextStyle(
//                       //           color: Color(0xFF2D0C57), fontSize: 20,letterSpacing: 2)),
//                       //   TextSpan(
//                       //       text: 'App',
//                       //       style: TextStyle(
//                       //           color: AppColor.base, fontSize: 20,letterSpacing: 2)),
//                       // ])),
//                       SizedBox(
//                         height: 5.0,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 20.0),
//                         child: Text(
//                           "Version 1.0.0",
//                           style: TextStyle(color: Color(0xFF9B9C9B)),
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }

//   navigate(BuildContext context, Widget screen, bool nav) {
//     pushNewScreen(
//       context,
//       screen: screen,
//       withNavBar: true, // OPTIONAL VALUE. True by default.
//       pageTransitionAnimation: PageTransitionAnimation.cupertino,
//     );
//   }

//   _signOut() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.remove("accessToken");
//     sharedPreferences.setBool("isLoggedIn", false);
//     showToastWidget(
//       ToastWidget(
//           icon: Icon(
//             Icons.done,
//             color: Color(0xFF06be77),
//             size: 15,
//           ),
//           height: 50,
//           width: 200,
//           color: AppColor.success,
//           description: "Logged Out"),
//       duration: Duration(seconds: 2),
//       position: ToastPosition.bottom,
//     );

//     pushNewScreen(
//       context,
//       screen: WelcomePage(),
//       withNavBar: false, // OPTIONAL VALUE. True by default.
//       pageTransitionAnimation: PageTransitionAnimation.cupertino,
//     );
//   }

//   // open whatsapp
//   openwhatsapp() async {
//     var whatsapp = "+255743040403";
//     var whatsappURl_android =
//         "whatsapp://send?phone=" + whatsapp + "&text=hello";
//     var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
//     if (Platform.isIOS) {
//       // for iOS phone only
//       if (await canLaunch(whatappURL_ios)) {
//         await launch(whatappURL_ios, forceSafariVC: false);
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
//       }
//     } else {
//       // android , web
//       if (await canLaunch(whatsappURl_android)) {
//         await launch(whatsappURl_android);
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
//       }
//     }
//   }
// }
