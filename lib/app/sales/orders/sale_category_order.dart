import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/button/customButton_cart.dart';
import 'package:uza_sales/app/retailer/card/product_card.dart';
import 'package:uza_sales/app/retailer/model/category_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uza_sales/app/retailer/model/product_model.dart';
import 'package:uza_sales/app/retailer/pages/ads_products.dart';
import 'package:uza_sales/app/retailer/provider/ads_provider.dart';
import 'package:uza_sales/app/retailer/provider/cart_provider.dart';
import 'package:uza_sales/app/retailer/provider/category_provider.dart';
import 'package:uza_sales/app/retailer/shimmers/shimmer_products.dart';
import 'package:uza_sales/app/retailer/widget/cart_dialog.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:uza_sales/app/sales/orders/show_category.dart';

class SaleCategoryOrder extends StatefulWidget {
  @override
  _SaleCategoryOrderState createState() => _SaleCategoryOrderState();
}

class _SaleCategoryOrderState extends State<SaleCategoryOrder> {
  ScrollController _scrollController = new ScrollController();

  int _current = 0;
  final CarouselController _controller = CarouselController();

  double selectedPrice = 0;
  int selectedQuantity = 0;
  double totalPrice = 0;
  String _price;
  String _discount;
  String _alphabet;
  final prices = ['lowest-highest', 'highest-lowest '];
  final discounts = ['on Discount', 'in Discount'];
  final alphabets = ['Ascending', 'Descending '];
  final List<String> _nameList = ['test'];
  List<Category> categories;
  List<Product> cart = [];

  @override
  void initState() {
    super.initState();
    totalPrice = 0;
  }

  @override
  Widget build(BuildContext context) {
    final _productProvider = Provider.of<CategoryProvider>(context);
    final ads = Provider.of<AdsProvider>(context);
    print(_nameList.toString());
    return Scaffold(
      // backgroundColor: Color(0xFFFFFCFC),
      backgroundColor: AppColor.bgScreen2,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context).topDeals,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF292C34)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: Utils.displayHeight(context) * 0.3,
                      color: AppColor.bgScreen2,
                      width: Utils.displayWidth(context),
                      child: CarouselSlider(
                          carouselController: _controller,
                          items: ads.availableAds.map((e) {
                            return Builder(
                              builder: (BuildContext context) {
                                return InkWell(
                                  onTap: () {
                                    print("  **  Mchele tapped:  $e ***  ");
                                    navigate(context, AdsProducts(), true);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                          'http://' + '${e.image}',
                                        ),
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      color: AppColor.bgScreen,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 30.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                    color: AppColor.preBase,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Icon(
                                                  Icons
                                                      .local_fire_department_sharp,
                                                  size: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                e.name,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            e.description,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            "50Kg kwa sh 45,000",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  height: 35,
                                                  width: 140,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF1F212C),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Order Now",
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .preBase),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .double_arrow_outlined,
                                                        color: AppColor.preBase,
                                                        size: 15,
                                                      )
                                                    ],
                                                  )),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: ads.availableAds
                                                    .asMap()
                                                    .entries
                                                    .map((entry) {
                                                  return GestureDetector(
                                                    onTap: () => _controller
                                                        .animateToPage(
                                                            entry.key),
                                                    child: Container(
                                                      width: 6.0,
                                                      height: 6.0,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8.0,
                                                              horizontal: 4.0),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: (Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark
                                                                  ? Colors.white
                                                                  : AppColor
                                                                      .preBase)
                                                              .withOpacity(
                                                                  _current ==
                                                                          entry
                                                                              .key
                                                                      ? 1
                                                                      : 0.2)),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                          options: CarouselOptions(
                              height: Utils.displayHeight(context) * 0.3,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: false,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              })),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Categories".toUpperCase(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF292C34)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ])),
            // CurrySliverHeader(Colors.green, "Sticky Header 1"),
            ShowCategoryHeader(
                AppColor.base, "Sticky Header 2", filterBuilder()),

            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  // height: Utils.displayHeight(context),
                  color: AppColor.bgScreen2,
                  child: _productProvider.availableProducts == null ||
                          _productProvider.availableProducts.length <= 0
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_basket_outlined),
                            SizedBox(
                              height: 10,
                            ),
                            Text("No available products yet")
                          ],
                        ))
                      : ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount:
                              _productProvider?.availableProducts?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    bottom: 10.0,
                                    top: 10.0),
                                child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) => productView(
                                              product: _productProvider
                                                  .availableProducts[index]));
                                    },
                                    child: _productProvider.isProductLoad
                                        ? ProductsShimmer()
                                        : ProductCard(
                                            product: _productProvider
                                                .availableProducts[index])));
                          }),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  navigate(BuildContext context, Widget screen, bool nav) {
    pushNewScreen(
      context,
      screen: screen,
      withNavBar: nav, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  Widget _buildList(Color color, String text) {
    return Container(
      height: 100,
      width: Utils.displayWidth(context),
      color: color,
      child: Center(
        child: Text(text),
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

  // filter bottom sheet
  Widget filterBuilder() {
    final category = Provider.of<CategoryProvider>(context);
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
                Text(
                  "Filter by Discount",
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
                              hint: Text("Filter  Discount"),
                              isExpanded: true,
                              onChanged: (String newValue) {
                                setState(() {
                                  _discount = newValue;
                                  // if(_discount = )
                                  print(_discount);
                                });
                              },
                              items: discounts.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item),
                                  value: item,
                                );
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 16),
                            )))),
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child:
          Text(item, style: TextStyle(fontSize: 14, color: Color(0xFF40403F))));
