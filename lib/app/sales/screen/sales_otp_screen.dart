import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:uza_sales/app/sales/card/otpCard.dart';
import 'package:uza_sales/app/sales/provider/route_provider.dart';
import 'package:uza_sales/app/sales/screen/onroute_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedIndex = 0;
  List<Widget> list = [
    Tab(
      text: "On Route",
    ),
    Tab(
      text: "Off Route",
    ),
  ];
  String category;
  final items = ['Soft Drinks', 'Liquor', 'Beuty & Cosmetics'];
  String product;
  final products = ['Heineken', 'Pepsi', 'Coca Cola', 'Azam Embe'];
  String unit;
  final units = ['Cartons', 'Pc', 'Pack'];
  String reason;
  final reasons = ['Expired', 'Broken'];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: list.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bgScreen2,
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverStickyHeader(
                header: Container(
                  color: AppColor.bgScreen2,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                              // SizedBox(width: 2,),
                              Text(
                                "One Time Purchase",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.title,
                                    fontWeight: FontWeight.w600),
                              ),
                              // SizedBox(
                              //   width: 100,
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: Utils.displayWidth(context) * 0.68,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.search,
                                          size: 20,
                                          color: Color(0xFF9B9C9B),
                                        ),
                                        hintText: "Search",
                                        hintStyle:
                                            TextStyle(color: Color(0xFF9B9C9B)),
                                        border: InputBorder.none),
                                  ),
                                ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                              ],
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     Container(
                          //       height: 40,
                          //       width: Utils.displayWidth(context) * 0.68,
                          //       decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(6)),
                          //       child: TextFormField(
                          //         decoration: InputDecoration(
                          //             prefixIcon: Icon(
                          //               Icons.search,
                          //               size: 20,
                          //               color: Color(0xFF9B9C9B),
                          //             ),
                          //             hintText: "Search",
                          //             hintStyle:
                          //                 TextStyle(color: Color(0xFF9B9C9B)),
                          //             border: InputBorder.none),
                          //       ),
                          //     ),
                          //     // SizedBox(
                          //     //   width: 5,
                          //     // ),
                          //   ],
                          // ),

                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: Utils.displayWidth(context),
                            decoration: BoxDecoration(
                                color: AppColor.bgScreen2,
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2, color: Color(0xFFE5E6E5)))),
                            child: TabBar(
                              controller: _tabController,
                              indicatorColor: AppColor.preBase,
                              labelColor: AppColor.preBase,
                              unselectedLabelColor: Color(0xFF292C34),
                              tabs: list,
                              onTap: (index) {
                                print("Tabs $index");
                                // Tab index when user select it, it start from zero
                                // _tabController.index = _tabController.previousIndex;
                                // signInDialog(context);
                              },
                            ),
                          )
                        ],
                      )),
                ),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                    height: Utils.displayHeight(context),
                    child: TabBarView(
                        controller: _tabController,
                        children: [onRoute(), offRoute()]),
                  )
                ])),
              ),
            ],
          ),
        ));
  }

  Widget onRoute() {
    final _routeProvider = Provider.of<RouteProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
      child: Container(
        height: Utils.displayHeight(context),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28), color: Colors.white),
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Customer Name"),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 45,
                  width: Utils.displayWidth(context),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFC7D3DD)),
                      borderRadius: BorderRadius.circular(50.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Expanded(
                      child: Center(
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Reuben"),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Customer Number"),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 45,
                  width: Utils.displayWidth(context),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFC7D3DD)),
                      borderRadius: BorderRadius.circular(50.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Expanded(
                      child: Center(
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "077 8786 76735"),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
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
                        "Confirm Order".toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            )),
      ),
    );
  }

  Widget offRoute() {
    final _routeProvider = Provider.of<RouteProvider>(context);
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _routeProvider?.availableRoute?.length ?? 0,
        itemBuilder: (context, index) {
          return OtpCard(
            routes: _routeProvider.availableRoute[index],
          );
        });
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}
