import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/sales/model/route_model.dart';

class ByRouteLists extends StatelessWidget {
  final MyRoute routes;
  const ByRouteLists({Key key, @required this.routes}) : super(key: key);
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 5, top: 20),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "01".toUpperCase(),
                          style:
                              TextStyle(color: Color(0xFF9E9E9E), fontSize: 16),
                        ),
                        SizedBox(
                          width: 18.0,
                        ),
                        Text(
                          routes.stores[0].name.toUpperCase(),
                          style:
                              TextStyle(color: Color(0xFF525252), fontSize: 14),
                        ),
                        SizedBox(
                          width: 180.0,
                        ),
                        Icon(
                          Icons.more_vert,
                          color: AppColor.preBase,
                        )
                        // MoreVertWidget()
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, top: 10.0),
                    child: Row(
                      children: [
                        Text("Where:",
                            style: TextStyle(
                                color: Color(0xFF9E9E9E), fontSize: 12)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          routes.stores[0].address,
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
                        Text("Contacts:",
                            style: TextStyle(
                                color: Color(0xFF9E9E9E), fontSize: 12)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          routes.stores[0].phone,
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
                          "Status:",
                          style:
                              TextStyle(color: Color(0xFF9E9E9E), fontSize: 12),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          routes.status,
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
                          "Last Visit:",
                          style:
                              TextStyle(color: Color(0xFF9E9E9E), fontSize: 12),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Today",
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
                          "Orders:",
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
