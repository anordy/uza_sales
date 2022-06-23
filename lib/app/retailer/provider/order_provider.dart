import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uza_sales/app/retailer/model/auth_response.dart';
import 'package:uza_sales/app/retailer/model/order_model.dart';
import 'package:uza_sales/app/retailer/model/pay_later_model.dart';
import 'package:uza_sales/app/retailer/network/api.dart';

class OrderProvider extends ChangeNotifier {
  OrderProvider() {
    fetchOrders('PENDING');
  }

// variable
  bool _isOrderLoading = false;
  String accessToken = '';
  bool _hasError = false;
  bool _isOrderEmpty = false;
  // Order _selectedOrder;
  bool _isSubmitingData = false;
  List<Order> _availlableOrders = [];
  List<Order> _pendingOrders = [];
  bool get hasError => _hasError;
  List<Order> _placedOrders = [];
  Order _fetchedOrder;
  SharedPreferences sharedPreferences;

// getter
  bool get isOrderLoading => _isOrderLoading;
  Order get fetchedOrder => _fetchedOrder;
  bool get isOrderEmpty => _isOrderEmpty;
  List<Order> get pendingOrder => _pendingOrders;
  List<Order> get availableOrders => _availlableOrders;
  bool get isSubmittingData => _isSubmitingData;

  // **** fetch orders *****
  Future<void> fetchOrders(String status) async {
    // final List<Order> _fetchedOrders = [];
    sharedPreferences = await SharedPreferences.getInstance();
    print("""Orderr token """);
    print({'status': status});
    this.accessToken = sharedPreferences.getString("accessToken");
    print(this.accessToken);
    bool hasError = true;
    _isOrderLoading = true;
    notifyListeners();
    var url = Uri.parse(api + "order/myOrders?status=$status");
    print('order-url: $url');
    final http.Response response = await http.get(url,
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "Accept": "Application/json"
        });
    // final Map<String, dynamic> ordersMap = json.decode(response.body);
    print(response.body);
    try {
      availableOrders.clear();
      if (response.statusCode == 200) {
        final result = orderFromJson(response.body);
        print(result);
        _availlableOrders = result;
        print("======  available orders ====");
        print(availableOrders);
        _isOrderLoading = false;
        print(_availlableOrders[0].items[0].totalPrice);
        print("======================================");
        // ordersMap['orders'].forEach((orderMap) {
        //   _fetchedOrders.add(Order.fromJson(orderMap));
        //   // _availableOrders = _fetchedOrders;
        //   notifyListeners();
        // }

        // );
        //** available orders  */

        // ** completed orders
        // _completedOrders = availableOrders
        //     .where((o) => o.shippingStatus == "delivered")
        //     .toList();

        // ** pending orders
        // _pendingOrders = availableOrders
        //     .where((o) => o.shippingStatus != "delivered")
        //     .toList();

        // if (pendingOrders.isEmpty) {
        //   _isOrderEmpty = true;
        //   notifyListeners();
        // }
        notifyListeners();
      } else {
        hasError = true;
        _isOrderLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print("******* error on fetching order list *****");
      print(e);
      hasError = true;
      _isOrderLoading = false;
      _isOrderEmpty = true;
      notifyListeners();
    }

    _isOrderLoading = false;
    notifyListeners();
    return hasError;
  }

//  ********  fetch single order ********
  Future<void> fetchOrder(String id) async {
    sharedPreferences = await SharedPreferences.getInstance();
    this.accessToken = sharedPreferences.getString("accessToken");
    print(this.accessToken);
    bool hasError = true;
    _isOrderEmpty = false;
    _isOrderLoading = true;
    notifyListeners();
    var url = Uri.parse(api + "order/myOrders?id=$id");
    final http.Response response = await http.get(url,
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "Accept": "Application/json"
        });
    // final Map<String, dynamic> ordersMap = json.decode(response.body);
    // print(response.body);
    try {
      if (response.statusCode == 200) {
        final result = Order.fromJson(json.decode(response.body));
        print(result);
        _fetchedOrder = result;
        print("======  available orders ====");
        print(_fetchedOrder);
        print(_fetchedOrder.grandTotal);
        print("======================================");

        notifyListeners();

        // if (pendingOrders.isEmpty) {
        //   _isOrderEmpty = true;
        //   notifyListeners();
        // }
        notifyListeners();
      } else {
        hasError = true;
        notifyListeners();
      }
    } catch (e) {
      print("******* error on fetching order list *****");
      print(e);
      hasError = true;
      _isOrderLoading = false;
      notifyListeners();
    }

    _isOrderLoading = false;
    notifyListeners();
    return hasError;
  }

  // create order
  Future<bool> createOrder(
      {@required List<Map<String, dynamic>> orderMapList}) async {
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    print(orderMapList);
    List<Map<String, dynamic>> data = orderMapList;

    var url = Uri.parse(api + "order/create");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode(data));
    print(response.body);
    try {
      if (response.statusCode == 200) {
        final result = authResponceFromJson(response.body);
        print("******** responce from create order *****");
        print(result);
        print("****************");
        notifyListeners();
      } else {
        print("**** Error on  create order  ****");
        _hasError = true;
      }
    } catch (e) {
      print("**** Error ****");
      print(e);
    }
    return _hasError;
  }

  // create pay leter
  Future<bool> payLater(
      {@required String nida,
      @required String tin,
      @required String averageMonth}) async {
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    String shopId = sharedPreferences.getString("shopId");
    print(shopId);
    print({
      "nida": nida,
      "tin": tin,
      "averageMonthlySale": averageMonth,
      "shopId": shopId
    });
    Map<String, dynamic> data = {
      "nida": nida,
      "tin": tin,
      "averageMonthlySale": averageMonth
    };

    var url = Uri.parse(
        api + "store/paylater_details?storeId=6230ec0fb5d1e7fd85b2d150");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode(data));
    print(response.body);
    try {
      if (response.statusCode == 200) {
        final result = payLaterFromJson(response.body);
        print("******** responce from pay later *****");
        print(result);
        print("****************");
        notifyListeners();
      } else {
        print("**** Error on pay   ****");
        _hasError = true;
      }
    } catch (e) {
      print("**** Error ****");
      print(e);
    }
    return _hasError;
  }
}
