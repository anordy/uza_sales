import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uza_sales/app/retailer/network/api.dart';
import 'package:http/http.dart' as http;
import 'package:uza_sales/app/sales/model/sales_order_model.dart';
import 'package:uza_sales/app/sales/model/return_goods_model.dart';

class BookerOrderProvider extends ChangeNotifier {
  BookerOrderProvider() {
    // fetchOrders();
  }

// variable
  bool _isLoading = false;
  bool _hasError = false;
  bool _isEmpty = false;
  bool _isOrderCard = false;
  bool _isOrderLoading = false;
  List<String> _products = [];
  SharedPreferences sharedPreferences;
  String accessToken;
  SalesOrder _availableOrder;
  List<Order> _foundOrders = [];

// getter
  SalesOrder get availableOrder => _availableOrder;
  bool get isLoading => _isLoading;
  bool get isOrderCard => _isOrderCard;
  List<String> get products => _products;
  List<Order> get foundOrder => _foundOrders;
  bool get isOrderLoading => _isOrderLoading;

  // **** fetch Orders *****
  Future<void> fetchOrders(
      {@required String startDate, @required String endDate}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    print("***** Access Token  ****");
    print({"startDate": startDate, "EndDate": endDate});
    bool hasError = true;
    _isLoading = true;
    _isEmpty = false;
    _isOrderLoading = true;
    notifyListeners();
    Map<String, dynamic> _data = {"page": 0, "size": 100};
    var url = Uri.parse(
        api + "order_booker/myOrders?startDate=$startDate&endDate=$endDate");
    print(url);
    final http.Response response = await http.post(url,
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "Accept": "Application/json",
          "Content-Type": "Application/json"
        },
        body: jsonEncode(_data));
    print("*********  response from  orders booker *******");
    print(response.body);
    print("***************************************");

    try {
      var data = jsonDecode(response.body);
      if (data.containsKey("data")) {
        _foundOrders.clear();
        _isOrderLoading = false;
        _isEmpty = true;
        print("====== no data  =======");
        print(_foundOrders);
        notifyListeners();
        return;
      }
      if (response.statusCode == 200) {
        print("inside response");
        // var  data = jsonDecode(response.body);
        //  if(data.containsKey("data")) {
        //    _foundOrders.clear();
        //    _isOrderLoading = false;
        //    _isEmpty = true;
        //    print("====== no data  =======");
        //    print(_foundOrders);
        //    notifyListeners();
        //    return;
        //  }
        var result = salesOrderFromJson(response.body);
        _availableOrder = result;
        _isOrderLoading = false;
        notifyListeners();
        print("*********  fetch orders provider ***********");
        print(_availableOrder);
        print("***************************************");
        searchOrder("");
      }
    } catch (e) {
      print("=================== Error on orders  ==============");
      print(e);
    }
//  _isOrderLoading = false;
//  notifyListeners();
    return hasError;
  }

  setOrder(Order order) {
    for (int i; i <= order.items.length; i++) {
      _products.add(order.items[i].productName);
    }
    print("=========   items name products ============");
    print(_products);
    print("================================");
  }

  //  create sales order
  Future<bool> createBookerOrder(
      {@required List<Map<String, dynamic>> orderMapList,
      @required visitId}) async {
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    print({"orderRequests": orderMapList, "visitId": visitId});

    Map<String, dynamic> data = {
      "orderRequests": orderMapList,
      "visitId": '61e3f6d2f417105e7eee946c'
    };
    // List<Map<String, dynamic>> data = orderMapList;

    var url = Uri.parse(api + "order_booker/save_order");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode(data));
    print("==============  response from create order    ===============");
    print(response.body);
    print("=====================================================");
    try {
      if (response.statusCode == 200) {
        final result = salesOrderFromJson(response.body);
        print("******** response from sales  create order *****");
        print(result);
        print("****************");
        notifyListeners();
      } else {
        print("**** Error on sales  create order  ****");
        _hasError = true;
      }
    } catch (e) {
      print("**** Error  on sales order ****");
      print(e);
    }
    return _hasError;
  }

  // ========== Add Payment Cash ============
  Future<void> payCash(
      {@required double cashedAmount,
      @required String orderId,
      @required double creditedAmount}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    print({
      "orderId": orderId,
      "cashedAmount": cashedAmount,
      "creditedAmount": creditedAmount
    });
    Map<String, dynamic> _data = {
      "orderId": orderId,
      "cashedAmount": cashedAmount,
      "creditedAmount": creditedAmount
    };
    print("***** Access Token  ****");
    bool hasError = true;
    _isLoading = true;
    notifyListeners();
    var url = Uri.parse(api + "payment/pay");
    print(url);
    final http.Response response = await http.post(url,
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "Accept": "Application/json",
          "Content-Type": "Application/json"
        },
        body: jsonEncode(_data));
    print("******** response from pay by cash *********");
    print(response.body);
    print("==============================================");
    try {
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        print("********** add payment ********");
        print(result);
        notifyListeners();
        print("**************************");
      } else {
        print("something went wrong");
      }
    } catch (e) {
      print("*** Error on payment ****");
      print(e);
    }

    return hasError;
  }

  // ========== cancel Order ============
  Future<void> cancelOrder(
      {@required String reason, @required String orderId}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    print({"reason": reason, "orderId": orderId});
    Map<String, dynamic> _data = {"reason": reason};
    print("***** Access Token  ****");
    bool hasError = true;
    _isLoading = true;
    notifyListeners();
    var url = Uri.parse(api + "order/cancel?id=$orderId");
    print(url);
    final http.Response response = await http.delete(url,
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "Accept": "Application/json",
          "Content-Type": "Application/json"
        },
        body: jsonEncode(_data));
    // print("******** responce from cancel order *********");
    // print(response.body);
    // print("==============================================");

    try {
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        print("********** Cancel Order ********");
        print(result);
        notifyListeners();
        print("**************************");
      } else {
        print("something went wrong");
      }
    } catch (e) {
      print("*** Error on cancel Order ****");
      print(e);
    }

    return hasError;
  }

  // Return Goods
  Future<void> returnGoods(
      {@required String orderId,
      @required String productId,
      @required String unit,
      @required String reason,
      @required String quantity}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    String visitId = sharedPreferences.getString("visitId");
    print({
      "orderId": orderId,
      "productId": productId,
      "unit": unit,
      "reason": reason,
      "quantity": quantity,
      "visitId": visitId
    });
    Map<String, dynamic> _data = {
      "orderId": orderId,
      "productId": productId,
      "unit": unit,
      "reason": reason,
      "quantity": quantity,
      "visitId": visitId
    };
    print("***** Access Token  ****");
    bool hasError = true;
    _isLoading = true;
    notifyListeners();
    var url = Uri.parse(base + "goodReturns/save");
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
    print("==============================================");

    try {
      if (response.statusCode == 200) {
        var result = returnGoodsFromJson(response.body);
        print("********** Returns Goods ********");
        print(result);
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

  searchOrder(String enteredKeyword) {
    List<Order> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _availableOrder.orders;
      print("==============   search  orders  if field is empty =============");
      print(_foundOrders);
      print("================================================");
    } else {
      results = _availableOrder.orders
          .where((order) => order.storeName
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      print(
          "==============   search  orders when field has data =============");
      print(_foundOrders);
      print(
          "===================================================================");
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    _foundOrders = results;
    print("==============   search  orders finalist =============");
    print(_foundOrders);
    print("================================================");
    notifyListeners();
  }
}
