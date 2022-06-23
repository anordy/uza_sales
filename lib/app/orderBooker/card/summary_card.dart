import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/sales/model/visit_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SummaryCard extends StatelessWidget {
  final Visit visit;
  const SummaryCard({Key key, @required this.visit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: [
            Container(
              height: 170,
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
                            visit.storeName.toUpperCase(),
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
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
                                  text: visit.address,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF9E9E9E)))),
                        )
                        // Text(
                        //   visit.address,
                        //   style: TextStyle(
                        //       fontSize: 13,
                        //       fontWeight: FontWeight.w500,
                        //       color: Color(0xFF9E9E9E)),
                        // )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, top: 10.0),
                    child: Row(
                      children: [
                        Text("Phone",
                            style: TextStyle(
                                color: Color(0xFF9E9E9E), fontSize: 12)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          visit.phone ?? "",
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
                        Text(AppLocalizations.of(context).check_in,
                            style: TextStyle(
                                color: Color(0xFF9E9E9E), fontSize: 12)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${visit.checkInTime}",
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
                          AppLocalizations.of(context).check_out,
                          style:
                              TextStyle(color: Color(0xFF9E9E9E), fontSize: 12),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${visit.checkOutTime}",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF9E9E9E)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
