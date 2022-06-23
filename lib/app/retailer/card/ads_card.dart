import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:uza_sales/app/retailer/model/product_model.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class AdsCard extends StatelessWidget {
  final Product product;
  const AdsCard({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var numberFormat = NumberFormat('#,##,000.00');

    return Container(
      // color: Colors.blue,
      height: Utils.displayHeight(context) * 0.15,
      width: Utils.displayWidth(context),
      child: Row(
        children: [
          Container(
            height: Utils.displayHeight(context) * 0.15,
            width: Utils.displayWidth(context) * 0.35,
            decoration: BoxDecoration(
                color: Color(0xFFE7E7E7),
                borderRadius: BorderRadius.circular(8)),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                child: Image(
                    image: CachedNetworkImageProvider(
                  'http://' + '${this.product.image}',
                ))),
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
                height: 10,
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
                            style:
                                TextStyle(color: AppColor.base, fontSize: 12)),
                        TextSpan(
                            text:
                                '${numberFormat.format(product.primaryUnitPrice)}',
                            style: TextStyle(
                                color: Color(0xFF2D0C57), fontSize: 12)),
                      ])),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${product.primaryUnit}",
                        style:
                            TextStyle(color: Color(0xFFAEAEAE), fontSize: 12),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Container(
                    height: 30,
                    width: 0.5,
                    color: Color(0xFFAEAEAE),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Tsh ",
                            style:
                                TextStyle(color: AppColor.base, fontSize: 12)),
                        TextSpan(
                            text:
                                '${numberFormat.format(product.secondaryUnitPrice)}',
                            style: TextStyle(
                                color: Color(0xFF2D0C57), fontSize: 12)),
                      ])),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${product.secondaryUnit}",
                        style:
                            TextStyle(color: Color(0xFFAEAEAE), fontSize: 12),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 30,
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
