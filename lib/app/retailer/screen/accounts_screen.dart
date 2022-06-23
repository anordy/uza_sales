import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/Test/email_screen.dart';
import 'package:uza_sales/app/retailer/pages/about_uza.dart';
import 'package:uza_sales/app/retailer/pages/auth/welcome_page.dart';
import 'package:uza_sales/app/retailer/pages/edit_retailer_shop.dart';
import 'package:uza_sales/app/retailer/provider/ads_provider.dart';
import 'package:uza_sales/app/retailer/screen/chat_screen.dart';
import 'package:uza_sales/app/retailer/screen/notification_screen.dart';
import 'package:uza_sales/app/retailer/screen/zendesktest.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/button/custom_buton.dart';
import 'package:uza_sales/app/retailer/widget/language_widget.dart';
import 'package:uza_sales/app/retailer/widget/policies_widget.dart';
import 'package:uza_sales/app/retailer/widget/redeem_dialog.dart';
import 'package:uza_sales/app/retailer/widget/signout-toast.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zendesk_plugin/zendesk_plugin.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String phone = "255716121688";
  String adminPhone = "+255716121689";
  String accessToken;
  String shopName;
  String address;
  bool isAuth;
  _loadUsers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      this.phone = sharedPreferences.getString('phone');
      this.accessToken = sharedPreferences.getString('accessToken');
      this.address = sharedPreferences.getString('address');
      this.shopName = sharedPreferences.getString('shopName');
      print("================  shopname   ===================");
      print('${this.shopName}');
      print("======================================");
      this.isAuth = sharedPreferences.getBool('isLoggedIn');
      if (this.address == null || this.address == '') {
        this.address = "Dar es salaam, Tanzania";
      }
      // if (this.shopName == null || this.shopName == '') {
      //   this.shopName = "Default Shop";
      // }
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
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  SharedPreferences sharedPreferences;
  bool changeLanguage = false;
  String currentLocale = "";

  bool isSwitched = false;
  @override
  void initState() {
    super.initState();
    _loadUsers();
    initZendesk();
  }

  Future<void> initZendesk() async {
    if (!mounted) {
      return;
    }
    await Zendesk.initialize('PWO5hJeH8XCGO8LSfY5nDNaOQ42nY5BY',
        '14f0556d7925629b53df60ffd9bc4a41d1b6546715c76d19');
  }

  @override
  Widget build(BuildContext context) {
    final adsProvider = Provider.of<AdsProvider>(context);
    // final _adsProvider = Provider.of<AdsProvider>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFE5E5E5),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: Utils.displayHeight(context),
                  width: Utils.displayWidth(context),
                  decoration: BoxDecoration(
                    color: Color(0xFFE5E5E5),
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
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          pushNewScreen(
                            context,
                            screen: EditRetailerShop(),
                            withNavBar:
                                true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit,
                                color: AppColor.preBase,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Edit Profile",
                                  style: TextStyle(color: AppColor.preBase))
                            ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      this.isAuth
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${this.shopName}",
                                  style: TextStyle(
                                      color: Color(0xFF2D0C57),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                // SizedBox(width: 5),
                                // Icon(Icons.check,
                                //     size: 18, color: Color(0xFF2D0C57))
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      this.isAuth
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${this.address}",
                                  style: TextStyle(color: Color(0xFFAEAEAE)),
                                ),
                                // SizedBox(width: 5),
                                // Icon(Icons.edit,
                                //     size: 18, color: Color(0xFF40403F))
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      this.isAuth
                          ? Text(
                              "${this.phone}",
                              style: TextStyle(color: Color(0xFFAEAEAE)),
                            )
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: Utils.displayHeight(context) * 0.07,
                          width: Utils.displayWidth(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      openwhatsapp();
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Icon(FontAwesomeIcons.whatsapp,
                                          color: Color(0xFF25D366)),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => launch("tel: $adminPhone"),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Icon(Icons.call,
                                          color: Color(0xFF25D366)),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      pushNewScreen(
                                        context,
                                        screen: EmailSender(),
                                        withNavBar:
                                            true, // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Icon(Icons.mail_outline,
                                          color: Color(0xFFFF1717)),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      openChat();
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Icon(Icons.message_outlined,
                                          color: Color(0xFF2D0C57)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return RedeemDialog(
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
                                        return RedeemDialog(
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
                                backgroundColor: Color(0xFFF3F3F3),
                                child: Icon(
                                  Icons.notifications,
                                  color: Color(0xFF525252),
                                )),
                            title: Text(
                              "Notifications",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF525252)),
                            ),
                            trailing: CircleAvatar(
                                radius: 15,
                                backgroundColor: AppColor.preBase,
                                child: Text(
                                  "5",
                                  style: TextStyle(color: Colors.white),
                                )),
                            onTap: () {
                              pushNewScreen(
                                context,
                                screen: NotificationScreen(),
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
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        // child: InkWell(
                        // onTap: () {
                        //   navigate(context, FaqWidget(), true);
                        // },
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
                                  Icons.policy,
                                  color: Color(0xFF525252),
                                )),
                            title: Text(
                              AppLocalizations.of(context).policies,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF525252)),
                            ),
                            trailing: PoliciesWidget(),
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
                            Share.share("App Link");
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
                                    Icons.share,
                                    color: Color(0xFF525252),
                                  )),
                              title: Text(
                                AppLocalizations.of(context).share,
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
                              screen: AboutUza(),
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
                                    Icons.add_box_outlined,
                                    color: Color(0xFF525252),
                                  )),
                              title: Text(
                                AppLocalizations.of(context).about_uza,
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

  navigate(BuildContext context, Widget screen, bool nav) {
    pushNewScreen(
      context,
      screen: screen,
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  _signOut() async {
    await Future.delayed(Duration(seconds: 1));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("accessToken");
    sharedPreferences.setBool("isLoggedIn", false);
    // sharedPreferences.setString('phone', '');
    // sharedPreferences.setString('address', '');
    // sharedPreferences.setString('shopName', '');
    showToastWidget(
      SignOutToast(
          icon: Icon(
            Icons.done,
            color: Colors.white,
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
    var whatsapp = "255743040403";
    String msg = "Welcome Hesa Africa \n How can we help you?";
    var whatsappURlAndroid = "https://wa.me/$whatsapp?text=$msg";
    var whatappURLIos = "https://wa.me/$whatsapp?text=${Uri.parse("$msg")}";
    if (Platform.isIOS) {
      // for iOS phone only
      print("ios platform");
      if (await canLaunch(whatappURLIos)) {
        await launch(whatappURLIos, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp not installed")));
      }
    } else if (Platform.isAndroid) {
      // android
      print(" platform android ");
      await launch(whatsappURlAndroid);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("whatsapp not installed")));
    }
  }

//  ===== open chat
  Future<void> openChat() async {
    try {
      await Zendesk.setVisitorInfo(
          name: 'Text Client',
          email: 'test+client@example.com',
          phoneNumber: '0000000000',
          department: 'Support');
      await Zendesk.startChat(primaryColor: AppColor.base);
    } on dynamic catch (ex) {
      print('An error occured $ex');
    }
  }
}
