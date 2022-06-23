import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/model/store_cart.dart';
import 'package:uza_sales/app/retailer/provider/cart_provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:intl/intl.dart';

class CartItemsCard extends StatefulWidget {
  Cart cart;

  CartItemsCard({
    Key key,
    @required this.cart,
  }) : super(key: key);

  @override
  State<CartItemsCard> createState() => _CartItemListState();
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class _CartItemListState extends State<CartItemsCard> {
  String type = 'Carton';
  final types = ['Carton', 'Dozen', 'Piece', 'Bags'];
  @override
  Widget build(BuildContext context) {
    //     var numberFormat = NumberFormat('#,##,000.00');

    var numberFormat = NumberFormat('#,##,000.00');
    final cart = Provider.of<CartProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 15.0),
      child: Container(
        // color: Colors.green,
        child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 35,
                // color: Colors.green,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Color(0xFF976767),
                  ),
                  onPressed: () {
                    setState(() {
                      cart.removeItem(widget.cart.productId);
                      // cart.sendCartsData();
                      print("removeitem ${cart.storesCarts.length}");
                    });
                  },
                ),
              ),
              SizedBox(
                width: 1,
              ),
              Container(
                height: 40,
                width: Utils.displayWidth(context) * 0.23,
                // color: Colors.tealAccent,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: widget.cart.productName,
                          style:
                              TextStyle(color: AppColor.text, fontSize: 14))),
                ),
              ),
              SizedBox(
                width: 1,
              ),
              Container(
                height: 40,
                width: Utils.displayWidth(context) * 0.2,
                // color: Colors.tealAccent,
                child: Container(
                    height: Utils.displayHeight(context) * 0.05,
                    width: Utils.displayWidth(context) * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xFFC7D3DD))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              cart.removeSingleItems(widget.cart.productId);
                              // cart.sendCartsData();
                            },
                            child: Icon(
                              FontAwesomeIcons.minus,
                              size: 16,
                              color: AppColor.base,
                            ),
                          ),
                          Text(
                            "${widget.cart.count}",
                            style:
                                TextStyle(color: AppColor.text, fontSize: 18),
                          ),

                          InkWell(
                            onTap: () {
                              setState(() {
                                cart.addSingleItems(widget.cart.productId);
                                // cart.sendCartsData();
                                print(
                                    "add single item ${cart.storesCarts.length}");
                              });
                            },
                            child: Icon(
                              FontAwesomeIcons.plus,
                              size: 16,
                              color: AppColor.base,
                            ),
                          ),
                          // Column(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     InkWell(
                          //       onTap: () {
                          //         cart.addSingleItems(productId);
                          //       },
                          //       child: Icon(
                          //         FontAwesomeIcons.chevronUp,
                          //         size: 16,
                          //         color: AppColor.base,
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       height: 1,
                          //     ),
                          //     InkWell(
                          //       onTap: () {
                          //         cart.removeSingleItems(productId);
                          //       },
                          //       child: Icon(
                          //         FontAwesomeIcons.chevronDown,
                          //         color: AppColor.base,
                          //         size: 16,
                          //       ),
                          //     )
                          //   ],
                          // )
                        ],
                      ),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 40,
                width: Utils.displayWidth(context) * 0.2,
                // color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10),
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    // maxLines: 2,
                    text: TextSpan(
                        text: "${widget.cart.unit.capitalize()}",
                        style: TextStyle(color: AppColor.text, fontSize: 16)),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 40,
                width: Utils.displayWidth(context) * 0.2,
                // color: Colors.tealAccent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                  child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text:
                              '${numberFormat.format(widget.cart.unitPrice * widget.cart.count)}',
                          style:
                              TextStyle(color: AppColor.text, fontSize: 14))),
                ),
              )
            ]),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}
