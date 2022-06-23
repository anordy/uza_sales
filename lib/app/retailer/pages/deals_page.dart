import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/button/customButton_cart.dart';
import 'package:uza_sales/app/retailer/card/deals_card.dart';
import 'package:uza_sales/app/retailer/model/deals_model.dart';
import 'package:uza_sales/app/retailer/provider/ads_provider.dart';
import 'package:uza_sales/app/retailer/provider/cart_provider.dart';
import 'package:uza_sales/app/retailer/provider/category_provider.dart';
import 'package:uza_sales/app/retailer/shimmers/shimmer_products.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../screen/cart_screen.dart';

class DealsPage extends StatefulWidget {
  const DealsPage({Key key}) : super(key: key);

  @override
  _DealsPageState createState() => _DealsPageState();
}

class _DealsPageState extends State<DealsPage> {
  var numberFormat = NumberFormat('#,##,000.00');

  String _price;
  String _discount;
  String _alphabet;
  final prices = ['lowest-highest', 'highest-lowest '];
  final discounts = ['on Discount', 'in Discount'];
  final alphabets = ['Ascending', 'Descending '];
  @override
  Widget build(BuildContext context) {
    final _productProvider = Provider.of<CategoryProvider>(context);
    final _deals = Provider.of<AdsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    print("deals we good");
    print(_deals.availableDeals);
    return Scaffold(
      backgroundColor: AppColor.bgScreen2,
      body: Column(
        children: [
          SizedBox(
            height: Utils.displayHeight(context) * 0.85,
            width: Utils.displayWidth(context),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverStickyHeader(
                  header: Container(
                    color: AppColor.bgScreen2,
                    height: 170,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 35.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).deals,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF292C34)),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                                border: Border.all(color: AppColor.border)),
                            width: Utils.displayWidth(context),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: Color(0xFF000000),
                                          ),
                                          hintText: "Search Deals",
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (text) {
                                          _productProvider.fetchProducts(
                                              "", "", text, "");
                                        },
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (context) =>
                                                filterBuilder());
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(50),
                                                bottomRight:
                                                    Radius.circular(50)),
                                            border: Border.all(
                                                color: AppColor.border)),
                                        width:
                                            Utils.displayWidth(context) * 0.25,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(Icons.filter_alt_outlined,
                                                color: Color(0xFF000000)),
                                            Text(
                                              AppLocalizations.of(context)
                                                  .filter,
                                              style: TextStyle(
                                                  color: Color(0xFF000000)),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  sliver: SliverList(
                      delegate: SliverChildListDelegate([
                    Container(
                      // height: Utils.displayHeight(context),
                      // color: Colors.green,
                      child: _deals.availableDeals == null ||
                              _deals.availableDeals.length <= 0
                          ? Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: Utils.displayHeight(context) * 0.23,
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
                            ))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: _deals.availableDeals.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0, bottom: 20.0),
                                    child: InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) => productView(
                                                  deals: _deals
                                                      .availableDeals[index]));
                                        },
                                        child: _deals.isDealLoading
                                            ? ProductsShimmer()
                                            : DealsCard(
                                                deals: _deals
                                                    .availableDeals[index])));
                              }),
                    ),
                  ])),
                ),
              ],
            ),
          ),
          cartProvider.items.length <= 0 || cartProvider.items.length == null
              ? Container()
              : Container(
                  height: Utils.displayHeight(context) * .07,
                  width: Utils.displayWidth(context),
                  color: AppColor.success,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          CupertinoIcons.shopping_cart,
                          color: Colors.white,
                        ),
                        Container(
                          height: 40,
                          width: 1,
                          color: Colors.white,
                        ),
                        Text(
                          "Items: ${cartProvider.itemCount}",
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          height: 40,
                          width: 1,
                          color: Colors.white,
                        ),
                        Text(
                            "Total: ${numberFormat.format(cartProvider.totalAmount)} Tsh",
                            style: TextStyle(color: Colors.white)),
                        Container(
                          height: 40,
                          width: 1,
                          color: Colors.white,
                        ),
                        TextButton(
                            onPressed: () {
                              pushNewScreen(
                                context,
                                screen: CartScreen(),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("View Cart",
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.double_arrow_outlined,
                                  color: Colors.white,
                                  size: 15,
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Widget makeDismisible({@required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

  // =================  filter bottom sheet  =========
  Widget filterBuilder() {
    final category = Provider.of<CategoryProvider>(context);
    return makeDismisible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.5,
        maxChildSize: 0.6,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 80),
            child: ListView(
              controller: controller,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Filter by Price",
                  style: TextStyle(color: Color(0xFF40403F)),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    width: Utils.displayWidth(context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFFC7D3DD))),
                    child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              icon: Icon(FontAwesomeIcons.chevronDown,
                                  color: Colors.black, size: 16),
                              value: _discount,
                              hint: Text("Filter  Price"),
                              isExpanded: true,
                              onChanged: (String newValue) {
                                setState(() {
                                  _price = newValue;
                                  if (_price == "lowest-highest") {
                                    print("descending");
                                    category.fetchProducts(
                                        "", "", "", "price,asc");
                                    Navigator.of(context).pop();
                                  } else {
                                    print("ascending");
                                    category.fetchProducts(
                                        "", "", "", "price,desc");
                                    Navigator.of(context).pop();
                                  }
                                  print(_price);
                                });
                              },
                              items: prices.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item),
                                  value: item,
                                );
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 16),
                            )))),
                SizedBox(height: 25.0),
                // Text(
                //   "Filter by Discount",
                //   style: TextStyle(color: Color(0xFF40403F)),
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // Container(
                //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                //     width: Utils.displayWidth(context),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         border: Border.all(color: Color(0xFFC7D3DD))),
                //     child: DropdownButtonHideUnderline(
                //         child: ButtonTheme(
                //             alignedDropdown: true,
                //             child: DropdownButton<String>(
                //               icon: Icon(FontAwesomeIcons.chevronDown,
                //                   color: Colors.black, size: 16),
                //               value: _discount,
                //               hint: Text("Filter  Discount"),
                //               isExpanded: true,
                //               onChanged: (String newValue) {
                //                 setState(() {
                //                   _discount = newValue;
                //                   // if(_discount = )
                //                   print(_discount);
                //                 });
                //               },
                //               items: discounts.map((item) {
                //                 return new DropdownMenuItem(
                //                   child: new Text(item),
                //                   value: item,
                //                 );
                //               }).toList(),
                //               style: TextStyle(
                //                   color: Colors.black45, fontSize: 16),
                //             )))),

                SizedBox(height: 25.0),
                Text(
                  "Filter by Alphabet",
                  style: TextStyle(color: Color(0xFF40403F)),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    width: Utils.displayWidth(context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFFC7D3DD))),
                    child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              icon: Icon(FontAwesomeIcons.chevronDown,
                                  color: Colors.black, size: 16),
                              value: _alphabet,
                              hint: Text("Filter  Alphabet"),
                              isExpanded: true,
                              onChanged: (String newValue) {
                                setState(() {
                                  _alphabet = newValue;
                                  print(_alphabet);
                                  if (_alphabet == "Ascending") {
                                    print("descending");
                                    category.fetchProducts(
                                        "", "", "", "name,asc");
                                    Navigator.of(context).pop();
                                  } else {
                                    print("ascending");
                                    category.fetchProducts(
                                        "", "", "", "name,desc");
                                    Navigator.of(context).pop();
                                  }
                                });
                              },
                              items: alphabets.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item),
                                  value: item,
                                );
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 16),
                            )))),
                SizedBox(
                  height: 45.0,
                ),
                Center(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0)),
                    color: Theme.of(context).primaryColor,
                    height: 50,
                    minWidth: Utils.displayWidth(context) * 0.4,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Apply'.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// ProductModel view bottom sheet
  Widget productView({
    @required Deals deals,
  }) {
    final cart = Provider.of<CartProvider>(context);
    return makeDismisible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.7,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 70),
            child: ListView(
              controller: controller,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  deals.name,
                  style: TextStyle(color: Color(0xFF2D0C57), fontSize: 30),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Tsh ",
                              style: TextStyle(
                                  color: AppColor.base, fontSize: 18)),
                          TextSpan(
                              text: "${deals.price}",
                              style: TextStyle(
                                  color: Color(0xFF2D0C57), fontSize: 18)),
                        ])),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${deals.product.primaryUnit}",
                          style:
                              TextStyle(color: Color(0xFFAEAEAE), fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      height: 40,
                      width: 0.5,
                      color: Color(0xFFAEAEAE),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Tsh ",
                              style: TextStyle(
                                  color: AppColor.base, fontSize: 18)),
                          TextSpan(
                              text: "${deals.product.secondaryUnitPrice}",
                              style: TextStyle(
                                  color: Color(0xFF2D0C57), fontSize: 18)),
                        ])),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${deals.product.secondaryUnit}",
                          style:
                              TextStyle(color: Color(0xFFAEAEAE), fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Mbeya",
                  style: TextStyle(color: Color(0xFF2D0C57), fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pretium purus cras venenatis sit non, proin. Ipsum ac dapibus montes, elementum. Amet, enim porttitor a malesuada. Nisi erat fermentum a, sed vestibulum. Tellus in ultricies ullamcorper accumsan tristique elementum tellus vel sed.",
                  style: TextStyle(color: Color(0xFF9586A8)),
                ),
                SizedBox(
                  height: 40,
                ),
                CustomButttonCart(
                    label1: "Add to Cart",
                    addtoCart: () {
                      // cart.addItem(product.id, product.name, product.primaryUnitPrice,product.secondaryUnit);
                      Navigator.of(context).pop();
                      // // showDialog(
                      // //     context: context,
                      // //     builder: (BuildContext context) {
                      // //       return CustomDialogBox(
                      // //         product: deals,
                      // //         title: "6 Bottles/Carton",
                      // //         textBtn: AppLocalizations.of(context).add_to_cart,
                      // //       );
                      //     });
                    },
                    label2: "Buy Now",
                    buyNow: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
