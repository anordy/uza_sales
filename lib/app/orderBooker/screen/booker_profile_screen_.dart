import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uza_sales/app/orderBooker/map/bymap_list.dart';
import 'package:uza_sales/app/orderBooker/orders/booker_category_order.dart';
import 'package:uza_sales/app/orderBooker/orders/order_booker_history.dart';
import 'package:uza_sales/app/orderBooker/pages/booker_home.dart';
import 'package:uza_sales/app/orderBooker/pages/booker_notification_screen.dart';
import 'package:uza_sales/app/orderBooker/pages/stock_availability.dart';
import 'package:uza_sales/app/orderBooker/screen/booker_cart_screen.dart';
import 'package:uza_sales/app/orderBooker/screen/booker_route_screen.dart';
import 'package:uza_sales/app/orderBooker/screen/home_summary_screen.dart';
import 'package:uza_sales/app/orderBooker/widget/booker_redeem_dialog.dart';
import 'package:uza_sales/app/retailer/pages/auth/welcome_page.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/button/custom_buton.dart';
import 'package:uza_sales/app/retailer/widget/language_widget.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uza_sales/app/sales/pages/sales_notification.dart';
import 'package:uza_sales/app/sales/screen/myRoute_screen.dart';

class BookerProfileScreen extends StatefulWidget {
  const BookerProfileScreen({Key key}) : super(key: key);

  @override
  _BookerProfileScreenState createState() => _BookerProfileScreenState();
}

class _BookerProfileScreenState extends State<BookerProfileScreen> {
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
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return BookerRedeemDialog(
                                    desc:
                                        "This Feature is not available at the moment",
                                    ok: "Okay",
                                    cancelChange: () {
                                      Navigator.pop(context);
                                    },
                                    okChange: () {
                                      Navigator.pop(context);
                                    });
                              });
                        },
                        child: Container(
                          height: Utils.displayHeight(context) * 0.1,
                          width: Utils.displayWidth(context) * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Your Point Balance",
                                style: TextStyle(
                                    color: Color(0xFF9e9e9e), fontSize: 10),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    color: Color(0xFF565656),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BookerRedeemDialog(
                                            desc:
                                                "You have insufficient Points",
                                            ok: "Okay".toUpperCase(),
                                            cancelChange: () {
                                              Navigator.pop(context);
                                            },
                                            okChange: () {
                                              Navigator.pop(context);
                                            });
                                      });
                                },
                                child: Container(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Redeem Point",
                                      style: TextStyle(
                                          color: AppColor.base, fontSize: 10),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.double_arrow_outlined,
                                      color: AppColor.base,
                                      size: 10,
                                    )
                                  ],
                                )),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      profileTilesWidget(
                          leadingIcon: Icons.notifications,
                          title: AppLocalizations.of(context).notification,
                          trailingIcon: CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColor.preBase,
                              child: Text(
                                "5",
                                style: TextStyle(color: Colors.white),
                              )),next: BookerNotificationScreen()
                              ),                    
                      SizedBox(
                        height: 10,
                      ),
                      profileTilesWidget(
                          leadingIcon: FontAwesomeIcons.route,
                          title: AppLocalizations.of(context).my_routes,
                          trailingIcon: Icon(Icons.chevron_right),
                          next: ByMap(),
                          ),
                      SizedBox(
                        height: 10,
                      ),
                      profileTilesWidget(
                          leadingIcon: FontAwesomeIcons.list,
                          title: AppLocalizations.of(context).order_history,
                          trailingIcon: Icon(Icons.chevron_right),
                          next: OrderBookerHistory()
                          ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // profileTilesWidget(
                      //     leadingIcon: FontAwesomeIcons.store,
                      //     title: "Home Summary",
                      //     trailingIcon: Icon(Icons.chevron_right),
                      //     next: HomeSummaryScreen()
                      //     ),
                      SizedBox(
                        height: 10,
                      ),
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
                      SizedBox(
                        height: 15.0,
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

  // listtile widgets
  Widget profileTilesWidget(
      {IconData leadingIcon, String title, Widget trailingIcon, Widget next}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: InkWell(
        onTap: () {
          pushNewScreen(
            context,
            screen: next,
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
                  leadingIcon,
                  color: Color(0xFF525252),
                )),
            title: Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF525252)),
            ),
            trailing: trailingIcon,
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

// signout application
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
