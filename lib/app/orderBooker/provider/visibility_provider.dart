import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uza_sales/app/retailer/network/api.dart';
import 'package:http/http.dart' as http;
import 'package:uza_sales/app/sales/model/visibility_model.dart';

class VisibilityProvider extends ChangeNotifier {
// variable
  bool _isLoading = false;
  bool _isPOS = false;
  SharedPreferences sharedPreferences;
  String accessToken;
  PosVisibility _availableVisibility;

// getter
  PosVisibility get availableVisibilty => _availableVisibility;
  bool get isLoading => _isLoading;
  bool get isPOS => _isPOS;

//  ============  post PosVisibility   =============
  Future<void> savePos({
    @required String storeId,
    @required String comment,
    @required List<String> images,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    String visitId = sharedPreferences.getString("visitId");
    print({
      "storeId": storeId,
      "visitId": visitId,
      "comment": comment,
      "images": images,
    });
    Map<String, dynamic> _data = {
      "storeId": storeId,
      "visitId": visitId,
      "comment": comment,
      "images": images,
    };
    bool hasError = true;
    _isLoading = true;
    _isPOS = true;
    notifyListeners();
    var url = Uri.parse(api + "pos-visibility/save");
    print(url);
    final http.Response response = await http.post(url,
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "Accept": "Application/json",
          "Content-Type": "Appliation/json"
        },
        body: jsonEncode(_data));
    print("******** responce from pos PosVisibility *********");
    print(response.body);
    print("==========================================");

    try {
      if (response.statusCode == 200) {
        var result = visibilityFromJson(response.body);
        print("**********  pos visibility  ********");
        print(result);
        _isPOS = false;
        // sharedPreferences.setString("visitId", result.data.id);
        notifyListeners();
        print("**************************");
      } else {
        print("something went wrong");
        _isPOS = false;
        notifyListeners();
      }
    } catch (e) {
      print("*** Error on pos visiibility ****");
      print(e);
      _isPOS = false;
      notifyListeners();
    }

    return hasError;
  }
}
