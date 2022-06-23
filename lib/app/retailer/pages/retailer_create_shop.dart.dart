import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:uza_sales/app/retailer/model/country_model.dart';
import 'package:uza_sales/app/retailer/network/api.dart';
import 'package:uza_sales/app/retailer/pages/home_page.dart';
import 'package:uza_sales/app/retailer/provider/auth_provider.dart';
import 'package:uza_sales/app/retailer/widget/agree_terms_dialog.dart';
import 'package:uza_sales/app/retailer/widget/cart_dialog.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/button/custom_buton.dart';
import 'package:uza_sales/app/retailer/widget/loading.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class CreateShop extends StatefulWidget {
  const CreateShop({Key key}) : super(key: key);

  @override
  _CreateShopState createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop>
    with SingleTickerProviderStateMixin {
  String accessToken;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> ownerKey = GlobalKey<FormState>();
  GlobalKey<FormState> storeKey = GlobalKey<FormState>();
  GlobalKey<FormState> keeperKey = GlobalKey<FormState>();
  SharedPreferences sharedPreferences;
  String _selectedCountry = "Choose Country";
  String locationAddress = "Search Location";
  String pickupLat = "";
  String pickupLon = "";
  String phone;
  _loadUsers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      this.phone = sharedPreferences.getString('phone');
      this.accessToken = sharedPreferences.getString('accessToken');
      if (this.phone == null) {
        this.phone = "255 716 121 688";
      }
      print("*****  phone number");
      print("phone: ${this.phone}");
    });
  }

  bool agree = false;
  TextEditingController _fnamecontroller = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _shopcontroller = TextEditingController();
  TextEditingController _skfnameController = TextEditingController();
  TextEditingController _sklnameController = TextEditingController();
  TextEditingController _skphoneController = TextEditingController();

  int _selected = 0;
  TabController _tabController;

  List<Country> _regionList = [];
  List<Widget> list = [
    Tab(
      text: "OWNER",
    ),
    Tab(
      text: "STORE",
    ),
    Tab(
      text: "STORE KEEPER",
    ),
  ];
  bool _checked = false;
  int _selectedIndex = 2;
  PickResult selectedPlace;

  Future _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.validate();
  }

