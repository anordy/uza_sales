import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uza_sales/app/orderBooker/pages/booker_home.dart';
import 'package:uza_sales/app/retailer/network/api.dart';
import 'package:uza_sales/app/retailer/pages/auth/welcome_page.dart';
import 'package:uza_sales/app/retailer/pages/retailer_create_shop.dart.dart';
import 'package:uza_sales/app/retailer/pages/home_page.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uza_sales/app/sales/pages/sales_home.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  String accessToken;
  _checkIfUserIsLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreferences.getBool("isLoggedIn");
    bool isSupplier = sharedPreferences.getBool("isSupplier");
    bool isRetailer = sharedPreferences.getBool("isRetailer");
    bool isOrderBooker = sharedPreferences.getBool("isOrderBooker");

    accessToken = sharedPreferences.getString("accessToken");
    String firebaseToken = sharedPreferences.getString("firebaseToken");
    print(isLoggedIn);
    print("====== splash access token=======");
    print(sharedPreferences.getString("accessToken"));
    // if (isLoggedIn) {
    //   print("============ send firebase token  =============");
    //   await sendFirebaseToken(firebaseToken);
    // }
    if (isLoggedIn != null && isLoggedIn && isSupplier != null && isSupplier) {
      print("======== isSupplier ========");
      await sendFirebaseToken(firebaseToken);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SalesHome()));
    } else if (isLoggedIn != null &&
        isLoggedIn &&
        isRetailer != null &&
        isRetailer) {
      print("======= isRetailer ======");
      await sendFirebaseToken(firebaseToken);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else if (isLoggedIn != null &&
        isLoggedIn &&
        isOrderBooker != null &&
        isOrderBooker) {
      print("======= isOrderBooker ======");
      await sendFirebaseToken(firebaseToken);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BookerHome()));
    } else {
      print("islogged out");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomePage()));
    }
  }

  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      _checkIfUserIsLoggedIn();
      print("after splash");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.white),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      // color: Colors.green,
                      height: 110,
                      width: 200,
                      child: Image(image: AssetImage("assets/icons/v1.png")),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      // color: Colors.green,
                      height: 121,
                      width: 147,
                      child: Image.asset("assets/icons/f1.png"),
                    ),
                  )
                ],
              )
            ],
          ),
        ));

    // Scaffold(
    //   backgroundColor: AppColor.bgScreen,
    //   body: SafeArea(
    //     child: Stack(
    //       children: [
    //         Positioned(
    //           top: Utils.displayHeight(context) * 0.1,
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 45),
    //             child: Column(
    //               children: [
    //                 Container(
    //                     // color: Colors.green,
    //                     height: Utils.displayHeight(context) * 0.09,
    //                     width: Utils.displayWidth(context) * 0.8,
    //                     child: Image(image: AssetImage("assets/icons/prelogo.png")),
    //                     ),
    //                 SizedBox(
    //                   height: Utils.displayHeight(context) * 0.5,
    //                 ),
    //                 Container(
    //                     // color: Colors.green,
    //                     // height: Utils.displayHeight(context) * 0.7,
    //                     width: Utils.displayWidth(context) * 0.8,
    //                     child: Column(
    //                       children: [
    //                         Image.asset("assets/icons/Frame.png"),
    //                         SizedBox(
    //                           height: 20,
    //                         ),
    //                       ],
    //                     )),
    //                 // SizedBox(height: 20,),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // ));
  }

  void sendFirebaseToken(String firebaseToken) async {
    var url = Uri.parse(api + "user/firebase-token");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode({"token": firebaseToken}));
    print("Response firebase token  ${response.body}");
  }
}
