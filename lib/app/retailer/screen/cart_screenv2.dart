import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:uza_sales/app/retailer/pages/order_page.dart';
import 'package:uza_sales/app/retailer/provider/cart_provider.dart';
import 'package:uza_sales/app/retailer/provider/order_provider.dart';
import 'package:uza_sales/app/retailer/widget/cart/cart_item_list.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class CartScreenv2 extends StatefulWidget {
  const CartScreenv2({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreenv2> {
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
        backgroundColor: AppColor.bgScreen,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
              child: Container(
                height: Utils.displayHeight(context) * 0.45,
                width: Utils.displayWidth(context),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 4,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Mangi Shop 01",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 40.0),
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
                            // Text(
                            //   AppLocalizations.of(context).unit,
                            //   style: TextStyle(
                            //       color: AppColor.text,
                            //       fontSize: 16,
                            //       fontWeight: FontWeight.w500),
                            // ),
                            Text(
                              "Price(Tzs)",
                              style: TextStyle(
                                  color: AppColor.text,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      _cartItemsList(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 10.0, top: 5.0, bottom: 5.0),
                        child: Divider(color: Colors.black45),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0),
                        child: Row(
                          children: [
                            _targetOrder(initial: 55),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "You have not reached minimum order \n amount of 50,000 Tsh",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.text,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          size: 15.0,
                                          color: AppColor.base,
                                        ),
                                        Text(
                                          "Add Products",
                                          style:
                                              TextStyle(color: AppColor.base),
                                        )
                                      ],
                                    ))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ))));
  }

  navigate(BuildContext context) {
    pushNewScreen(
      context,
      screen: OrderPage(),
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

// ====== CART ITEMS LIST ====
  Widget _cartItemsList() {
    final cart = Provider.of<CartProvider>(context);
    return Container(
        // color: Colors.lightBlue,
        height: Utils.displayHeight(context) * 0.15,
        child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, i) {
              return CartItemList(
                id: '${cart.items.values.toList()[i].id}',
                name: '${cart.items.values.toList()[i].name}',
                price: cart.items.values.toList()[i].price,
                productId: '${cart.items.keys.toList()[i]}',
                // type: '${cart.items.values.toList()[i].type}',
                quantity: cart.items.values.toList()[i].quantity,
              );
            }));
  }

// ====== TARGET WIDGET  =======
  Widget _targetOrder({double initial}) {
    return Container(
        height: 55.0,
        width: 55.0,
        child: SleekCircularSlider(
          min: 0,
          max: 100,
          initialValue: initial,
          appearance: CircularSliderAppearance(
              //  size: 360,
              //  startAngle: 360,
              angleRange: 360,
              infoProperties: InfoProperties(
                  mainLabelStyle:
                      TextStyle(color: Color(0xFF292C34), fontSize: 12)),
              customWidths: CustomSliderWidths(
                progressBarWidth: 5,
                trackWidth: 4,
              ),
              customColors: CustomSliderColors(
                progressBarColor: AppColor.preBase,
                trackColor: Color(0xFfE2E2E2),
                hideShadow: true,
                dynamicGradient: true,
                dotColor: AppColor.preBase,
              )),
          onChange: (double value) {
            print(value);
          },

          onChangeStart: (double startValue) {
            // callback providing a starting value (when a pan gesture starts)
          },
          onChangeEnd: (double endValue) {
            // ucallback providing an ending value (when a pan gesture ends)
          },
          // innerWidget: (double value) {
          //   // use your custom widget inside the slider (gets a slider value from the callback)
          // },
        ));
  }

// quantity widget
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
