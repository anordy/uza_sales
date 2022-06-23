import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:mime/mime.dart';
import 'package:uza_sales/app/retailer/model/auth_response.dart';
import 'package:http/http.dart' as http;
import 'package:uza_sales/app/retailer/model/country_model.dart';
import 'package:uza_sales/app/retailer/model/shop_response.dart';
import 'package:uza_sales/app/retailer/model/store_keeper_responce.dart';
import 'package:uza_sales/app/retailer/model/user_responce.dart';
import 'package:uza_sales/app/retailer/network/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/cupertino.dart';

import 'package:http_parser/http_parser.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    //  getCountry();
  }

  // variable
  bool _isLoading = false;
  bool _isVerifyingCode = false;
  bool _isSendingPhone = false;
  bool _isSupplier = false;
  bool _isOrderBooker = false;
  bool _isRetailer = false;
  bool _isuserDetails = false;
  bool _isShopLoading = false;
  bool _isStoreKeeperLoading = false;
  bool _hasError = false;
  List<Country> _countryList;
  List<Country> _regionList = [];
  AuthResponce _authResponce;
  String accessToken;
  // getters
  bool get isLoading => _isLoading;
  bool get isSupplier => _isSupplier;
  bool get isOrderBooker => _isOrderBooker;
  bool get isRetailer => _isRetailer;
  List<Country> get countryList => _countryList;
  List<Country> get selectedRegion => _regionList;
  bool get isUserDetails => _isuserDetails;
  bool get isShopLoading => _isShopLoading;
  bool get isStoreKeeperLoading => _isStoreKeeperLoading;
  bool get isVerifyingCode => _isVerifyingCode;
  AuthResponce get authResponce => _authResponce;
  bool get isSendingPhone => _isSendingPhone;
  PhoneNumber _phoneNumber;

// signup
  Future<bool> signUp({String phone}) async {
    _isSendingPhone = true;
    _hasError = true;
    notifyListeners();
    print({"phone_no": phone});
    Map<String, String> data = {"phone": phone};
    var url = Uri.parse(base + "auth/signup/v2");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode(data));
    // print(response.body);
    try {
      if (response.statusCode == 200) {
        var result = authResponceFromJson(response.body);
        print("******* Auth Response ******");
        print(result);
        print("AuthReso=ponse    $authResponce");
        _isSendingPhone = false;
        _hasError = false;
        notifyListeners();
      } else {
        _isSendingPhone = false;
        _hasError = true;
        print("**** Error from  sending otp ****");
        var result = authResponceFromJson(response.body);
        _authResponce = result;
        print(_authResponce.message.en);
        notifyListeners();
      }
    } catch (e) {
      print("catch");
      _hasError = true;
      print(e);
    }
    return _hasError;
  }

