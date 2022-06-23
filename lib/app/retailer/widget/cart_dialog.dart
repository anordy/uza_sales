import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uza_sales/app/retailer/model/product_model.dart';
import 'package:uza_sales/app/retailer/pages/auth/welcome_page.dart';
import 'package:uza_sales/app/retailer/pages/order_page.dart';
import 'package:uza_sales/app/retailer/provider/cart_provider.dart';
import 'package:uza_sales/app/retailer/widget/signout-toast.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'colors.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class CustomDialogBox extends StatefulWidget {
  final Product product;
  final String title;
  final String textBtn;
  final Image img;

  const CustomDialogBox({
    Key key,
    this.title,
    this.img,
    this.textBtn,
    this.product,
  }) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  int _selected = 0;
  String total = '0.0';
  String _selectedUnit = "primary";
  double selectedPrice = 0.0;
  String status;
  int selectedQuantity = 1;
  bool isAuth = false;
  String accessToken = "";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _unitController;
  var numberFormat = NumberFormat('#,##,000.00');

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

  _onchangeUnit(newValue) {
    setState(() {
      this._selectedUnit = newValue;
      this.status = this.widget.product.status;
      this.selectedPrice = 0.0;
      if (newValue == "primary") {
        print("PrimaryUnit:  $_selectedUnit");
        print("PrimaryUnitPrice: $selectedPrice");
        if (this.status == "ACTIVE" &&
            this.widget.product.discount.originalPrice ==
                this.widget.product.primaryUnitPrice) {
          print("*** priimary discount ****");
          this.selectedPrice = this.widget.product.discount.newPrice;
        } else {
          this.selectedPrice = this.widget.product.primaryUnitPrice;
        }
      } else {
        print("SecondaryUnit:  $_selectedUnit");
        print("SecondaryUnitPrice: $selectedPrice");
        if (this.status == "ACTIVE" &&
            this.widget.product.discount.originalPrice ==
                this.widget.product.secondaryUnitPrice) {
          print("*** sec discunt ****");
          this.selectedPrice = this.widget.product.discount.newPrice;
        } else {
          this.selectedPrice = this.widget.product.secondaryUnitPrice;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _unitController = TextEditingController(text: "1");
    _onchangeUnit("primary");
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // elevation: 0,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    final cart = Provider.of<CartProvider>(context);
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              this.widget.product.image,
                            ),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: AppColor.bgScreen,
                        ),
                        // child: Image(image: AssetImage("assets/images/png")),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        '${this.widget.product.name}',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFFF7F8F9),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          this.widget.product.primaryUnit == 'None'
                              ? Container()
                              : GestureDetector(
                                  child: _selectedUnit == "primary"
                                      ? Container(
                                          width: Utils.displayWidth(context) *
                                              0.35,
                                          padding: EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              // border: Border.all(color: AppColor.base),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                )
                                              ],
                                              color: Colors.white),
                                          child: Center(
                                              child: Text(
                                            this
                                                .widget
                                                .product
                                                .primaryUnit
                                                .capitalize(),
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                        )
                                      : Container(
                                          width: Utils.displayWidth(context) *
                                              0.35,
                                          padding: EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.transparent),
                                          child: Center(
                                              child: Text(
                                            this
                                                .widget
                                                .product
                                                .primaryUnit
                                                .capitalize(),
                                            style: TextStyle(
                                                color: Colors.grey[400]),
                                          )),
                                        ),
                                  onTap: () {
                                    _onchangeUnit("primary");
                                    setState(() {
                                      cart.getTotalPrice(
                                          selectedPrice, selectedQuantity);
                                    });
                                  },
                                ),
                          this.widget.product.secondaryUnit == 'None'
                              ? Container()
                              : GestureDetector(
                                  child: _selectedUnit == "secondary"
                                      ? Container(
                                          width: Utils.displayWidth(context) *
                                              0.35,
                                          padding: EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                )
                                              ],
                                              color: Colors.white),
                                          child: Center(
                                              child: Text(
                                            this
                                                .widget
                                                .product
                                                .secondaryUnit
                                                .capitalize(),
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                        )
                                      : Container(
                                          width: Utils.displayWidth(context) *
                                              0.35,
                                          padding: EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.transparent),
                                          child: Center(
                                              child: Text(
                                            this
                                                .widget
                                                .product
                                                .secondaryUnit
                                                .capitalize(),
                                            style: TextStyle(
                                                color: Colors.grey[400]),
                                          )),
                                        ),
                                  onTap: () {
                                    _onchangeUnit("secondary");
                                    setState(() {
                                      cart.getTotalPrice(
                                          selectedPrice, selectedQuantity);
                                    });
                                  },
                                ),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Add Quantity",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFFE7E9E7),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColor.border)),
                      width: Utils.displayWidth(context) * 0.8,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: TextFormField(
                            controller: _unitController,
                            onChanged: (unit) {
                              print(unit);
                              selectedQuantity = int.parse(unit);
                              cart.getTotalPrice(
                                  selectedPrice, selectedQuantity);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "*";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              // hintText: "1",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Total Price",
                    style: TextStyle(color: AppColor.text, fontSize: 18),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${numberFormat.format(cart.totalPrice)}",
                    style: TextStyle(color: AppColor.text),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          // add to cart

                          if (_formKey.currentState.validate()) {
                            print("****** Add to Cart ****");
                            if (this.isAuth) {
                              print(" ******** user Authenticated ********");
                              cart.addItem(
                                  this.widget.product.id,
                                  this.widget.product.name,
                                  selectedPrice,
                                  _selectedUnit,
                                  selectedQuantity);

                              showToastWidget(
                                PleaseLoginToast(
                                    icon: Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    height: 50,
                                    width: 280,
                                    color: AppColor.success,
                                    description: "Your product has been added"),
                                duration: Duration(seconds: 2),
                                position: ToastPosition.bottom,
                              );
                              Navigator.pop(context);
                            } else {
                              print("user not authenticated");
                              showToastWidget(
                                PleaseLoginToast(
                                    icon: Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    height: 50,
                                    width: 280,
                                    color: AppColor.success,
                                    description: "Please Login to continue"),
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
                          } else {
                            print("NOt added to cart something went wrong");
                          }
                        },
                        child: Container(
                          height: 45,
                          width: Utils.displayWidth(context) * 0.35,
                          decoration: BoxDecoration(
                              color: AppColor.base,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).add_to_cart,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            print("******* Buy Now *******");

                            cart.addItem(
                                this.widget.product.id,
                                this.widget.product.name,
                                selectedPrice,
                                _selectedUnit,
                                selectedQuantity);
                            // showToastWidget(
                            //   ToastWidget(
                            //       icon: Icon(
                            //         Icons.done,
                            //         color: Colors.white,
                            //         size: 15,
                            //       ),
                            //       height: 50,
                            //       width: 280,
                            //       color: AppColor.success,
                            //       description: "Your product has been added"),
                            //   duration: Duration(seconds: 2),
                            //   position: ToastPosition.bottom,
                            // );

                            navigate(context);
                          } else {
                            print("Not Buying to cart something went wrong");
                          }
                        },
                        child: Container(
                          height: 45,
                          width: Utils.displayWidth(context) * 0.35,
                          decoration: BoxDecoration(
                              color: AppColor.sideBase,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).buy_now,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )

                      //

                      )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  navigate(BuildContext context) {
    pushNewScreen(
      context,
      screen: OrderPage(),
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
