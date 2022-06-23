import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/model/product_model.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var numberFormat = NumberFormat('#,##,000.00');

    return Container(
      color: AppColor.bgScreen2,
      height: Utils.displayHeight(context) * 0.15,
      width: Utils.displayWidth(context),
      child: Row(
        children: [
          Container(
            height: Utils.displayHeight(context) * 0.15,
            width: Utils.displayWidth(context) * 0.35,
            decoration: BoxDecoration(
              color: Color(0xFFE7E7E7),
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  '${this.product.image}',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                //  discount container
                this.product.discount.status == "ACTIVE"
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          height: 20,
                          width: 64,
                          decoration: BoxDecoration(
                              color: AppColor.preBase,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30))),
                          child: Center(
                              child: Text(
                            "On discount",
                            style: TextStyle(color: Colors.white, fontSize: 9),
                          )),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                product.name,
                style: TextStyle(color: Color(0xFF40403F), fontSize: 18),
              ),
              SizedBox(
                height: 5,
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
              //               style:
              //                   TextStyle(color: AppColor.base, fontSize: 12)),
              //           TextSpan(
              //               text: '${product.primaryUnitPrice}',
              //               style: TextStyle(
              //                   color: Color(0xFF2D0C57), fontSize: 12)),
              //         ])),
              //         SizedBox(
              //           height: 5,
              //         ),
              //         Text(
              //           "${product.primaryUnit}",
              //           style:
              //               TextStyle(color: Color(0xFFAEAEAE), fontSize: 12),
              //         )
              //       ],
              //     ),
              //     SizedBox(
              //       width: 40,
              //     ),
              //     Container(
              //       height: 30,
              //       width: 0.5,
              //       color: Color(0xFFAEAEAE),
              //     ),
              //     SizedBox(
              //       width: 15,
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         RichText(
              //             text: TextSpan(children: <TextSpan>[
              //           TextSpan(
              //               text: "Tsh ",
              //               style:
              //                   TextStyle(color: AppColor.base, fontSize: 12)),
              //           TextSpan(
              //               text: '${product.secondaryUnitPrice}',
              //               style: TextStyle(
              //                   color: Color(0xFF2D0C57), fontSize: 12)),
              //         ])),
              //         SizedBox(
              //           height: 5,
              //         ),
              //         Text(
              //           "${product.secondaryUnit}",
              //           style:
              //               TextStyle(color: Color(0xFFAEAEAE), fontSize: 12),
              //         )
              //       ],
              //     ),
              //   ],
              // ),

              //  discount
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      this.product.discount.status == "ACTIVE" &&
                              this.product.discount.originalPrice ==
                                  this.product.primaryUnitPrice
                          ? RichText(
                              text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Tsh ",
                                  style: TextStyle(
                                      color: AppColor.base, fontSize: 12)),
                              TextSpan(
                                  text:
                                      '${numberFormat.format(product.discount.newPrice)}',
                                  style: TextStyle(
                                      color: Color(0xFF2D0C57), fontSize: 12)),
                            ]))
                          : RichText(
                              text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Tsh ",
                                  style: TextStyle(
                                      color: AppColor.base, fontSize: 12)),
                              TextSpan(
                                  text:
                                      '${numberFormat.format(product.primaryUnitPrice)}',
                                  style: TextStyle(
                                      color: Color(0xFF2D0C57), fontSize: 12)),
                            ])),
                      SizedBox(
                        height: 1,
                      ),
                      this.product.discount.status == "ACTIVE" &&
                              this.product.discount.originalPrice ==
                                  this.product.primaryUnitPrice
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
                                    text:
                                        '${numberFormat.format(product.discount.originalPrice)}',
                                    style: TextStyle(
                                      color: Color(0xFF2D0C57),
                                      fontSize: 10,
                                      decoration: TextDecoration.lineThrough,
                                    )),
                              ])),
                            )
                          : Container(),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${product.primaryUnit.capitalize()}",
                        style:
                            TextStyle(color: Color(0xFFAEAEAE), fontSize: 12),
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
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      this.product.discount.status == "ACTIVE" &&
                              this.product.discount.originalPrice ==
                                  this.product.secondaryUnitPrice
                          ? RichText(
                              text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Tsh ",
                                  style: TextStyle(
                                      color: AppColor.base, fontSize: 12)),
                              TextSpan(
                                  text:
                                      '${numberFormat.format(product.discount.newPrice)}',
                                  style: TextStyle(
                                      color: Color(0xFF2D0C57), fontSize: 12)),
                            ]))
                          : RichText(
                              text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Tsh ",
                                  style: TextStyle(
                                      color: AppColor.base, fontSize: 12)),
                              TextSpan(
                                  text:
                                      '${numberFormat.format(product.secondaryUnitPrice)}',
                                  style: TextStyle(
                                      color: Color(0xFF2D0C57), fontSize: 12)),
                            ])),
                      SizedBox(
                        height: 1,
                      ),
                      this.product.discount.status == "ACTIVE" &&
                              this.product.discount.originalPrice ==
                                  this.product.secondaryUnitPrice
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
                                    text:
                                        '${numberFormat.format(product.discount.originalPrice)}',
                                    style: TextStyle(
                                      color: Color(0xFF2D0C57),
                                      fontSize: 10,
                                      decoration: TextDecoration.lineThrough,
                                    )),
                              ])),
                            )
                          : Container(),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${product.secondaryUnit.capitalize()}",
                        style:
                            TextStyle(color: Color(0xFFAEAEAE), fontSize: 12),
                      )
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 5,
              ),
              Container(
                height: 28,
                width: Utils.displayWidth(context) * 0.5,
                decoration: BoxDecoration(
                  color: AppColor.base,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).add_to_cart,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