// Login
  Future<bool> login({String phone}) async {
    _isSendingPhone = true;
    _hasError = true;

    notifyListeners();
    print({"phone_no": phone});
    Map<String, String> data = {"phone": phone};
    var url = Uri.parse(api + "auth/app_login");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode(data));
    print(response.body);
    try {
      if (response.statusCode == 200) {
        var result = authResponceFromJson(response.body);
        print("******* Auth Response ******");
        print(result);
        print("AuthReso=ponse    $authResponce");
        _isSendingPhone = false;
        _hasError = false;
        notifyListeners();
      } else {
        _isSendingPhone = false;
        _hasError = true;
        print("**** Error from  sending otp ****");
        var result = authResponceFromJson(response.body);
        _authResponce = result;
        print(_authResponce.message.en);
        notifyListeners();
      }
    } catch (e) {
      print("catch");
      _hasError = true;
      print(e);
    }
    return _hasError;
  }

  // verify otp
  Future<bool> verifyOtp({String phone, String otp}) async {
    _isSupplier = false;
    _isRetailer = false;
    _isVerifyingCode = true;
    _hasError = true;
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print({"phone": phone, "otp": otp});
    Map<String, String> data = {
      "phone": phone,
      "otp": otp,
    };
    var url = Uri.parse(api + "auth/app_user_verification");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode(data));
    print(response.body);
    try {
      if (response.statusCode == 200) {
        var result = userResponceFromJson(response.body);
        print("******* User role Response ******");
        print("***** sales Person *****");
        _isSupplier = result.roles.contains("ROLE_SUPPLIER");
        print("isSupplier:  $_isSupplier");
        print("*******************************");

        print("==============   role order booker  =============");
        print(result.roles.contains("ROLE_ORDER_BOOKER"));
        _isOrderBooker = result.roles.contains("ROLE_ORDER_BOOKER");
        print("isOrderBooker:  $_isOrderBooker");
        print("===========================================");

        print(result.roles.contains("ROLE_SUPPLIER"));
        _isRetailer = result.roles.contains("ROLE_RETAILER");
        print("isRetailer:  $_isRetailer");
        print("*******************************");

        // print(result.username);
        print(result.accessToken);
        sharedPreferences.setString("phone", result.username);
        sharedPreferences.setString("fname", result.firstname);
        sharedPreferences.setBool("isLoggedIn", true);
        sharedPreferences.setBool(
            "isSupplier", result.roles.contains("ROLE_SUPPLIER"));
        sharedPreferences.setBool(
            "isRetailer", result.roles.contains("ROLE_RETAILER"));
        sharedPreferences.setBool(
            "isOrderBooker", result.roles.contains("ROLE_ORDER_BOOKER"));
        sharedPreferences.setString("accessToken", result.accessToken);
        _isVerifyingCode = false;
        _hasError = false;
        notifyListeners();
      } else {
        print("**** Error on user  ****");
        _isVerifyingCode = false;
        _hasError = true;
      }
    } catch (e) {
      print(" catch on verify");
      print(e);
      _hasError = true;
      _isVerifyingCode = false;
    }
    return _hasError;
  }

  // owner details
  Future<bool> storeOwner(
      {String phone, String fname, String lname, String email}) async {
    _isuserDetails = true;
    _hasError = true;
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    print({"phone": phone, "fname": fname, "lname": lname, "email": email});
    Map<String, String> data = {
      "phone": phone,
      "firstname": fname,
      "lastname": lname,
      "emails": email
    };
    var url = Uri.parse(api + "user/update/v2");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode(data));
    print(response.body);
    if (response.statusCode == 200) {
      var result = authResponceFromJson(response.body);
      print("******* owner Response ******");
      print(result);
      _isuserDetails = false;
      // print(result.username);
      // print(result.accessToken);
      // sharedPreferences.setString("phone", result.username);
      // sharedPreferences.setString("accessToken", result.accessToken);

      notifyListeners();
    } else {
      print("**** Error on details user  ****");
      _isuserDetails = false;
      _hasError = true;
    }
    return _hasError;
  }

  // user details
  Future<bool> userDetails({String fname, String lname, String email}) async {
    _isuserDetails = true;
    _hasError = true;
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    print({"fname": fname, "lname": lname, "email": email});
    Map<String, String> data = {
      "firstname": fname,
      "lastname": lname,
      "emails": email
    };
    var url = Uri.parse(api + "user/update/v2");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode(data));
    print(response.body);
    if (response.statusCode == 200) {
      var result = authResponceFromJson(response.body);
      print("******* Details Response ******");
      print(result);
      _isuserDetails = false;
      // print(result.username);
      // print(result.accessToken);
      // sharedPreferences.setString("phone", result.username);
      // sharedPreferences.setString("accessToken", result.accessToken);

      notifyListeners();
    } else {
      print("**** Error on details user  ****");
      _isuserDetails = false;
      _hasError = true;
    }
    return _hasError;
  }

  // create sales shop
  Future<bool> createSalesShop({
    @required String name,
    @required String address,
    @required String latitude,
    @required String longitude,
    @required String category,
    @required String images,
    @required String phone,
    @required String zoneId,
  }) async {
    // String accessT ="eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyNTU3NjQ3ODg4NjIiLCJpYXQiOjE2NDM0NTI2MTgsImV4cCI6MTY0NDc0ODYxOH0.PXa7ILJoolZ98W0jMP-zY94Zdjbz-4HilImIgW2DzJ9fC6TiDf0mN1PvDwEmImEiBy-8PqlTER7vxVkViahC4w";
    _isShopLoading = true;
    _hasError = true;
    notifyListeners();
    print("hello");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    print({
      "name": name,
      "address": address,
      "location": {"latitude": latitude, "longitude": longitude},
      "storeOwnerId": "id",
      "zoneId": zoneId,
      "category": category,
      "phone": phone,
      "image": images
    });
    Map<String, dynamic> data = {
      "name": name,
      "address": address,
      "location": {"latitude": latitude, "longitude": longitude},
      "storeOwnerId": "id",
      "zoneId": zoneId,
      "category": category,
      "phone": phone,
      "image": images
    };
    Map<String, String> _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    var url = Uri.parse(api + "store/save");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode(data));
    print(response.body);
    if (response.statusCode == 200) {
      var result = shopResponceFromJson(response.body);
      print("******* Store  Response ******");
      print(result);
      _isShopLoading = false;
      // print("******n  Address  ******");
      // print(result.data.address);

      // print("******n  Shop name  ******");
      // print(result.data.name);
      // print(result.accessToken);

      sharedPreferences.setString("shopName", result.data.name);
      sharedPreferences.setString("shopId", result.data.id);

      notifyListeners();
    } else {
      print("**** Error on  create store  ****");
      _isShopLoading = false;
      _hasError = true;
    }
    return _hasError;
  }

