import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uza_sales/app/retailer/network/api.dart';
import 'package:http/http.dart' as http;
import 'package:uza_sales/app/sales/model/route_model.dart';

class RouteProvider extends ChangeNotifier {
  RouteProvider() {
    fetchRoutes();
  }

// variable
  bool _isLoading = false;
  bool _isRouteLoading;
  int _selectedRoute = 0;
  int _selectedStore = 0;
  SharedPreferences sharedPreferences;
  String accessToken;
  List<MyRoute> _allRoutes = [];
  List<MyRoute> _availableRoute = [];
  List<SalesStore> _availableStores = [];
  List<String> _storeNames = [];
  List<Location> _availableLocation = [];
  String date = "2022-01-30";
  String status = "ACTIVE";

// getter
  List<MyRoute> get allRoutes => _allRoutes;
  List<MyRoute> get availableRoute => _availableRoute;
  int get selectedRoute => _selectedRoute;
  int get selectedStore => _selectedStore;
  List<SalesStore> get availableStores => _availableStores;
  List<Location> get availableLocation => _availableLocation;
  bool get isLoading => _isLoading;
  List<String> get storeNames => _storeNames;
  bool get isRouteLoading => _isRouteLoading;

  // **** fetch Routes *****
  Future<void> fetchRoutes() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    print("***** Access Token  ****");
    bool hasError = true;
    _isLoading = true;
    _isRouteLoading = true;
    notifyListeners();
    Map<String, dynamic> _data = {"page": 0, "size": 100};
    var url = Uri.parse(api + "route/myRoute");
    final http.Response response = await http.post(url,
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "Accept": "Application/json",
          "Content-Type": "Application/json"
        },
        body: jsonEncode(_data));
    print("*********   routes provider *******");
    // print(response.body);
    print("***************************************");
    if (response.statusCode == 200) {
      var dataResponse = jsonDecode(response.body);
      print(dataResponse);
      if (dataResponse.containsKey("data")) {
        print("====== no data  =======");
        _availableRoute.clear();
        _isRouteLoading = false;
        notifyListeners();
        return;
      }
      var result = routeModelFromJson(response.body);
      _allRoutes = result.content.route;

      for (var store in _allRoutes[_selectedRoute].stores) {
        _availableLocation.add(store.location);
        _storeNames.add(store.name);
      }
      print("********* location  routes provider *******");
      print(_availableLocation);
      print(_storeNames);
      print("=================================");
      _isRouteLoading = false;
      searchRoute("");
      notifyListeners();
    } else {
      print("========   Error  has occured on route  ======");
      _isRouteLoading = false;
      notifyListeners();
    }
    return hasError;
  }

  setSelectedRoute(int routeIndex, int storeIndex) {
    _selectedRoute = routeIndex;
    _selectedStore = storeIndex;
    print("SelectedRoute:   $_selectedRoute");
    print("SelectedStore:   $_selectedStore");
  }

  // search route by lists
  void searchRoute(String enteredKeyword) {
    print("key:  $enteredKeyword");
    List<MyRoute> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allRoutes;
      print("==============   search  route  if field is empty =============");
      print(results);
      print("================================================");
      notifyListeners();
    } else {
      print("selectedStore: $_selectedStore");
      print("selectedRoute: $_selectedRoute");

      results = _allRoutes
          .where((route) => route.stores[0].name
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();

      print("==============   search  route when field has data =============");
      print(results);
      print(
          "===================================================================");
      notifyListeners();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    _availableRoute = results;
    print("==============   search  from routes available =============");
    print(_availableRoute);
    print("================================================");
    notifyListeners();
  }
}
