import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:uza_sales/app/sales/pages/checkIn_page.dart';
import 'package:uza_sales/app/sales/pages/return_goods.dart';
import 'package:uza_sales/app/sales/pages/product_quantity.dart';
import 'package:uza_sales/app/sales/pages/stock_availability.dart';

class OrderDropdownWidget extends StatefulWidget {
  @override
  _OrderDropdownWidgetState createState() => _OrderDropdownWidgetState();
}

class _OrderDropdownWidgetState extends State<OrderDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    String _value;
    return DropdownButtonHideUnderline(
        child: Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: DropdownButton<String>(
        items: [
          DropdownMenuItem<String>(
            value: "1",
            child:
                Text("Make Order", style: TextStyle(color: Color(0xFF9B9C9B))),
          ),
          DropdownMenuItem<String>(
            value: "2",
            child: Text("Check Orders",
                style: TextStyle(color: Color(0xFF9B9C9B))),
          ),
          DropdownMenuItem<String>(
            value: "3",
            child: Text("Check In", style: TextStyle(color: Color(0xFF9B9C9B))),
          ),
          DropdownMenuItem<String>(
            value: "4",
            child: Text("Return Goods",
                style: TextStyle(color: Color(0xFF9B9C9B))),
          ),
          DropdownMenuItem<String>(
            value: "5",
            child:
                Text("Add Stock", style: TextStyle(color: Color(0xFF9B9C9B))),
          ),
          DropdownMenuItem<String>(
            value: "6",
            child:
                Text("Edit Shop", style: TextStyle(color: Color(0xFF9B9C9B))),
          ),
          DropdownMenuItem<String>(
            value: "7",
            child: Text(
              "Pos Visibilty",
              style: TextStyle(color: Color(0xFF9B9C9B)),
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _value = value;
            if (_value == "1") {
              // navigate(context, FaqWidget(), true);
            } else if (_value == "2") {
              // navigate(context, StockAvailability(), true);
            } else if (_value == "3") {
              // navigate(context, CheckInPage(), true);
            } else if (_value == "4") {
              // navigate(context, ReturnGoods(products: this.widget.,), true);
            } else if (_value == "5") {
              navigate(context, StockAvailability(), true);
            } else if (_value == "6") {
              // navigate(context, TermsConditionWidget(), true);
            } else {
              // navigate(context, StockAvailability(), true);

            }
          });
        },
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        value: _value,
        // elevation: 2,
        // style: TextStyle(color: PURPLE, fontSize: 30),
        // isDense: true,
        // iconSize: 40.0,
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
}