// order booker
  // create sales shop
  Future<bool> createOrderBookerShop({
    @required String name,
    @required String address,
    @required String latitude,
    @required String longitude,
    @required String category,
    @required String images,
    @required String phone,
    @required String zoneId,
  }) async {
    // String accessT ="eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyNTU3NjQ3ODg4NjIiLCJpYXQiOjE2NDM0NTI2MTgsImV4cCI6MTY0NDc0ODYxOH0.PXa7ILJoolZ98W0jMP-zY94Zdjbz-4HilImIgW2DzJ9fC6TiDf0mN1PvDwEmImEiBy-8PqlTER7vxVkViahC4w";
    _isShopLoading = true;
    _hasError = true;
    notifyListeners();
    print("hello");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    print({
      "name": name,
      "address": address,
      "location": {"latitude": latitude, "longitude": longitude},
      "storeOwnerId": "id",
      "zoneId": zoneId,
      "category": category,
      "phone": phone,
      "image": images
    });
    Map<String, dynamic> data = {
      "name": name,
      "address": address,
      "location": {"latitude": latitude, "longitude": longitude},
      "storeOwnerId": "id",
      "zoneId": zoneId,
      "category": category,
      "phone": phone,
      "image": images
    };
    Map<String, String> _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    var url = Uri.parse(api + "store/save");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode(data));
    print(response.body);
    if (response.statusCode == 200) {
      var result = shopResponceFromJson(response.body);
      print("******* Store  Response ******");
      print(result);
      _isShopLoading = false;
      // print("******n  Address  ******");
      // print(result.data.address);

      // print("******n  Shop name  ******");
      // print(result.data.name);
      // print(result.accessToken);

      sharedPreferences.setString("shopName", result.data.name);
      sharedPreferences.setString("shopId", result.data.id);

      notifyListeners();
    } else {
      print("**** Error on  create store  ****");
      _isShopLoading = false;
      _hasError = true;
    }
    return _hasError;
  }

