import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uza_sales/app/orderBooker/model/home_summary_model.dart';
import 'package:uza_sales/app/retailer/network/api.dart';
import 'package:http/http.dart' as http;
import 'package:uza_sales/app/sales/model/target_model.dart';

class TargetProvider extends ChangeNotifier {
  TargetProvider() {
    // fetchTarget();
    fetchSummary();
  }

// variable
  bool _isLoading = false;
  bool _isTarget = false;
  SharedPreferences sharedPreferences;
  String accessToken;
  Target _availableTarget;
  HomeSummary _homeSummary;
  String date = "2022-01-30";
  String status = "ACTIVE";

// getter
  Target get availableTarget => _availableTarget;
  HomeSummary get homeSummary => _homeSummary;
  bool get isLoading => _isLoading;
  bool get isTarget => _isTarget;

  // **** fetch Targgets *****
  Future<void> fetchTarget() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    print("***** Access Token  ****");
    bool hasError = true;
    _isLoading = true;
    _isTarget = true;
    var url = Uri.parse(
        api + "target/my_target?startDate=2022-02-01&endDate=2022-02-28");
    final http.Response response =
        await http.get(url, headers: <String, String>{
      "Authorization": "Bearer $accessToken",
      "Accept": "Application/json",
      "Content-Type": "Application/json"
    });
    // print(response.body);
    try {
      if (response.statusCode == 200) {
        var result = targetFromJson(response.body);
        _availableTarget = result;
        _isLoading = false;
        _isTarget = false;
        notifyListeners();
        // print("*********   Targets provider *******");
        // print(_availableTarget);
        // print("***************************************");
      } else {
        print("something went wrong");
      }
    } catch (e) {
      print("*** Error on fetching targets ****");
      print(e);
    }

    return hasError;
  }

  // **** fetch home summary *****
  Future<void> fetchSummary() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    print("***** Access Token  ****");
    bool hasError = true;
    _isLoading = true;
    _isTarget = true;
    var url = Uri.parse(
        api + "/home-summary/get?startDate=2022-03-23&endDate=2022-03-23");
    final http.Response response =
        await http.get(url, headers: <String, String>{
      "Authorization": "Bearer $accessToken",
      "Accept": "Application/json",
      "Content-Type": "Application/json"
    });
    print("============ response body ==============");
    print(response.body);
    try {
      if (response.statusCode == 200) {
        var result = homeSummaryFromJson(response.body);
        _homeSummary = result;
        _isLoading = false;
        _isTarget = false;
        notifyListeners();
        print("*********   Home summary  provider *******");
        print(_homeSummary);
        print("***************************************");
      } else {
        print("something went wrong");
      }
    } catch (e) {
      print("*** Error on fetching summary screen ****");
      print(e);
    }
    return hasError;
  }
}