// pickup Address
  _pickupAddress() async {
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
                                locationAddress =
                                    selectedPlace.formattedAddress;
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
                                sharedPreferences.setString(
                                    "latitude", "${this.pickupLat}");
                                sharedPreferences.setString(
                                    "longittude", "${this.pickupLon}");
                                sharedPreferences.setString(
                                    "address", "${this.locationAddress}");
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

// get Country
  CountryList countryList;
  String _myCountry = "Tanzania";
  bool _isCountryLoading = false;
  Future<Map<String, dynamic>> _getCountry() async {
    setState(() {
      _isCountryLoading = true;
    });
    // notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    var url = Uri.parse(api + "zone/get");
    final http.Response response =
        await http.get(url, headers: <String, String>{
      "Authorization": "Bearer $accessToken",
      "Accept": "Application/json",
      "content-Type": "Application/json"
    });
    if (response.statusCode == 200) {
      var result = CountryList.fromJson(json.decode(response.body));
      setState(() {
        countryList = result;
        _isCountryLoading = false;
      });
      print("****** result from Country **********");
      print(countryList);
      print("*****************************************");
    } else {
      _isCountryLoading = false;
    }
  }

// get Regions
  RegionList regionList;
  String _myRegion;
  bool _isRegionLoading = false;
  Future<Map<String, dynamic>> _getRegions() async {
    setState(() {
      _isRegionLoading = true;
    });
    // notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    var url = Uri.parse(api + "zone/get?country=$_myCountry");
    final http.Response response =
        await http.get(url, headers: <String, String>{
      // "Authorization": "Bearer $accessToken",
      "Accept": "Application/json",
      "content-Type": "Application/json"
    });
    if (response.statusCode == 200) {
      var result = RegionList.fromJson(json.decode(response.body));
      setState(() {
        regionList = result;
        _isRegionLoading = false;
      });
      print("****** result from Region **********");
      print(regionList);
      print("*****************************************");
    } else {
      _isRegionLoading = false;
    }
  }

  // get Diistricts
  DisitrictList districtList;
  String _myDistrict;
  bool _isDistrictLoading = false;
  Future<Map<String, dynamic>> _getDistricts() async {
    setState(() {
      _isDistrictLoading = true;
    });
    // notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    var url = Uri.parse(api + "zone/get?country=$_myCountry&region=$_myRegion");
    final http.Response response =
        await http.get(url, headers: <String, String>{
      "Authorization": "Bearer $accessToken",
      "Accept": "Application/json",
      "content-Type": "Application/json"
    });
    if (response.statusCode == 200) {
      var result = DisitrictList.fromJson(json.decode(response.body));
      setState(() {
        districtList = result;
        _isDistrictLoading = false;
      });
      print("****** result from District **********");
      print(districtList);
      print("*****************************************");
    } else {
      _isDistrictLoading = false;
    }
  }

  // get Zones
  ZoneList zoneList;
  String _myZone;
  bool _isZoneLoading = false;
  Future<Map<String, dynamic>> _getZones() async {
    setState(() {
      _isZoneLoading = true;
    });
    // notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    var url = Uri.parse(api +
        "zone/get?country=$_myCountry&region=$_myRegion&district=$_myDistrict");
    final http.Response response =
        await http.get(url, headers: <String, String>{
      "Authorization": "Bearer $accessToken",
      "Accept": "Application/json",
      "content-Type": "Application/json"
    });
    if (response.statusCode == 200) {
      var result = ZoneList.fromJson(json.decode(response.body));
      setState(() {
        zoneList = result;
        _isZoneLoading = false;
      });
      print("****** result from Zone **********");
      print(zoneList);
      print("*****************************************");
    } else {
      _isZoneLoading = false;
    }
  }

  void agreeTerms() {
    setState(() {
      agree = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _getCountry();
    _getRegions();
    _getDistricts();
    _getZones();
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);
    // _authProvider.getCountry();
    // Create TabController for getting the index of current tab
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
      backgroundColor: AppColor.bgScreen,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverStickyHeader(
              header: Container(
                color: AppColor.bgScreen,
                height: 170,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 35.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .create_shop
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF292C34)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        Container(
                          width: Utils.displayWidth(context),
                          decoration: BoxDecoration(
                              color: AppColor.bgScreen,
                              border: Border(
                                  bottom: BorderSide(
                                      width: 2, color: Color(0xFFE5E6E5)))),
                          child: TabBar(
                            controller: _tabController,
                            indicatorColor: AppColor.base,
                            labelColor: AppColor.base,
                            unselectedLabelColor: Color(0xFF9B9C9B),
                            tabs: list,
                            onTap: (index) {
                              print("Tabs $index");
                              // Tab index when user select it, it start from zero
                              // _tabController.index = _tabController.previousIndex;
                              // signInDialog(context);

                              if (_tabController.index == 1) {
                                _tabController.index = 0;
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
                                      description: "fill Owner Details"),
                                  duration: Duration(seconds: 2),
                                  position: ToastPosition.bottom,
                                );
                              } else if (_tabController.index == 2) {
                                _tabController.index = 1;
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
                                      description: "complete Store Details"),
                                  duration: Duration(seconds: 2),
                                  position: ToastPosition.bottom,
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              sliver: SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                      controller: _tabController,
                      children: [owner(), store(), storeKeeper()]),
                )
              ])),
            ),
          ],
        ),
      ),
    );
  }

