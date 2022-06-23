import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/pages/auth/welcome_page.dart';
import 'package:uza_sales/app/retailer/provider/cart_provider.dart';
import 'package:uza_sales/app/retailer/screen/cart_screenv2.dart';
import 'package:uza_sales/app/retailer/screen/retailer_home_screen.dart.dart';
import 'package:uza_sales/app/retailer/pages/deals_page.dart';
import 'package:uza_sales/app/retailer/screen/accounts_screen.dart';
import 'package:uza_sales/app/retailer/screen/cart_screen.dart';
import 'package:uza_sales/app/retailer/screen/orders_screen.dart';
import 'package:uza_sales/app/retailer/screen/signin_dialog.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  bool isAuth = false;
  String accessToken = "";
  _loadUsers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      this.accessToken = sharedPreferences.getString('accessToken');
      this.isAuth = sharedPreferences.getBool("isLoggedIn");

      print("*****  Auth user ****");
      print("isAuth: ${this.isAuth}");
    });
  }

  PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // backgroundColor: AppColor.bgScreen,
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(this.isAuth),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: AppColor.bgScreen, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(0.0),
            colorBehindNavBar: Colors.black,
            border: Border.all(color: Color(0xFFD9D0E3))),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style3, // Choose the nav bar style with this property.
      ),
    );
  }

  var cartPage = CartScreen();
  List<Widget> _buildScreens(bool isAuth) {
    return [
      RetailerHomeScreen(),
      cartPage,
      OrdersScreen(),
      DealsPage(),
      AccountScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    final cart = Provider.of<CartProvider>(context);
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.grid_view),
        title: ("Home"),
        activeColorPrimary: AppColor.base,
        inactiveColorPrimary: Color(0xFF9586A8),
        //contentPadding: 30
      ),
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.shopping_cart),
          title: ("Cart"),
          activeColorPrimary: AppColor.base,
          inactiveColorPrimary: Color(0xFF9586A8),
          onPressed: (val) {
            if (this.isAuth == true) {
              // cart.clear();
              cart.sendCartsData();
              _controller.jumpToTab(1);
              //cartPage.test();
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SigninDialog(
                        desc:
                            "Please click OKAY to SIGN UP/SIGN IN or BACK to remain in this page.",
                        ok: "Okay",
                        cancel: "Back",
                        cancelChange: () {
                          Navigator.pop(context);
                        },
                        okChange: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomePage()));
                        });
                  });
            }
          }),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.card_giftcard_outlined),
          title: ("Orders"),
          activeColorPrimary: AppColor.base,
          inactiveColorPrimary: Color(0xFF9586A8),
          onPressed: (a) {
            if (this.isAuth == true) {
              _controller.jumpToTab(2);
            } else {
              // _controller.jumpToTab(0);

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SigninDialog(
                        desc:
                            "Please click OKAY to SIGN UP/SIGN IN or BACK to remain in this page.",
                        ok: "Okay",
                        cancel: "Back",
                        cancelChange: () {
                          Navigator.pop(context);
                        },
                        okChange: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomePage()));
                        });
                  });
            }
          }),
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesomeIcons.tags),
        title: ("Deals"),
        activeColorPrimary: AppColor.base,
        inactiveColorPrimary: Color(0xFF9586A8),
      ),
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.person),
          title: ("Profile"),
          activeColorPrimary: AppColor.base,
          inactiveColorPrimary: Color(0xFF9586A8),
          onPressed: (a) {
            if (this.isAuth == true) {
              _controller.jumpToTab(4);
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SigninDialog(
                        desc:
                            "Please click OKAY to SIGN UP/SIGN IN or BACK to remain in this page.",
                        ok: "Okay",
                        cancel: "Back",
                        cancelChange: () {
                          Navigator.pop(context);
                        },
                        okChange: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomePage()));
                        });
                  });
            }
          })
    ];
  }
  // Widget signiDialog(context) {
  //   return
  // }
}
