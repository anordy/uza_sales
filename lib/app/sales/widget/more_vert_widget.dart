import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:oktoast/oktoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/sales/model/route_model.dart';
import 'package:uza_sales/app/sales/orders/sale_category_order.dart';
import 'package:uza_sales/app/sales/pages/checkIn_page.dart';
import 'package:uza_sales/app/sales/pages/edit_routes_store.dart';
import 'package:uza_sales/app/sales/pages/pos/pos_visibility_page.dart';
import 'package:uza_sales/app/sales/pages/stock_availability.dart';
import 'package:uza_sales/app/sales/provider/visit_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoreVertWidget extends StatefulWidget {
  final MyRoute routes;
  final SalesStore stores;

  const MoreVertWidget({Key key, @required this.routes, @required this.stores})
      : super(key: key);
  @override
  _MoreVertWidgetState createState() => _MoreVertWidgetState();
}

class _MoreVertWidgetState extends State<MoreVertWidget> {
  String visitId;
  bool isCheckIn = false;
  String storeId;
  TextEditingController _checkoutController = TextEditingController();

  _loadVisitId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    visitId = sharedPreferences.getString("visitId");
    isCheckIn = sharedPreferences.getBool("isCheckIn");
    storeId = sharedPreferences.getString("storeId");
    if (isCheckIn == null) {
      isCheckIn = false;
    }
    print("======  visit id =======");
    print("visitId $visitId");
    print("isCheckin: $isCheckIn");
    print("storeId $storeId");
  }

  @override
  void initState() {
    super.initState();
    _loadVisitId();
    _checkoutController.text = Jiffy(DateTime.now()).format('yyyy-MM-dd hh:mm');
    print(_checkoutController.text);
  }

  @override
  Widget build(BuildContext context) {
    final _visitProvider = Provider.of<VisitProvider>(context);
    String _value;
    return DropdownButtonHideUnderline(
        child: Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: DropdownButton<String>(
        items: [
          DropdownMenuItem<String>(
            value: "1",
            child: Text("Checkin", style: TextStyle(color: Color(0xFF9B9C9B))),
          ),
          DropdownMenuItem<String>(
            value: "2",
            child: Text(AppLocalizations.of(context).make_orders,
                style: TextStyle(color: Color(0xFF9B9C9B))),
          ),
          DropdownMenuItem<String>(
            value: "3",
            child: Text(AppLocalizations.of(context).pos_visibility,
                style: TextStyle(color: Color(0xFF9B9C9B))),
          ),
          // DropdownMenuItem<String>(
          //   value: "4",
          //   child: Text("Return Goods",
          //       style: TextStyle(color: Color(0xFF9B9C9B))),
          // ),
          DropdownMenuItem<String>(
            value: "4",
            child: Text(AppLocalizations.of(context).competitor_analysis,
                style: TextStyle(color: Color(0xFF9B9C9B))),
          ),
          DropdownMenuItem<String>(
            value: "5",
            child: Text(AppLocalizations.of(context).stock_availability,
                style: TextStyle(color: Color(0xFF9B9C9B))),
          ),
          DropdownMenuItem<String>(
            value: "6",
            child: Text(
              AppLocalizations.of(context).edit_shop,
              style: TextStyle(color: Color(0xFF9B9C9B)),
            ),
          ),
          DropdownMenuItem<String>(
            value: "7",
            child: Text(
              "Checkout",
              style: TextStyle(color: Color(0xFF9B9C9B)),
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _value = value;
            if (_value == "1") {
              print("=========== checkin =============");
              if (!isCheckIn) {
                navigate(
                    context,
                    CheckInPage(
                      routes: this.widget.routes,
                      stores: this.widget.stores,
                    ),
                    true);
                // print(
                //     "==========  checkout first on other stores   ===========");
              } else {
                // showToast(context);

                print("isCheckIn   $isCheckIn");
                print("storeId $storeId");
                print("stores.id: ${this.widget.stores.id}");
              }
              _loadVisitId();
            } else if (_value == "2") {
              if (isCheckIn && storeId == this.widget.stores.id) {
                navigate(context, SaleCategoryOrder(), true);
              } else {
                // showToast(context);
                print("isCheckIn   $isCheckIn");
                print("storeId $storeId");
                print("stores.id: ${this.widget.stores.id}");
                // navigate(context, SaleCategoryOrder(), true);
              }
            } else if (_value == "3") {
              if (isCheckIn && storeId == this.widget.stores.id) {
                navigate(context, PosVisibilityPage(stores: this.widget.stores),
                    true);
              } else {
                // showToast(context);
              }
              _loadVisitId();
            } else if (_value == "4") {
              // if (isCheckIn && storeId == this.widget.stores.id) {
              //   navigate(context, PosVisibilityPage(stores: this.widget.stores),
              //       true);
              // } else {
              //   showToast(context);
              // }
              // _loadVisitId();
            } else if (_value == "5") {
              if (isCheckIn && storeId == this.widget.stores.id) {
                navigate(context, StockAvailability(), true);
              } else {
                // showToast(context);
              }
              _loadVisitId();
            } else if (_value == "6") {
              print("=========== Edit Shop =============");
              if (isCheckIn && storeId == this.widget.stores.id) {
                navigate(
                    context,
                    EditRoutesStore(
                      stores: this.widget.stores,
                    ),
                    true);
              } else {
                // showToast(context);
              }

              _loadVisitId();
            } else if (_value == "7") {
              print("=========== checkout time =============");
              if (isCheckIn && storeId == this.widget.stores.id) {
                _visitProvider.checkOut();
              } else {
                // showToast(context);
                _visitProvider.checkOut();
              }
              _loadVisitId();
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

  showToast(BuildContext context) {
    return showToastWidget(
      ToastWidget(
          icon: Icon(
            Icons.done,
            color: Colors.white,
            size: 15,
          ),
          height: 50,
          width: 250,
          color: AppColor.success,
          description: "Please checkin first"),
      duration: Duration(seconds: 2),
      position: ToastPosition.bottom,
    );
  }
}
