import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uza_sales/app/retailer/model/ads_model.dart';
import 'package:uza_sales/app/retailer/model/deals_model.dart';
import 'package:uza_sales/app/retailer/model/points_model.dart';
import 'package:uza_sales/app/retailer/network/api.dart';
import 'package:http/http.dart' as http;

class AdsProvider extends ChangeNotifier {
  AdsProvider() {
    fetchPoints();
    fetchAds();
    fetchDeals();
  }

// variable
  bool _isLoading = false;
  bool _isDealLoading;
  SharedPreferences sharedPreferences;
  String accessToken;
  List<Ads> _availableAds = [];
  List<Deals> _availableDeals = [];
  Points _availablePoints;
  String status = "ACTIVE";
// getter
  List<Ads> get availableAds => _availableAds;
  Points get availablePoints => _availablePoints;
  List<Deals> get availableDeals => _availableDeals;
  bool get isLoading => _isLoading;
  bool get isDealLoading => _isDealLoading;

  // **** fetch Ads *****
  Future<void> fetchAds() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    // print("***** Access Token fromAds ****");
    // print(this.accessToken);
    bool hasError = true;
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> _data = {"Size": 100, "page": 0};
    var url = Uri.parse(api + "ads/get?status=ACTIVE");
    print("Ads-url: $url");
    final http.Response response = await http.post(url,
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "Accept": "Application/json",
          "Content-Type": "Application/json"
        },
        body: jsonEncode(_data));
    // print("****** response from Ads *******");
    // print(response.body);
    // print("================================");
    try {
      if (response.statusCode == 200) {
        final result = adsDataFromJson(response.body);
        print(result);
        _availableAds = result.ads;
        print("======  available Ads ====");
        print(availableAds);
        print("================================");
        _isLoading = false;
        // print(_availableAds);
        //     print("======================================");

        notifyListeners();
      } else {
        print("******  Error from fetching ads ******");
        hasError = true;
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print("******* error on fetching Ads *****");
      print(e);
      hasError = true;
      _isLoading = false;
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
    return hasError;
  }

// **** fetch Deals *****
  Future<void> fetchDeals() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    this.accessToken = sharedPreferences.getString("accessToken");
    // print("*************  access tooooken from deals ******");
    // print(this.accessToken);
    bool hasError = true;
    _isDealLoading = true;
    notifyListeners();

    Map<String, dynamic> _data = {"page": "0", "size": "100"};
    var url = Uri.parse(api + "campaign/get?status=$status");
    print(url);
    final http.Response response = await http.post(url,
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: "Application/json",
          "Authorization": "Bearer $accessToken",
          "Accept": "Application/json",
        },
        body: jsonEncode(_data));
    // print("****** response from Deals *******");
    // print(response.body);
    // print("****************************");
    try {
      if (response.statusCode == 200) {
        final result = dealsFromJson(response.body);
        print(result);
        _availableDeals = result;
        // print("======  available Deals ====");
        // print(availableDeals);
        _isDealLoading = false;
        // print(_availableDeals);
        // print("======================================");

        notifyListeners();
      } else {
        print("******  Error from fetching Deals ******");
        hasError = true;
        _isDealLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print("******* error on fetching Deals *****");
      print(e);
      hasError = true;
      _isDealLoading = false;
      notifyListeners();
    }
    _isDealLoading = false;
    notifyListeners();
    return hasError;
  }

  // **** fetch POints *****
  Future<void> fetchPoints() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    // print("***** Access Token fromAds ****");
    // print(this.accessToken);
    bool hasError = true;
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> _data = {"Size": 100, "page": 0};
    var url = Uri.parse(api + "store/store_points");
    print("Ads-url: $url");
    final http.Response response = await http.post(url,
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "Accept": "Application/json",
          "Content-Type": "Application/json"
        },
        body: jsonEncode(_data));
    print("****** response from POints *******");
    print(response.body);
    print("================================");
    try {
      if (response.statusCode == 200) {
        final result = pointsFromJson(response.body);
        print(result);
        _availablePoints = result;
        print("======  available Points ====");
        print(availablePoints);
        print("================================");
        _isLoading = false;
        // print(_availableAds);
        //     print("======================================");

        notifyListeners();
      } else {
        print("******  Error from fetching ads ******");
        hasError = true;
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print("******* error on fetching Points *****");
      print(e);
      hasError = true;
      _isLoading = false;
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
    return hasError;
  }
}
