import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/provider/auth_provider.dart';
import 'package:uza_sales/app/retailer/screen/accounts_screen.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/button/custom_buton.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uza_sales/app/sales/model/route_model.dart';
import 'package:uza_sales/app/sales/pages/sales_home.dart';

class EditRoutesStore extends StatefulWidget {
  final SalesStore stores;

  const EditRoutesStore({Key key, @required this.stores}) : super(key: key);

  @override
  _EditRoutesStoreState createState() => _EditRoutesStoreState();
}

class _EditRoutesStoreState extends State<EditRoutesStore> {
  String phone;
  String accessToken;
  String address;
  String shopName;
  String pickupLat = "";
  String pickupLon = "";
  TextEditingController _shopController = TextEditingController();
  TextEditingController _keeperNameController = TextEditingController();
  TextEditingController _keeperNoController = TextEditingController();
  GlobalKey<FormState> storeKey = GlobalKey<FormState>();

  _loadUsers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      this.phone = sharedPreferences.getString('phone');
      this.accessToken = sharedPreferences.getString('accessToken');
      this.address = sharedPreferences.getString('address');
      this.shopName = sharedPreferences.getString('shopName');
      if (this.phone == null) {
        this.phone = "255 *** *** ***";
      }
      if (this.address == null) {
        this.address = "Dar es salaam, Tanzaniia";
      }
      if (this.shopName == null) {
        this.shopName = "Default Shop";
      }
      print("*****  phone number");
      print("phone: ${this.phone}");
    });
  }

  // change Location
  _changeLocation() async {
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
          hintText: 'Change Location',
          useCurrentLocation: true,
        ),
      ),
    );
  }

  bool _checked = false;
  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.bgScreen,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        // title: Text(
        //   AppLocalizations.of(context).profile_settings,
        //   style: TextStyle(color: Colors.black),
        // ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                      controller: _shopController,
                      decoration: InputDecoration(
                        hintText: "${this.widget.stores.name}",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        print(value);
                        // this.shopName = value;
                      },
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return "* Required";
                      //   } else
                      //     return null;
                      // },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
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
                      // controller: _lnameController,
                      decoration: InputDecoration(
                        hintText: "${this.widget.stores.phone}",
                        enabled: false,
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "* Required";
                        } else
                          return null;
                      },
                      onSaved: (value) {},
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(AppLocalizations.of(context).shop_location),
              SizedBox(
                height: 15,
              ),
              Container(
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
                              hintText: "${this.widget.stores.address}",
                              border: InputBorder.none,
                              enabled: false),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: InkWell(
                          onTap: () => _changeLocation(),
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
                                  "Change Location",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.location_pin,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(AppLocalizations.of(context).shop_keeper_name),
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
                      controller: _keeperNameController,
                      decoration: InputDecoration(
                        hintText: "Masawe",
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "* Required";
                        } else
                          return null;
                      },
                      onSaved: (value) {},
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(AppLocalizations.of(context).shop_keeper_no),
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
                      controller: _keeperNoController,
                      decoration: InputDecoration(
                        hintText: "+255 *** *** ***",
                        border: InputBorder.none,
                      ),
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return "*";
                      //   } else
                      //     return null;
                      // },
                      // onSaved: (value) {
                      // },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
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
                  inputText: Text(
                    AppLocalizations.of(context).save.toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  onPressed: () {
                    //  if (storeKey.currentState.validate()) {
                    _authProvider
                        .updateStore(
                            firstname: _keeperNameController.text,
                            lastname: "Mussa",
                            storeKeeperOrderPermission: _checked,
                            name: "${this.shopName}",
                            address: "${this.address}",
                            latitude: "$pickupLat",
                            longitude: "$pickupLon",
                            zoneId: "61d4454ab62e2aacded735f7",
                            phone: _keeperNoController.text)
                        .then((value) => {
                              if (value)
                                {
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
                                        description: "store updated"),
                                    duration: Duration(seconds: 2),
                                    position: ToastPosition.bottom,
                                  ),
                                  Navigator.of(context).pop()
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
                    // }
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => PhoneLoginPage()));
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
