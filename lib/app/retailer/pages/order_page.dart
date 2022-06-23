import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uza_sales/app/retailer/pages/payment_page.dart';
import 'package:uza_sales/app/retailer/provider/cart_provider.dart';
import 'package:uza_sales/app/retailer/provider/order_provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:uza_sales/app/sales/widget/cash_order_dialog.dart';

import '../../sales/widget/custom_dialog.dart';
import '../widget/custom_pay_toast.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  var numberFormat = NumberFormat('#,##,000.00');

  TabController _tabController;
  TextEditingController _nidaController = TextEditingController();
  TextEditingController _tinController = TextEditingController();
  TextEditingController _avgController = TextEditingController();
  List<Widget> list = [
    Tab(
      text: "Mobile",
    ),
    Tab(
      text: "Card",
    ),
    Tab(
      text: "Pay later",
    ),
  ];

  String phone;
  String accessToken;
  String address;
  String shopName;
  String pickupLat = "";
  String pickupLon = "";
  _loadUsers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      this.phone = sharedPreferences.getString('phone');
      this.accessToken = sharedPreferences.getString('accessToken');
      this.address = sharedPreferences.getString('address');
      this.shopName = sharedPreferences.getString('shopName');
      if (this.phone == null) {
        this.phone = "255 716 121 688";
      }
      print("*****  phone number");
      print("phone: ${this.phone}");
    });
  }

  // change Address
  _changeAddress() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print("======== location from checkout =======");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey:
              "AIzaSyDcXsn46Dtc2Jn5hnKI-Lgi2OyVlsDVEoA", // Put YOUR OWN KEY here.
          onPlacePicked: (result) {
            print(result.name);
          },
          usePlaceDetailSearch: true,
          initialPosition: LatLng(-6.7695352, 39.2297569),
          // initialPosition: HomePage.kInitialPosition,
          selectedPlaceWidgetBuilder:
              (_, selectedPlace, state, isSearchBarFocused) {
            return isSearchBarFocused
                ? Container()
                : Positioned(
                    bottom: 20,
                    left: 30,
                    right: 30,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      height: 100,
                      width: Utils.displayWidth(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            // maxLines: 2,
                            text: TextSpan(
                                text: "${selectedPlace.formattedAddress}",
                                style: TextStyle(
                                    color: AppColor.text, fontSize: 16)),
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            height: 30,
                            minWidth: Utils.displayWidth(context) * 0.5,
                            color: AppColor.base,
                            onPressed: () {
                              setState(() {
                                address = selectedPlace.formattedAddress;
                                this.pickupLat = selectedPlace
                                    .geometry.location.lat
                                    .toString();
                                this.pickupLon = selectedPlace
                                    .geometry.location.lng
                                    .toString();
                                print(
                                    "pickupPlace: ${selectedPlace.formattedAddress}");
                                print("pickuplat: ${this.pickupLat}");
                                print("pickupLon: ${this.pickupLon}");
                                sharedPreferences.setString("latitude",
                                    "${selectedPlace.geometry.location.lat}");
                                sharedPreferences.setString("longitude",
                                    "${selectedPlace.geometry.location.lng}");

                                sharedPreferences.setString("address",
                                    "${selectedPlace.formattedAddress}");
                              });

                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Continue",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
          hintText: 'Enter Pickup Location',
          useCurrentLocation: true,
        ),
      ),
    );
  }

  String _setTime, _setDate;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _dateController.text = dateFormat.format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final order = Provider.of<OrderProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColor.bgScreen,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Complete Order".toUpperCase(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Delivering to",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xFFF1F1F1),
                  ),
                  title: Text(
                    "${this.shopName}",
                    style: TextStyle(color: AppColor.text),
                  ),
                  subtitle: Text('${this.phone}'),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Colors.black45,
                ),
                SizedBox(
                  height: 5,
                ),
                ListTile(
                  leading: Icon(
                    Icons.location_pin,
                    color: AppColor.base,
                    size: 15,
                  ),
                  title: Text(
                    'Delivery Address',
                    style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  trailing: TextButton(
                      onPressed: () => _changeAddress(),
                      child: Text('Change',
                          style: TextStyle(
                              color: AppColor.base,
                              fontSize: 14,
                              fontWeight: FontWeight.w500))),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 70),
                  child: Text(
                    "Shop",
                    style: TextStyle(
                        color: AppColor.text,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Container(
                      // color: Colors.green,
                      width: Utils.displayWidth(context) * 0.42,
                      child: RichText(
                        maxLines: 4,
                        text: TextSpan(
                            text: "${this.address}",
                            style: TextStyle(
                                color: Color(0xFFA0A0A0), fontSize: 13)),
                      ),
                    )),
                SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Icon(
                    Icons.alarm,
                    color: AppColor.base,
                    size: 15,
                  ),
                  title: Text(
                    'Delivery Date and Time',
                    style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  trailing: TextButton(
                      onPressed: () {
                        _openDateTimePicker(context);
                      },
                      child: Text('Change',
                          style: TextStyle(
                              color: AppColor.base,
                              fontSize: 14,
                              fontWeight: FontWeight.w500))),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 70),
                  child: Text(
                    "${_dateController.text}",
                    style: TextStyle(
                      color: AppColor.text,
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFFF7F8F9),
                        borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        // indicatorColor: AppColor.base,
                        labelColor: Color(0xFF292C34),
                        unselectedLabelColor: Color(0xFF9B9C9B),
                        tabs: list,
                        onTap: (index) {
                          // Tab index when user select it, it start from zero
                          if (index == 2) {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => payLater());
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  color: Colors.transparent,
                  child: TabBarView(
                      controller: _tabController,
                      children: [mobile(), card(), mobile()]),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black45,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Total",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.text),
                      ),
                      Text(
                        "${numberFormat.format(cart.totalAmount)}",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.text),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Charge",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.text),
                      ),
                      Text(
                        "Free",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.text),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black45,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0, bottom: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0)),
                      color: Theme.of(context).primaryColor,
                      height: 55,
                      minWidth: Utils.displayWidth(context) * 0.5,
                      onPressed: () {
                        Map<String, dynamic> _orderObject = {};

                        List<Map<String, dynamic>> _orderObjectList = [];

                        for (var i = 0; i < cart.items.length; i++) {
                          _orderObject = {
                            "productId": cart.items.values.toList()[i].id,
                            "type": cart.items.values.toList()[i].type,
                            "quantity": cart.items.values.toList()[i].quantity,
                          };
                          _orderObjectList.add(_orderObject);
                        }

                        order
                            .createOrder(orderMapList: _orderObjectList)
                            .then((value) => {
                                  if (!value)
                                    {
                                      showToastWidget(
                                        LoggedInToast(
                                            icon: Icon(
                                              Icons.done,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                            height: 50,
                                            width: 280,
                                            color: AppColor.success,
                                            description:
                                                "You're order is now created"),
                                        duration: Duration(seconds: 3),
                                        position: ToastPosition.bottom,
                                      ),
                                    }
                                });
                        cart.clear();
                        navigate(context);
                      },
                      child: Text(
                        'Order Now'.toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget mobile() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            // color: Color(0xFFE7E9E7),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColor.base)),
        width: Utils.displayWidth(context) * 0.8,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "**** *** *** *89",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget card() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Container(
          height: 50,
          decoration: BoxDecoration(
              // color: Color(0xFFE7E9E7),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColor.base)),
          width: Utils.displayWidth(context) * 0.8,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "**** *** *** *73",
                  border: InputBorder.none,
                ),
              ),
            ),
          )),
    );
  }

  navigate(BuildContext context) {
    pushNewScreen(
      context,
      screen: PaymentPage(
        deliveryDate: "${_dateController.text}",
      ),
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  // select date

  void _openDateTimePicker(BuildContext context) {
    BottomPicker.dateTime(
      title: 'Set Delivery date and Time',
      titleStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Colors.black,
      ),
      onSubmit: (date) {
        print(date);
        setState(() {
          selectedDate = date;
          _dateController.text = dateFormat.format(selectedDate);
        });
      },
      onClose: () {
        print('Picker closed');
      },
      iconColor: Colors.black,
      minDateTime: DateTime(2022, 1, 1),
      maxDateTime: DateTime(2025, 1, 1),
      initialDateTime: DateTime.now(),
      gradientColors: [Color(0xfffdcbf1), Color(0xffe6dee9)],
    ).show(context);
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
  Widget payLater() {
    final orderProvider = Provider.of<OrderProvider>(context);
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
                  "Your Nida Number",
                  style: TextStyle(color: Color(0xFF40403F)),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                        // color: Color(0xFFE7E9E7),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppColor.base)),
                    width: Utils.displayWidth(context) * 0.8,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: TextFormField(
                          controller: _nidaController,
                          decoration: InputDecoration(
                            hintText: "**** *** *** 5673",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    )),
                SizedBox(height: 25.0),
                Text(
                  "Business Tin Number",
                  style: TextStyle(color: Color(0xFF40403F)),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                        // color: Color(0xFFE7E9E7),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppColor.base)),
                    width: Utils.displayWidth(context) * 0.8,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: TextFormField(
                          controller: _tinController,
                          decoration: InputDecoration(
                            hintText: "Enter your Tin Number",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    )),
                SizedBox(height: 25.0),
                Text(
                  "Average Sales per month",
                  style: TextStyle(color: Color(0xFF40403F)),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                        // color: Color(0xFFE7E9E7),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppColor.base)),
                    width: Utils.displayWidth(context) * 0.8,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: TextFormField(
                          controller: _avgController,
                          decoration: InputDecoration(
                            hintText: "Enter your average or sales",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    )),
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
                      orderProvider
                          .payLater(
                              nida: _nidaController.text,
                              tin: _tinController.text,
                              averageMonth: _avgController.text)
                          .then((value) {
                        if (!value) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomPayLaterToast(
                                    desc:
                                        "Your request has succesfully received. Once your request has been approved, we will contact you.",
                                    ok: "Okay",
                                    cancelChange: () {
                                      Navigator.pop(context);
                                    },
                                    okChange: () {
                                      Navigator.pop(context);
                                    });
                              });
                        } else {
                          showToastWidget(
                            ToastWidget(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                height: 50,
                                width: 250,
                                color: AppColor.preBase,
                                description: "Something went wrong"),
                            duration: Duration(seconds: 2),
                            position: ToastPosition.bottom,
                          );
                        }
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Send Order'.toUpperCase(),
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
}