// Product view bottom sheet
  Widget productView({@required Product product}) {
    final cart = Provider.of<CartProvider>(context);
    return makeDismisible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.7,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
              color: AppColor.bgScreen,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 70),
            child: ListView(
              controller: controller,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  product.name,
                  style: TextStyle(color: Color(0xFF2D0C57), fontSize: 30),
                ),
                SizedBox(
                  height: 15,
                ),
                // Row(
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         RichText(
                //             text: TextSpan(children: <TextSpan>[
                //           TextSpan(
                //               text: "Tsh ",
                //               style: TextStyle(
                //                   color: AppColor.base, fontSize: 18)),
                //           TextSpan(
                //               text: '${product.primaryUnitPrice}',
                //               style: TextStyle(
                //                   color: Color(0xFF2D0C57), fontSize: 18)),
                //         ])),
                //         SizedBox(
                //           height: 5,
                //         ),
                //         Text(
                //           "${product.primaryUnit}",
                //           style:
                //               TextStyle(color: Color(0xFFAEAEAE), fontSize: 16),
                //         )
                //       ],
                //     ),
                //     SizedBox(
                //       width: 30,
                //     ),
                //     Container(
                //       height: 40,
                //       width: 0.5,
                //       color: Color(0xFFAEAEAE),
                //     ),
                //     SizedBox(
                //       width: 30,
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         RichText(
                //             text: TextSpan(children: <TextSpan>[
                //           TextSpan(
                //               text: "Tsh ",
                //               style: TextStyle(
                //                   color: AppColor.base, fontSize: 18)),
                //           TextSpan(
                //               text: '${product.secondaryUnitPrice}',
                //               style: TextStyle(
                //                   color: Color(0xFF2D0C57), fontSize: 18)),
                //         ])),
                //         SizedBox(
                //           height: 5,
                //         ),
                //         Text(
                //           "${product.secondaryUnit}",
                //           style:
                //               TextStyle(color: Color(0xFFAEAEAE), fontSize: 16),
                //         )
                //       ],
                //     ),
                //   ],
                // ),

                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        product.discount.status == "ACTIVE" &&
                                product.discount.originalPrice ==
                                    product.primaryUnitPrice
                            ? RichText(
                                text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "Tsh ",
                                    style: TextStyle(
                                        color: AppColor.base, fontSize: 18)),
                                TextSpan(
                                    text: '${product.discount.newPrice}',
                                    style: TextStyle(
                                        color: Color(0xFF2D0C57),
                                        fontSize: 18)),
                              ]))
                            : RichText(
                                text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "Tsh ",
                                    style: TextStyle(
                                        color: AppColor.base, fontSize: 18)),
                                TextSpan(
                                    text: '${product.primaryUnitPrice}',
                                    style: TextStyle(
                                        color: Color(0xFF2D0C57),
                                        fontSize: 18)),
                              ])),
                        SizedBox(
                          height: 5,
                        ),
                        product.discount.status == "ACTIVE" &&
                                product.discount.originalPrice ==
                                    product.primaryUnitPrice
                            ? Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: RichText(
                                    text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "Tsh ",
                                      style: TextStyle(
                                        color: Color(0xFF2D0C57),
                                        fontSize: 16,
                                        decoration: TextDecoration.lineThrough,
                                      )),
                                  TextSpan(
                                      text: '${product.discount.originalPrice}',
                                      style: TextStyle(
                                        color: Color(0xFF2D0C57),
                                        fontSize: 16,
                                        decoration: TextDecoration.lineThrough,
                                      )),
                                ])),
                              )
                            : Container(),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${product.primaryUnit}",
                          style:
                              TextStyle(color: Color(0xFFAEAEAE), fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      height: 50,
                      width: 0.5,
                      color: Color(0xFFAEAEAE),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        product.discount.status == "ACTIVE" &&
                                product.discount.originalPrice ==
                                    product.secondaryUnitPrice
                            ? RichText(
                                text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "Tsh ",
                                    style: TextStyle(
                                        color: AppColor.base, fontSize: 18)),
                                TextSpan(
                                    text: '${product.discount.newPrice}',
                                    style: TextStyle(
                                        color: Color(0xFF2D0C57),
                                        fontSize: 18)),
                              ]))
                            : RichText(
                                text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "Tsh ",
                                    style: TextStyle(
                                        color: AppColor.base, fontSize: 18)),
                                TextSpan(
                                    text: '${product.secondaryUnitPrice}',
                                    style: TextStyle(
                                        color: Color(0xFF2D0C57),
                                        fontSize: 18)),
                              ])),
                        SizedBox(
                          height: 1,
                        ),
                        product.discount.status == "ACTIVE" &&
                                product.discount.originalPrice ==
                                    product.secondaryUnitPrice
                            ? Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: RichText(
                                    text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "Tsh ",
                                      style: TextStyle(
                                        color: Color(0xFF2D0C57),
                                        fontSize: 12,
                                        decoration: TextDecoration.lineThrough,
                                      )),
                                  TextSpan(
                                      text: '${product.discount.originalPrice}',
                                      style: TextStyle(
                                        color: Color(0xFF2D0C57),
                                        fontSize: 16,
                                        decoration: TextDecoration.lineThrough,
                                      )),
                                ])),
                              )
                            : Container(),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${product.secondaryUnit}",
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
                  "${product.name}",
                  style: TextStyle(color: Color(0xFF9586A8)),
                ),
                SizedBox(
                  height: 40,
                ),
                CustomButttonCart(
                    label1: AppLocalizations.of(context).add_to_cart,
                    addtoCart: () {
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                              product: product,
                              title: "6 Bottles",
                              textBtn: AppLocalizations.of(context).add_to_cart,
                            );
                          });
                    },
                    label2: AppLocalizations.of(context).buy_now,
                    buyNow: () {
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                              product: product,
                              title: "6 Bottles/Carton",
                              textBtn: AppLocalizations.of(context).add_to_cart,
                            );
                          });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
