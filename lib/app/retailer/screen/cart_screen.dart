import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:uza_sales/app/retailer/model/store_cart.dart';
import 'package:uza_sales/app/retailer/pages/auth/welcome_page.dart';
import 'package:uza_sales/app/retailer/screen/retailer_home_screen.dart.dart';
import 'package:uza_sales/app/retailer/pages/order_page.dart';
import 'package:uza_sales/app/retailer/provider/cart_provider.dart';
import 'package:uza_sales/app/retailer/provider/order_provider.dart';
import 'package:uza_sales/app/retailer/shimmers/shimmer_products.dart';
import 'package:uza_sales/app/retailer/widget/cart/cart_item_list.dart';
import 'package:uza_sales/app/retailer/widget/cart/cart_items_card.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/loading.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  //     var numberFormat = NumberFormat('#,##,000.00');

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
    // final order = Provider.of<OrderProvider>(context);
    return Scaffold(
        backgroundColor: AppColor.bgScreen2,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: cart.storesCarts.length <= 0 || cart.storesCarts == null
                ? Container(
                    // color: Colors.blue,
                    width: Utils.displayWidth(context),
                    height: Utils.displayHeight(context),
                    child: Center(
                        child: Column(
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
                    )))
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
                        height: Utils.displayHeight(context) * 0.03,
                      ),
                      Container(
                        height: Utils.displayHeight(context) * 0.6,
                        // color: Colors.grey,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cart.storesCarts.length,
                            itemBuilder: (context, s) {
                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 60,
                                      width: Utils.displayWidth(context),
                                      // color: Colors.blue,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Text(
                                              cart.storesCarts[s]
                                                  .distributorName,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30.0, right: 30.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)
                                                      .product,
                                                  style: TextStyle(
                                                      color: AppColor.text,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)
                                                      .qty,
                                                  style: TextStyle(
                                                      color: AppColor.text,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)
                                                      .unit,
                                                  style: TextStyle(
                                                      color: AppColor.text,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "Price",
                                                  style: TextStyle(
                                                      color: AppColor.text,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                        children: cart
                                            .storesCarts[s].cartResponse
                                            .map((item) {
                                      // var _index = cart
                                      //     .storesCarts[s].cartResponse
                                      //     .indexOf(item);
                                      return Container(
                                          // color: Colors.lightBlue,
                                          height: Utils.displayHeight(context) *
                                              0.1,
                                          child: CartItemsCard(
                                            cart: item,
                                          )
                                          //})
                                          );
                                    }).toList()),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 10.0,
                                          top: 5.0,
                                          bottom: 5.0),
                                      child: Divider(color: Colors.black45),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 60.0),
                                      child: Row(
                                        children: [
                                          _targetOrder(
                                              initial: cart.storesCarts[s]
                                                  .minimumAmountPerOrder),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "You have not reached minimum order of Tsh ${cart.storesCarts[s].minimumAmountPerOrder}",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    pushNewScreen(
                                                      context,
                                                      screen:
                                                          RetailerHomeScreen(),
                                                      withNavBar:
                                                          true, // OPTIONAL VALUE. True by default.
                                                      pageTransitionAnimation:
                                                          PageTransitionAnimation
                                                              .cupertino,
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        size: 15.0,
                                                        color: AppColor.base,
                                                      ),
                                                      Text(
                                                        "Add Products",
                                                        style: TextStyle(
                                                            color:
                                                                AppColor.base),
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
                              );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 10.0, top: 10.0, bottom: 10.0),
                        child: Divider(color: Colors.black45),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Total".toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: ' (VAT & Transport)',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                            ])),
                            RichText(
                                text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Tsh  ",
                                  style: TextStyle(
                                      color: AppColor.base, fontSize: 18)),
                              TextSpan(
                                  text:
                                      "${numberFormat.format(cart.totalAmount)}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.text)),
                            ]))
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
                                color: AppColor.base,
                                size: 16,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                AppLocalizations.of(context).add_more_product,
                                style: TextStyle(
                                    color: AppColor.base,
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
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Center(
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60.0)),
                            color: Theme.of(context).primaryColor,
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
                              AppLocalizations.of(context)
                                  .get_bill
                                  .toUpperCase(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
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
        height: Utils.displayHeight(context) * 0.2,
        child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, i) {
              return CartItemList(
                id: '${cart.items.values.toList()[i].id}',
                name: '${cart.items.values.toList()[i].name}',
                price: cart.items.values.toList()[i].price,
                productId: '${cart.items.keys.toList()[i]}',
                type: '${cart.items.values.toList()[i].type}',
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

  void test() {
    print("This is test from home");
  }
}
