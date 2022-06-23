import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/sales/model/route_model.dart';
import 'package:uza_sales/app/sales/widget/more_vert_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyRoutesCard extends StatelessWidget {
  final SalesStore stores;
  final MyRoute routes;
  const MyRoutesCard({Key key, @required this.stores, this.routes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColor.preBase),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            stores.name.toUpperCase() ?? '',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          MoreVertWidget(
                            routes: routes,
                            stores: this.stores,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, top: 10.0),
                    child: Row(
                      children: [
                        Text(AppLocalizations.of(context).where,
                            style: TextStyle(
                                color: Color(0xFF9E9E9E), fontSize: 12)),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                  text: stores.address ?? '',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF9E9E9E)))),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, top: 10.0),
                    child: Row(
                      children: [
                        Text(AppLocalizations.of(context).contacts,
                            style: TextStyle(
                                color: Color(0xFF9E9E9E), fontSize: 12)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          stores.phone ?? '',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF9E9E9E)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, top: 10.0),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context).status,
                          style:
                              TextStyle(color: Color(0xFF9E9E9E), fontSize: 12),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          routes.status ?? '',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColor.success),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, top: 10.0),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context).last_visit,
                          style:
                              TextStyle(color: Color(0xFF9E9E9E), fontSize: 12),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context).today,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF9E9E9E)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, top: 10.0),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context).orders,
                          style:
                              TextStyle(color: Color(0xFF9E9E9E), fontSize: 12),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "No Pending Orders",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF9E9E9E)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
