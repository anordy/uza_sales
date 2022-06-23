import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uza_sales/app/retailer/button/custom_buton.dart';
import 'package:uza_sales/app/retailer/pages/auth/login_page.dart';
import 'package:uza_sales/app/retailer/pages/home_page.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';

import '../../../orderBooker/pages/booker_create_shop.dart';


class WelcomePage extends StatefulWidget {
  _WelcomePage createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgScreen,
      body: GestureDetector(
          onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     Container(
                      // color: Colors.green,
                      height: 110,
                      width: 200,
                      child:
                          Image(image: AssetImage("assets/icons/v1.png")),
                    ),
                    ],
                  ),
                ),
              ),
              //   CustomButton(
              //   color: AppColor.base,
              //   height: 60,
              //   width: Utils.displayWidth(context) * 0.65,
              //   inputText: Text(
              //   "Sales".toUpperCase(),
              //   style: TextStyle(color: Colors.white, fontSize: 16),
              // ),
              //   onPressed: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => SalesHome()));
              //   },
              // ),
              SizedBox(height: 10,),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomButton(
                color: AppColor.base,
                height: 60,
                width: Utils.displayWidth(context) * 0.65,
                inputText: Text(
                AppLocalizations.of(context).create_shop.toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
                onPressed: () {
                   Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BookerCreateShop()));
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => SignupPage()));
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(AppLocalizations.of(context).or,style: TextStyle(color: Color(0xFF40403F),fontSize: 14),),
               SizedBox(
                height: 10,
              ),
             Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(60),
                 border: Border.all(color: AppColor.base)
               ),
               child: MaterialButton(
                  shape: RoundedRectangleBorder(   
                    borderRadius: BorderRadius.circular(60.0)),
                color: Colors.white,
                height: 58,
                minWidth: Utils.displayWidth(context) * 0.65,
                child: Text(AppLocalizations.of(context).login.toUpperCase(),style: TextStyle(color: Color(0xFF40403F),fontSize: 16),),
                 onPressed: () {
                   Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                 }
               ),
             ),
               SizedBox(
                height: 10,
              ),
              TextButton(onPressed: () {
                 Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
              }, child: Text(AppLocalizations.of(context).skip.toUpperCase(),style: TextStyle(color: Color(0xFF40403F),fontSize: 16),)),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ))

      // ),
    );
  }
}