// store
  Widget owner() {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 40),
        child: Form(
          key: ownerKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context).phone_number),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColor.border)),
                width: Utils.displayWidth(context),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "${this.phone}",
                        enabled: false,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(AppLocalizations.of(context).first_name),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColor.border)),
                width: Utils.displayWidth(context),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: TextFormField(
                      controller: _fnamecontroller,
                      decoration: InputDecoration(
                          hintText: "Enter Your firstname",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontStyle: FontStyle.italic)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "* Required";
                        } else
                          return null;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(AppLocalizations.of(context).last_name),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColor.border)),
                width: Utils.displayWidth(context),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: TextFormField(
                      controller: _lnameController,
                      decoration: InputDecoration(
                          hintText: "Enter your lastname",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontStyle: FontStyle.italic)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "* Required";
                        } else
                          return null;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: AppLocalizations.of(context).email,
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: " (${AppLocalizations.of(context).optional})",
                    style: TextStyle(color: Colors.grey))
              ])),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColor.border)),
                width: Utils.displayWidth(context),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: TextFormField(
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                          hintText: "Enter your email",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontStyle: FontStyle.italic)),
                      validator: (value) {
                        if (value.isNotEmpty) {
                          return EmailValidator.validate(value)
                              ? null
                              : "Please enter a valid email";
                        } else
                          return null;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: CustomButton(
                  color: AppColor.base,
                  height: 50,
                  width: Utils.displayWidth(context),
                  inputText: _authProvider.isUserDetails
                      ? Loading()
                      : Text(
                          AppLocalizations.of(context).next.toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                  onPressed: () {
                    if (ownerKey.currentState.validate()) {
                      _authProvider
                          .userDetails(
                              fname: _fnamecontroller.text,
                              lname: _lnameController.text,
                              email: _emailcontroller.text)
                          .then((value) => {
                                if (value)
                                  {
                                    _tabController.index = 1,
                                    print("*** ===============>>>>>>  success"),
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
                                          description:
                                              "User Completed Success"),
                                      duration: Duration(seconds: 2),
                                      position: ToastPosition.bottom,
                                    ),
                                  }
                                else
                                  {
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
                                    )
                                  }
                              });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Store
  Widget store() {
    final _authProvider = Provider.of<AuthProvider>(context);
    Function _agreeTermsFunction() {
      if (agree) {
        return null;
      } else {
        return () {};
      }
    }

    void _createShop() {
      // Do something

      if (storeKey.currentState.validate()) {
        _authProvider
            .createShop(
                name: _shopcontroller.text,
                address: "$locationAddress",
                latitude: "$pickupLat",
                longitude: "$pickupLon",
                zoneId: _myZone)
            .then((value) => {
                  if (value)
                    {
                      _tabController.index = 2,
                      print("*** ===============>>>>>>  success"),
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
                            description:
                                AppLocalizations.of(context).store_created),
                        duration: Duration(seconds: 2),
                        position: ToastPosition.bottom,
                      )
                    }
                  else
                    {
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
                      )
                    }
                });
      }

      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) => PhoneLoginPage()));
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10),
        child: Form(
          key: storeKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context).shop_name),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColor.border)),
                width: Utils.displayWidth(context),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: TextFormField(
                      controller: _shopcontroller,
                      decoration: InputDecoration(
                          hintText: "Enter your shop name",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontStyle: FontStyle.italic)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "* Required";
                        } else
                          return null;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text("Region"),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColor.border)),
                width: Utils.displayWidth(context),
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                icon: (null),
                                value: _myRegion,
                                hint: Text("Select Region"),
                                isExpanded: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _myRegion = newValue;
                                    _getDistricts();
                                    print(_myRegion);
                                  });
                                },
                                items: _isRegionLoading
                                    ? [DropdownMenuItem(child: Loading())]
                                    : regionList.regions.map((item) {
                                        return new DropdownMenuItem(
                                          child: new Text(item.name),
                                          value: item.name,
                                        );
                                      }).toList(),
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 16),
                              )))),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text("District"),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColor.border)),
                width: Utils.displayWidth(context),
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                icon: (null),
                                value: _myDistrict,
                                hint: Text("Select District"),
                                isExpanded: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _myDistrict = newValue;
                                    _getZones();
                                    print(_myDistrict);
                                  });
                                },
                                items: _isDistrictLoading
                                    ? [DropdownMenuItem(child: Loading())]
                                    : districtList.districts.map((item) {
                                        return new DropdownMenuItem(
                                          child: new Text(item.name),
                                          value: item.name,
                                        );
                                      }).toList(),
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 16),
                              )))),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text("zone"),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColor.border)),
                width: Utils.displayWidth(context),
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                icon: (null),
                                value: _myZone,
                                hint: Text("Select Zone"),
                                isExpanded: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _myZone = newValue;
                                    print(_myZone);
                                  });
                                },
                                items: _isZoneLoading
                                    ? [DropdownMenuItem(child: Loading())]
                                    : zoneList.zones.map((item) {
                                        return new DropdownMenuItem(
                                          child: new Text(item.name),
                                          value: item.id,
                                        );
                                      }).toList(),
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 16),
                              )))),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text("${AppLocalizations.of(context).shop_location}*"),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () => _pickupAddress(),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppColor.border)),
                  width: Utils.displayWidth(context),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "$locationAddress",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Container(
                            height: 40,
                            width: Utils.displayWidth(context) * 0.32,
                            decoration: BoxDecoration(
                                color: AppColor.base,
                                borderRadius: BorderRadius.circular(40)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 13,
                                ),
                                Text(
                                  AppLocalizations.of(context).pick_location,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.location_pin,
                                  color: Colors.white,
                                  size: 13,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Material(
                    child: Checkbox(
                      // checkColor: AppColor.base,
                      activeColor: AppColor.base,
                      value: agree,
                      onChanged: (value) {
                        setState(() {
                          agree = value ?? false;
                        });
                      },
                    ),
                  ),
                  const Text(
                    'I have accept',
                    overflow: TextOverflow.ellipsis,
                  ),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AgreeTermsDialog();
                            });
                      },
                      child: Text(
                        'terms and conditions.',
                        style: TextStyle(
                            color: AppColor.preBase,
                            decoration: TextDecoration.underline),
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: agree ? _createShop : null,
                child: const Text('NEXT'),
                style: ElevatedButton.styleFrom(
                    elevation: 1,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(60.0),
                    ),
                    primary: AppColor.base,
                    minimumSize: Size(Utils.displayWidth(context), 50)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Store keeper
  Widget storeKeeper() {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 40),
        child: Form(
          key: keeperKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Store Keeper Firstname"),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColor.border)),
                width: Utils.displayWidth(context),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: TextFormField(
                      controller: _skfnameController,
                      decoration: InputDecoration(
                          hintText: "Enter shop keeper firstname",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontStyle: FontStyle.italic)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text("Store Keeper Lastname"),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColor.border)),
                width: Utils.displayWidth(context),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: TextFormField(
                      controller: _sklnameController,
                      decoration: InputDecoration(
                          hintText: "Enter shopkeeper lastname",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontStyle: FontStyle.italic)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text("${AppLocalizations.of(context).phone_number}*"),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColor.border)),
                width: Utils.displayWidth(context),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: TextFormField(
                      controller: _skphoneController,
                      decoration: InputDecoration(
                        hintText: " 255 *** *** ***",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CheckboxListTile(
                title: Text(
                  AppLocalizations.of(context).give_access,
                  style: TextStyle(color: Color(0xFF31373B)),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                value: _checked,
                onChanged: (bool value) {
                  setState(() {
                    _checked = value;
                  });
                },
                activeColor: AppColor.base,
                checkColor: Colors.white,
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: CustomButton(
                  color: AppColor.base,
                  height: 50,
                  width: Utils.displayWidth(context),
                  inputText: _authProvider.isStoreKeeperLoading
                      ? Loading()
                      : Text(
                          AppLocalizations.of(context).register.toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                  onPressed: () {
                    if (keeperKey.currentState.validate()) {
                      _authProvider
                          .createStorekeeper(
                              firstname: _skfnameController.text,
                              lastname: _sklnameController.text,
                              phone: _skphoneController.text,
                              storeKeeperOrderPermission: _checked)
                          .then((value) => {
                                if (value)
                                  {
                                    print("*** ===============>>>>>>  success"),
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage())),
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
                                          description:
                                              AppLocalizations.of(context)
                                                  .store_created),
                                      duration: Duration(seconds: 2),
                                      position: ToastPosition.bottom,
                                    )
                                  }
                                else
                                  {
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
                                    )
                                  }
                              });
                    }
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
