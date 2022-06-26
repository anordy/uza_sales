import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/button/customButton_cart.dart';
import 'package:uza_sales/app/retailer/card/product_card.dart';
import 'package:uza_sales/app/retailer/model/product_model.dart';
import 'package:uza_sales/app/retailer/provider/cart_provider.dart';
import 'package:uza_sales/app/retailer/provider/category_provider.dart';
import 'package:uza_sales/app/retailer/shimmers/shimmer_products.dart';
import 'package:uza_sales/app/retailer/widget/cart_dialog.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uza_sales/app/sales/screen/sales_cart.dart';

class AdsProducts extends StatefulWidget {
  const AdsProducts({Key key}) : super(key: key);

  @override
  _AdsProductsState createState() => _AdsProductsState();
}

class _AdsProductsState extends State<AdsProducts> {
  String _price;
  String _discount;
  String _alphabet;
  final prices = ['lowest-highest', 'highest-lowest '];
  final discounts = ['on Discount', 'in Discount'];
  final alphabets = ['Ascending', 'Descending '];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CategoryProvider>(context);
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: AppColor.bgScreen2,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverStickyHeader(
            header: Container(
              color: AppColor.bgScreen2,
              height: 170,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 35.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Products".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF292C34)),
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => filterBuilder());
                          },
                          child: Container(
                            height: 40,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color(0xFFC7D3DD))),
                            child: Center(
                                child: Text(
                              "Filter",
                              style: TextStyle(color: AppColor.base),
                            )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
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
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color(0xFF000000),
                              ),
                              hintText: "search products",
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              productProvider.fetchProducts("", "", text, "");
                            },
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
                height: Utils.displayHeight(context),
                // color: Colors.green,
                child: productProvider.availableProducts == null ||
                        productProvider.availableProducts.length <= 0
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
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: productProvider.availableProducts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, bottom: 20.0),
                              child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) => productView(
                                            product: productProvider
                                                .availableProducts[index]));
                                  },
                                  child: productProvider.isProductLoad
                                      ? ProductsShimmer()
                                      : ProductCard(
                                          product: productProvider
                                              .availableProducts[index])));
                        }),
              ),
            ])),
          ),
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

// ProductModel view bottom sheet
  Widget productView({@required Product product}) {
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
                  product.name,
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
                              text: "${product.primaryUnitPrice}",
                              style: TextStyle(
                                  color: Color(0xFF2D0C57), fontSize: 18)),
                        ])),
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
                              text: "${product.secondaryUnitPrice}",
                              style: TextStyle(
                                  color: Color(0xFF2D0C57), fontSize: 18)),
                        ])),
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
                  "${product.description}",
                  style: TextStyle(color: Color(0xFF9586A8)),
                ),
                SizedBox(
                  height: 40,
                ),
                CustomButttonCart(
                    label1: "Add to Cart",
                    addtoCart: () {
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
                    },
                    label2: "Buy Now",
                    buyNow: () {
                      pushNewScreen(
                        context,
                        screen: SaleCartScreen(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
