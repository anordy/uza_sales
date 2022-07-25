import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:uza_sales/app/orderBooker/model/booker_order_model.dart';
import 'package:uza_sales/app/orderBooker/orders/booker_category_order.dart';
import 'package:uza_sales/app/orderBooker/screen/booker_target_screen.dart';
import 'package:uza_sales/app/orderBooker/screen/booker_cart_screen.dart';
import 'package:uza_sales/app/orderBooker/screen/booker_profile_screen_.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uza_sales/app/orderBooker/screen/home_summary_screen.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';

class BookerHome extends StatefulWidget {
  @override
  _BookerHome createState() => _BookerHome();
}

class _BookerHome extends State<BookerHome> {
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
    return Scaffold(
      backgroundColor: AppColor.bgScreen,
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
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
  List<Widget> _buildScreens() {
    return [
      HomeSummaryScreen(),
      BookerCategoryOrder(),
      BookerCartScreen(),
      BookerProfileScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.grid_view),
        title: ("Home"),
        activeColorPrimary: AppColor.preBase,
        inactiveColorPrimary: Color(0xFF9586A8),
        //contentPadding: 30
      ),
       PersistentBottomNavBarItem(
        icon: Icon(Icons.card_giftcard_outlined),
        title: ("Order"),
        activeColorPrimary: AppColor.preBase,
        inactiveColorPrimary: Color(0xFF9586A8),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        title: ("Cart"),
        activeColorPrimary: AppColor.preBase,
        inactiveColorPrimary: Color(0xFF9586A8),
      ), 
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Profile"),
        activeColorPrimary: AppColor.preBase,
        inactiveColorPrimary: Color(0xFF9586A8),
      ),
    ];
  }

  resendSms() {}
}
