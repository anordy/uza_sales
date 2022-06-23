import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:uza_sales/app/sales/model/route_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpCard extends StatefulWidget {
  final MyRoute routes;
  const OtpCard({Key key, @required this.routes}) : super(key: key);

  @override
  _OtpCardState createState() => _OtpCardState();
}

class _OtpCardState extends State<OtpCard> {
  String category;
  final items = ['Soft Drinks', 'Liquor', 'Beuty & Cosmetics'];
  String product;
  final products = ['Heineken', 'Pepsi', 'Coca Cola', 'Azam Embe'];
  String unit;
  final units = ['Cartons', 'Pc', 'Pack'];
  String reason;
  final reasons = ['Expired', 'Broken'];

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
                            widget.routes.stores[0].name.toUpperCase(),
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => showCategory());
                              })
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, top: 10.0),
                    child: Row(
                      children: [
                        Text("Where: ",
                            style: TextStyle(
                                color: Color(0xFF9E9E9E), fontSize: 12)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.routes.stores[0].address,
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
                          widget.routes.stores[0].phone,
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
                          widget.routes.status,
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

  Widget makeDismisible({@required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

  Widget showCategory() {
    return makeDismisible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.7,
        maxChildSize: 0.7,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 50),
            child: ListView(
              controller: controller,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Text("Product Category"),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppColor.border)),
                  width: Utils.displayWidth(context),
                  child: Center(
                      child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                              // alignedDropdown: true,
                              child: DropdownButton<String>(
                    icon: Icon(FontAwesomeIcons.chevronDown,
                        color: Color(0xFFCECECE)),
                    iconSize: 15,
                    value: category,
                    hint: Text("Select Category"),
                    isExpanded: true,
                    onChanged: (String value) {
                      setState(() {
                        category = value;
                      });
                    },
                    items: items.map(buildMenuItem).toList(),
                    style: TextStyle(color: Colors.black45, fontSize: 16),
                  )))),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("Product"),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppColor.border)),
                  width: Utils.displayWidth(context),
                  child: Center(
                      child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                              // alignedDropdown: true,
                              child: DropdownButton<String>(
                    icon: Icon(FontAwesomeIcons.chevronDown,
                        color: Color(0xFFCECECE)),
                    iconSize: 15,
                    value: product,
                    hint: Text("Select Products"),
                    isExpanded: true,
                    onChanged: (String value) {
                      setState(() {
                        product = value;
                      });
                    },
                    items: products.map(buildMenuItem).toList(),
                    style: TextStyle(color: Colors.black45, fontSize: 16),
                  )))),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Unit"),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          width: Utils.displayWidth(context) * 0.35,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: AppColor.border)),
                          child: Center(
                              child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                      // alignedDropdown: true,
                                      child: DropdownButton<String>(
                            icon: Icon(FontAwesomeIcons.chevronDown,
                                color: Color(0xFFCECECE)),
                            iconSize: 15,
                            value: unit,
                            hint: Text("Units"),
                            isExpanded: true,
                            onChanged: (String value) {
                              setState(() {
                                unit = value;
                              });
                            },
                            items: units.map(buildMenuItem).toList(),
                            style:
                                TextStyle(color: Colors.black45, fontSize: 16),
                          )))),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Quantity"),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 45,
                          width: Utils.displayWidth(context) * 0.35,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFC7D3DD)),
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "213"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.chevronUp,
                                        color: Color(0xFFCECECE),
                                        size: 15,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.chevronDown,
                                        color: Color(0xFFCECECE),
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: InkWell(
                    onTap: () {
                      // pushNewScreen(
                      //   context,
                      //   screen: CategoryScreen(),
                      //   withNavBar: true, // OPTIONAL VALUE. True by default.
                      //   pageTransitionAnimation:
                      //   PageTransitionAnimation.cupertino,
                      // );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: AppColor.preBase,
                          size: 16,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          AppLocalizations.of(context).add_more_product,
                          style: TextStyle(
                              color: AppColor.preBase,
                              fontSize: 13,
                              fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Spacer(),
                Center(
                  child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0)),
                      color: AppColor.preBase,
                      height: 50,
                      minWidth: Utils.displayWidth(context) * 0.6,
                      onPressed: () {
                        showToastWidget(
                          ToastWidget(
                              icon: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 15,
                              ),
                              height: 50,
                              width: 250,
                              color: AppColor.success,
                              description: "Success"),
                          duration: Duration(seconds: 2),
                          position: ToastPosition.bottom,
                        );
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Request Otp".toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      )),
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
        child: Text(item),
      );
}