// create shop
  Future<bool> createShop(
      {@required String name,
      @required String address,
      @required String latitude,
      @required String longitude,
      @required zoneId}) async {
    _isShopLoading = true;
    _hasError = true;
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    print({
      "name": name,
      "address": address,
      "location": {"latitude": latitude, "longitude": longitude},
      "zoneId": zoneId
    });
    Map<String, dynamic> data = {
      "name": name,
      "address": address,
      "location": {"latitude": latitude, "longitude": longitude},
      "zoneId": zoneId
    };
    var url = Uri.parse(api + "order_booker/save_store");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode(data));
    print(response.body);
    if (response.statusCode == 200) {
      var result = shopResponceFromJson(response.body);
      print("******* Store  Response ******");
      print(result);
      _isShopLoading = false;
      print("******n  shop Id  ******");
      print(result.data.id);

      print("******  Shop name  ******");
      print(result.data.name);
      // print(result.accessToken);
      sharedPreferences.setString("shopName", result.data.name);
      sharedPreferences.setString("shopId", result.data.id);
      notifyListeners();
    } else {
      print("**** Error on  create store  ****");
      _isShopLoading = false;
      _hasError = true;
    }
    return _hasError;
  }

// create storekeeper
  Future<bool> createStorekeeper({
    @required String firstname,
    @required String lastname,
    @required String phone,
    @required bool storeKeeperOrderPermission,
  }) async {
    _isStoreKeeperLoading = true;
    _hasError = true;
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    String shopId = sharedPreferences.getString('shopId');
    print({
      "firstname": firstname,
      "lastname": lastname,
      "phone": phone,
      "storeKeeperOrderPermission": storeKeeperOrderPermission,
    });
    Map<String, dynamic> data = {
      "firstname": firstname,
      "lastname": lastname,
      "phone": phone,
      "storeKeeperOrderPermission": storeKeeperOrderPermission,
    };
    var url = Uri.parse(api + "store/store-keeper?id=$shopId");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode(data));
    print(response.body);
    if (response.statusCode == 200) {
      var result = storeKeeperFromJson(response.body);
      print("******* Store keeper Response ******");
      print(result);
      // sharedPreferences.setString("shopName", result.data.name);
      // sharedPreferences.setString("shopId", result.data.id);
      _isStoreKeeperLoading = false;
      notifyListeners();
    } else {
      print("**** Error on  create store  ****");
      _isStoreKeeperLoading = false;
      _hasError = true;
    }
    return _hasError;
  }

// create shop
  Future<bool> updateStore(
      {@required String firstname,
      @required String lastname,
      @required bool storeKeeperOrderPermission,
      @required String phone,
      @required String name,
      @required String address,
      @required String latitude,
      @required String longitude,
      @required zoneId}) async {
    _isShopLoading = true;
    _hasError = true;
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    String shopId = sharedPreferences.getString("shopId");
    print({
      "shopId": shopId,
      "firstname": firstname,
      "lastname": lastname,
      "phone": phone,
      "storeKeeperOrderPermission": true,
      "name": name,
      "address": address,
      "location": {"latitude": latitude, "longitude": longitude},
      "storeOwnerId": "id",
      "zoneId": zoneId
    });
    Map<String, dynamic> data = {
      "firstname": firstname,
      "lastname": lastname,
      "phone": phone,
      "storeKeeperOrderPermission": true,
      "name": name,
      "address": address,
      "location": {"latitude": latitude, "longitude": longitude},
      "storeOwnerId": "id",
      "zoneId": zoneId
    };
    var url = Uri.parse(api + "store/update_v2");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode(data));
    //     print(" ****  responce body from update store *****");
    // print(response.body);
    // print("****************");
    if (response.statusCode == 200) {
      var result = shopResponceFromJson(response.body);
      // print("******* Store  update Response ******");
      // print(result.data.name);
      _isShopLoading = false;
      // print("******n  Address  ******");
      // print(result.data.address);

      // print("******n  Shop name  ******");
      // print(result.data.name);
      // print(result.accessToken);

      sharedPreferences.setString("shopName", result.data.name);
      sharedPreferences.setString("shopId", result.data.id);

      notifyListeners();
    } else {
      // print("**** Error on  update store  ****");
      _isShopLoading = false;
      _hasError = true;
    }
    return _hasError;
  }
}
