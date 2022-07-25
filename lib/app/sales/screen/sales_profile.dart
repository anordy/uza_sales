import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uza_sales/app/retailer/pages/auth/welcome_page.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/button/custom_buton.dart';
import 'package:uza_sales/app/retailer/widget/language_widget.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uza_sales/app/sales/orders/order_history.dart';
import 'package:uza_sales/app/sales/pages/sales_notification.dart';
import 'package:uza_sales/app/sales/screen/myRoute_screen.dart';
import 'package:uza_sales/app/sales/screen/myStock_screen.dart';
import 'package:uza_sales/app/sales/screen/myVisit_screen.dart';

class SalesProfile extends StatefulWidget {
  const SalesProfile({Key key}) : super(key: key);

  @override
  _SalesProfileState createState() => _SalesProfileState();
}

class _SalesProfileState extends State<SalesProfile> {
  String phone = "255716121688";
  String adminPhone = "+255716121689";
  String accessToken;
  String shopName;
  String fname;
  String address;
  _loadUsers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      this.phone = sharedPreferences.getString('phone');
      this.accessToken = sharedPreferences.getString('accessToken');
      this.fname = sharedPreferences.getString('fname');
      if (this.address == null) {
        this.address = "Dar es salaam, Tanzaniia";
      }
      if (this.shopName == null) {
        this.shopName = "Default Shop";
      }
      if (this.phone == null) {
        this.phone = "255 *** *** ***";
      }
      print("*****  phone number");
      print("phone: ${this.phone}");
    });
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning $fname';
    }
    if (hour < 17) {
      return 'Good Afternoon $fname';
    }
    return 'Good Evening $fname';
  }

  SharedPreferences sharedPreferences;
  bool changeLanguage = false;
  String currentLocale = "";
  bool isSwitched = false;
  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.bgScreen2,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: Utils.displayHeight(context),
                  width: Utils.displayWidth(context),
                  decoration: BoxDecoration(
                    color: AppColor.bgScreen2,
                    // borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(50.0),
                    // topRight: Radius.circular(50.0))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 30,
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 40,
                          ),
                        ),
                      ),

                      Text(""),
                      SizedBox(
                        height: 10,
                      ),

                      Text(
                        greeting(),
                        style: TextStyle(
                            color: Color(0xFF525252),
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Container(
                          height: 55,
                          width: Utils.displayWidth(context),
                          decoration: BoxDecoration(
                            color: AppColor.bgScreen,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                                backgroundColor: AppColor.bgScreen2,
                                child: Icon(
                                  Icons.notifications,
                                  color: Color(0xFF525252),
                                )),
                            title: Text(
                              AppLocalizations.of(context).notifications,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF525252)),
                            ),
                            trailing: CircleAvatar(
                                radius: 15,
                                backgroundColor: AppColor.preBase,
                                child: Text(
                                  "15",
                                  style: TextStyle(color: Colors.white),
                                )),
                            onTap: () {
                              pushNewScreen(
                                context,
                                screen: SalesNotificationScreen(),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: InkWell(
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: MyRouteScreen(),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          child: Container(
                            height: 55,
                            width: Utils.displayWidth(context),
                            decoration: BoxDecoration(
                              color: AppColor.bgScreen,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor: Color(0xFFF3F3F3),
                                  child: Icon(
                                    FontAwesomeIcons.route,
                                    color: Color(0xFF525252),
                                  )),
                              title: Text(
                                AppLocalizations.of(context).my_routes,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF525252)),
                              ),
                              trailing: Icon(Icons.chevron_right),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: InkWell(
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: OrderHistory(),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          child: Container(
                            height: 55,
                            width: Utils.displayWidth(context),
                            decoration: BoxDecoration(
                              color: AppColor.bgScreen,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor: Color(0xFFF3F3F3),
                                  child: Icon(
                                    FontAwesomeIcons.list,
                                    color: Color(0xFF525252),
                                  )),
                              title: Text(
                                AppLocalizations.of(context).order_history,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF525252)),
                              ),
                              trailing: Icon(Icons.chevron_right),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: InkWell(
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: MyStock(),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          child: Container(
                            height: 55,
                            width: Utils.displayWidth(context),
                            decoration: BoxDecoration(
                              color: AppColor.bgScreen,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor: Color(0xFFF3F3F3),
                                  child: Icon(
                                    Icons.local_mall,
                                    color: Color(0xFF525252),
                                  )),
                              title: Text(
                                AppLocalizations.of(context).my_stock,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF525252)),
                              ),
                              trailing: Icon(Icons.chevron_right),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: InkWell(
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: MyVisitScreen(),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          child: Container(
                            height: 55,
                            width: Utils.displayWidth(context),
                            decoration: BoxDecoration(
                              color: AppColor.bgScreen,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor: Color(0xFFF3F3F3),
                                  child: Icon(
                                    FontAwesomeIcons.store,
                                    color: Color(0xFF525252),
                                  )),
                              title: Text(
                                AppLocalizations.of(context).visit_summary,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF525252)),
                              ),
                              trailing: Icon(Icons.chevron_right),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

//
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 55,
                            width: Utils.displayWidth(context),
                            decoration: BoxDecoration(
                              color: AppColor.bgScreen,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor: Color(0xFFF3F3F3),
                                  child: Icon(
                                    Icons.language,
                                    color: Color(0xFF525252),
                                  )),
                              title: Text(
                                AppLocalizations.of(context).change_language,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF525252)),
                              ),
                              trailing: LanguagePickerWidget(),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 25),

                      CustomButton(
                        color: AppColor.preBase,
                        height: 50,
                        width: Utils.displayWidth(context) * 0.4,
                        inputText: Text(
                          AppLocalizations.of(context).log_out.toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () {
                          _signOut();
                          // pushNewScreen(
                          //   context,
                          //   screen: SearchSample(),
                          //   withNavBar:
                          //       true, // OPTIONAL VALUE. True by default.
                          //   pageTransitionAnimation:
                          //       PageTransitionAnimation.cupertino,
                          // );
                        },
                      ),
                      SizedBox(height: 10),

                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          "Version 1.0.0",
                          style: TextStyle(color: Color(0xFF9B9C9B)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  // listtile
  Widget listtileWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: InkWell(
        onTap: () {
          pushNewScreen(
            context,
            screen: MyRouteScreen(),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        child: Container(
          height: 55,
          width: Utils.displayWidth(context),
          decoration: BoxDecoration(
            color: AppColor.bgScreen,
            borderRadius: BorderRadius.circular(50),
          ),
          child: ListTile(
            leading: CircleAvatar(
                backgroundColor: Color(0xFFF3F3F3),
                child: Icon(
                  FontAwesomeIcons.route,
                  color: Color(0xFF525252),
                )),
            title: Text(
              AppLocalizations.of(context).my_routes,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF525252)),
            ),
            trailing: Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }

  navigate(BuildContext context, Widget screen, bool nav) {
    pushNewScreen(
      context,
      screen: screen,
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  // signout in the application
  _signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("accessToken");
    sharedPreferences.setBool("isLoggedIn", false);
    showToastWidget(
      ToastWidget(
          icon: Icon(
            Icons.done,
            color: Color(0xFF06be77),
            size: 15,
          ),
          height: 50,
          width: 200,
          color: AppColor.success,
          description: "Logged Out"),
      duration: Duration(seconds: 2),
      position: ToastPosition.bottom,
    );

    pushNewScreen(
      context,
      screen: WelcomePage(),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  // launch whatsapp
  void launchWhatsapp({@required number, @required message}) async {
    String url = "whatsapp://send?phone=$number&text=$message";
    await canLaunch(url) ? launch(url) : print("Whatsapp not installed");
  }

  // open whatsapp
  openwhatsapp() async {
    var whatsapp = "+255743040403";
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios =
        "https://wa.me/$whatsapp?text=${Uri.parse("Welcome Uza.")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }
}
