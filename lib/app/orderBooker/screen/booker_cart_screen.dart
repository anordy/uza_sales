import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/orderBooker/orders/booker_sales_order.dart';
import 'package:uza_sales/app/retailer/pages/auth/welcome_page.dart';
import 'package:uza_sales/app/retailer/screen/retailer_home_screen.dart.dart';
import 'package:uza_sales/app/retailer/provider/cart_provider.dart';
import 'package:uza_sales/app/retailer/provider/order_provider.dart';
import 'package:uza_sales/app/retailer/widget/cart/cart_item_list.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:uza_sales/app/sales/orders/create_sales_order.dart';

class BookerCartScreen extends StatefulWidget {
  const BookerCartScreen({Key key}) : super(key: key);

  @override
  _BookerCartScreenState createState() => _BookerCartScreenState();
}

class _BookerCartScreenState extends State<BookerCartScreen> {
  var numberFormat = NumberFormat('#,##,000.00');

  int _qty = 1;
  bool isAuth = false;
  String accessToken = "";
  _loadUsers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      this.accessToken = sharedPreferences.getString('accessToken');
      this.isAuth = sharedPreferences.getBool("isLoggedIn");
      if (this.isAuth == null) {
        this.isAuth = false;
      }
      print("*****  Auth user");
      print("isAuth: ${this.isAuth}");
    });
  }

  // add quantity
  void _add() {
    setState(() {
      _qty += 1;
    });
  }

// remove quantity
  void _remove() {
    setState(() {
      if (_qty > 1) {
        _qty -= 1;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final order = Provider.of<OrderProvider>(context);
    return Scaffold(
        backgroundColor: AppColor.bgScreen2,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: cart.items.length <= 0 || cart.items == null
                ? Container(
                    // color: Colors.blue,
                    width: Utils.displayWidth(context),
                    height: Utils.displayHeight(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        CircleAvatar(
                          backgroundColor: AppColor.bgScreen,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.storefront_outlined,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Wow, Such Empty",
                                style: TextStyle(
                                    fontSize: 10, color: AppColor.text),
                              ),
                            ],
                          ),
                          radius: 50,
                        ),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          AppLocalizations.of(context).cart.toUpperCase(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context).product,
                              style: TextStyle(
                                  color: AppColor.text,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              AppLocalizations.of(context).qty,
                              style: TextStyle(
                                  color: AppColor.text,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              AppLocalizations.of(context).unit,
                              style: TextStyle(
                                  color: AppColor.text,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Price",
                              style: TextStyle(
                                  color: AppColor.text,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                        child: Divider(
                          color: Color(0xFFE5E5E5),
                        ),
                      ),
                      Container(
                          // color: Colors.lightBlue,
                          height: Utils.displayHeight(context) * 0.45,
                          child: ListView.builder(
                              itemCount: cart.items.length,
                              itemBuilder: (context, i) {
                                return CartItemList(
                                  id: '${cart.items.values.toList()[i].id}',
                                  name: '${cart.items.values.toList()[i].name}',
                                  price: cart.items.values.toList()[i].price,
                                  type: cart.items.values.toList()[i].type,
                                  productId: '${cart.items.keys.toList()[i]}',
                                  quantity:
                                      cart.items.values.toList()[i].quantity,
                                );
                              })),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 10.0, top: 10.0, bottom: 10.0),
                        child: Divider(color: Colors.black45),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context).total,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.text),
                            ),
                            Text(
                              "${numberFormat.format(cart.totalAmount)}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.text),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: InkWell(
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: RetailerHomeScreen(),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: AppColor.preBase,
                                size: 16,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                AppLocalizations.of(context).add_more_product,
                                style: TextStyle(
                                    color: AppColor.preBase,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60.0)),
                          color: AppColor.preBase,
                          height: 55,
                          minWidth: Utils.displayWidth(context) * 0.8,
                          onPressed: () {
                            if (this.isAuth) {
                              print("***** isAuthenticated");
                              navigate(context);
                            } else {
                              print("user not authenticated");
                              showToastWidget(
                                ToastWidget(
                                    icon: Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    height: 50,
                                    width: 280,
                                    color: AppColor.success,
                                    description:
                                        "Please Login in to continue shopping"),
                                duration: Duration(seconds: 3),
                                position: ToastPosition.bottom,
                              );
                              pushNewScreen(
                                context,
                                screen: WelcomePage(),
                                withNavBar:
                                    false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context).get_bill.toUpperCase(),
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        )));
  }

  navigate(BuildContext context) {
    pushNewScreen(
      context,
      screen: BookerSalesOrder(),
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  Widget _quantity({Function add, Function remove, int qty}) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
          height: Utils.displayHeight(context) * 0.05,
          width: Utils.displayWidth(context) * 0.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFFC7D3DD))),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$qty",
                  style: TextStyle(color: AppColor.text, fontSize: 18),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: add,
                      child: Icon(
                        FontAwesomeIcons.chevronUp,
                        size: 16,
                        color: AppColor.base,
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    InkWell(
                      onTap: _remove,
                      child: Icon(
                        FontAwesomeIcons.chevronDown,
                        color: AppColor.base,
                        size: 16,
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
