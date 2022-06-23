import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uza_sales/app/retailer/network/api.dart';
import 'package:http/http.dart' as http;
import 'package:uza_sales/app/sales/model/check_vistor.dart';
import 'package:uza_sales/app/sales/model/visit_model.dart';

class VisitProvider extends ChangeNotifier {
  VisitProvider() {
    // fetchVisit();
  }

// variable
  bool _isVisitLoad = false;
  SharedPreferences sharedPreferences;
  String accessToken;
  VisitModel _availableVisit;
  // String date = "2022-01-30";
  String status = "ACTIVE";

// getter
  VisitModel get availableVisit => _availableVisit;
  bool get isVisitLoad => _isVisitLoad;

  // **** fetch Ads *****
  Future<void> fetchVisit(date) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    print("Date: $date");
    print("***** Access Token  ****");
    bool hasError = true;
    _isVisitLoad = true;
    notifyListeners();
    Map<String, dynamic> _data = {"page": 0, "size": 25};

    var url = Uri.parse(api + "visit/myVisits");
    final http.Response response = await http.post(url,
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "Accept": "Application/json",
          "Content-Type": "Application/json"
        },
        body: jsonEncode(_data));
    print("*********   response body *******");
    print(response.body);
    print("***************************************");
    try {
      if (response.statusCode == 200) {
        var result = visitModelFromJson(response.body);
        _availableVisit = result;
        _isVisitLoad = false;
        notifyListeners();
        print("*********   routes provider *******");
        print(_availableVisit);
        print("***************************************");
      } else {
        print("something went wrong");
      }
    } catch (e) {
      print("*** Error on fetching targets ****");
      print(e);
    }

    return hasError;
  }

  // **** fetch Ads *****
  Future<bool> checkIn(
      {@required String routeId,
      @required String storeId,
      @required String checkInTime,
      @required bool isOrderPending,
      @required String shopStatus,
      @required String nextApp,
      @required String image}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    print({
      "routeId": routeId,
      "storeId": storeId,
      "checkInTime": checkInTime,
      "isOrderPending": isOrderPending,
      "nextAppointment": nextApp,
      "image": image
    });
    Map<String, dynamic> _data = {
      "routeId": routeId,
      "storeId": storeId,
      "checkInTime": checkInTime,
      "checkOutTime": "",
      "isOrderPending": true,
      "shopStatus": shopStatus,
      "nextAppointment": nextApp,
      "image": image
    };
    print("***** Access Token  ****");
    bool hasError = true;
    _isVisitLoad = true;
    notifyListeners();
    var url = Uri.parse(base + "visit/save");
    print(url);
    final http.Response response = await http.post(url,
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "Accept": "Application/json",
          "Content-Type": "Application/json"
        },
        body: jsonEncode(_data));
    print("******** responce from check in *********");
    print(response.body);

    try {
      if (response.statusCode == 200) {
        var result = checkVisitorFromJson(response.body);
        print("********** check in visitors ********");
        print(result.data.id);
        sharedPreferences.setString("visitId", result.data.id);
        sharedPreferences.setString("storeId", storeId);
        sharedPreferences.setBool("isCheckIn", true);
        notifyListeners();
        print("**************************");
      } else {
        print("something went wrong");
      }
    } catch (e) {
      print("*** Error on checkin visitors ****");
      print(e);
    }

    return hasError;
  }

  // check out time
  Future<void> checkOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    String visitId = sharedPreferences.getString("visitId");
    print({"visitId": visitId});
    Map<String, dynamic> _data = {"visitId": visitId};
    print("***** Access Token  ****");
    bool hasError = true;
    _isVisitLoad = true;
    notifyListeners();
    var url = Uri.parse(base + "visit/check_out?visitId=$visitId");
    print(url);
    final http.Response response = await http.post(url,
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "Accept": "Application/json",
          "Content-Type": "Application/json"
        },
        body: jsonEncode(_data));
    print("******** responce from check out *********");
    print(response.body);
    try {
      if (response.statusCode == 200) {
        var result = checkVisitorFromJson(response.body);
        print("********** check out visitors ********");
        print(result);
        sharedPreferences.setBool("isCheckIn", false);
        notifyListeners();
        print("**************************");
      } else {
        print("something went wrong");
        sharedPreferences.setBool("isCheckIn", false);
      }
    } catch (e) {
      print("*** Error on checkout ****");
      print(e);
    }

    return hasError;
  }

  getValue(double sale, double target) {
    double percent = 0;
    percent = (sale * 100.0) / (target);
    return percent;
  }
}
