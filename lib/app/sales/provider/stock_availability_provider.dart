import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uza_sales/app/retailer/model/category_model.dart';
import 'package:uza_sales/app/retailer/model/product_model.dart';
import 'package:uza_sales/app/retailer/network/api.dart';
import 'package:http/http.dart' as http;
import 'package:uza_sales/app/sales/model/myStock_model.dart';
import 'package:uza_sales/app/sales/model/return_warehouse_model.dart';
import 'package:uza_sales/app/sales/model/stock_available.dart';

class StockAvailabilityProvider extends ChangeNotifier {
  StockAvailabilityProvider() {
    // fetchStocks();
    fetchCategory();
    getMystocks();
  }

// variable
  bool _isLoading = false;
  bool _isCatLoad = false;
  bool _isProductLoad = false;
  bool _isMystocks = false;
  bool _isWarehouse = false;

  SharedPreferences sharedPreferences;
  String accessToken;
  StockAvailable _availableStock;
  String date = "2022-01-30";
  String status = "ACTIVE";
  List<Category> _availableCategory = [];
  MyStock _myStocks;
  ReturnWarehouse _returnWarehouse;
  List<Product> _availableProducts;
  int _selectedCategory = 0;
// getter
  bool get isLoading => _isLoading;
  bool get isCatLoad => _isCatLoad;
  MyStock get myStocks => _myStocks;
  bool get ismyStocks => _isMystocks;
  bool get isWarehouse => _isWarehouse;
  ReturnWarehouse get returnWarehouse => _returnWarehouse;
  List<Category> get availableCategory => _availableCategory;
  bool get isProductLoad => _isProductLoad;
  List<Product> get availableProducts => _availableProducts;
  int get selectedCategory => _selectedCategory;

  StockAvailable get availableStock => _availableStock;

  // **** fetch Stocks *****
  Future<void> fetchStocks() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    // print("***** Access Token  ****");
    bool hasError = true;
    _isLoading = true;
    Map<String, dynamic> _data = {"page": 0, "size": 25};
    var url = Uri.parse(base +
        "stockAvailability/get_availability?storeId=61c58344dac238738f15dd79&startDate=2022-02-01&endDate=2022-02-20&showInGroups=true");
    print(url);
    final http.Response response = await http.post(url,
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "Accept": "Application/json",
          "Content-Type": "Application/json"
        },
        body: jsonEncode(_data));
    // print("================ responce body from stocks ============");
    // print(response.body);
    try {
      if (response.statusCode == 200) {
        var result = stockAvailableFromJson(response.body);
        _availableStock = result;
        _isLoading = false;
        notifyListeners();
        print("*********   Stocks provider *******");
        print(_availableStock);
        print("***************************************");
      } else {
        print("something went wrong");
      }
    } catch (e) {
      print("*** Error on fetching Stocks ****");
      print(e);
    }

    return hasError;
  }

  // [01]  Fetch Category  to show in stock]]
  Future<Category> fetchCategory() async {
    _isCatLoad = true;
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String accessToken = sharedPreferences.getString("accessToken");
    var url = Uri.parse(api + "product_category/get?parent=main");
    final response = await http.get(url, headers: <String, String>{
      "Accept": "application/json",
      "Content-Type": "application/json",
      // "Authorization": "Bearer $accessToken"
    });
    //  print("*********** responce ************");
    // print(response.body);
    if (response.statusCode == 200) {
      List<Category> result = categoryFromJson(response.body);
      // _availableCategory.clear();
      for (var i = 0; i < result.length; i++) {
        //int i = _selectedCategory;
        List<SubCategory> _temp = [];
        _temp.addAll(result[i].subCategories);
        result[i].subCategories.clear();
        result[i].subCategories.add(new SubCategory(id: "", name: "All"));
        result[i].subCategories.addAll(_temp);
      }

      _availableCategory.addAll(result);

      fetchProducts(
        _availableCategory[selectedCategory].id,
      );

      print("****** responce from category *******");
      print(_availableCategory);
      print("**********************");
      _isCatLoad = false;
      notifyListeners();
    } else {
      print("******** Error from category *******");
      _isCatLoad = false;
    }
  }

  // [02]  Fetch Products with aceesToken ]]]]]]]]
  Future<Product> fetchProducts(
    @required catId,
  ) async {
    print({
      "subId": catId,
    });
    _isProductLoad = true;
    notifyListeners();
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String accessToken = sharedPreferences.getString("accessToken");
    Map<String, dynamic> _data = {"page": 0, "size": 100};
    var url = Uri.parse(api + "product/get?parentCategoryId=$catId");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          // "Authorization": "Bearer $accessToken"
        },
        body: jsonEncode(_data));
    print("***** responce body  ****");
    print(response.body);
    if (response.statusCode == 200) {
      final result = productFromJson(response.body);
      _availableProducts = result;
      print(" ***** result from products with accessToken *****");
      print(availableProducts);
      print("****************************");
      _isProductLoad = false;
      notifyListeners();
    } else {
      print("******** Error from Products with accessToken *******");
      _isProductLoad = false;
    }
  }

  // onclick category
  onClickCategory(@required catId, @required index) {
    _selectedCategory = index;
    print("**** CatId  $catId index  $index ******");
    fetchProducts(
      _availableCategory[selectedCategory].id,
    );
    notifyListeners();
  }

  // **** save Stocks *****
  Future<void> saveStock(
      {@required String productId,
      @required String categoryId,
      @required String unit,
      @required String quantity,
      @required String storeId,
      @required String salesPersonId}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    String visitId = sharedPreferences.getString("visitId");
    // print("***** Access Token  ****");
    print({
      "productId": productId,
      "categoryId": categoryId,
      "unit": unit,
      "quantity": quantity,
      "storeId": "61c58344dac238738f15dd79",
      "salesPersonId": "61e559c3a4dfe43972ef4c49",
      "visitId": visitId
    });

    bool hasError = true;
    _isLoading = true;
    Map<String, dynamic> _data = {
      "productId": productId,
      "categoryId": categoryId,
      "unit": unit,
      "quantity": quantity,
      "storeId": "61c58344dac238738f15dd79",
      "salesPersonId": "61e559c3a4dfe43972ef4c49",
      "visitId": visitId
    };
    var url = Uri.parse(base + "stockAvailability/save");
    print(url);
    final http.Response response = await http.post(url,
        headers: <String, String>{
          "Authorization": "Bearer $accessToken",
          "Accept": "Application/json",
          "Content-Type": "Application/json"
        },
        body: jsonEncode(_data));
    print("================ responce body from my stocks ============");
    print(response.body);
    try {
      if (response.statusCode == 200) {
        var result = stockAvailableFromJson(response.body);
        _availableStock = result;
        _isLoading = false;
        notifyListeners();
        print("*********    Stocks provider *******");
        print(_availableStock);
        print("***************************************");
      } else {
        print("something went wrong");
      }
    } catch (e) {
      print("*** Error on posting Stocks ****");
      print(e);
    }

    return hasError;
  }

  // ====================   return warehouse   ==================
  // [01]  === my stocks =====
  Future<Product> getMystocks() async {
    _isMystocks = true;
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    Map<String, dynamic> _data = {"page": 0, "size": 100};
    var url = Uri.parse(api + "sales_person/myStocks");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: jsonEncode(_data));
    print("***** responce body from mystocks ****");
    print(response.body);
    print("========================================");
    if (response.statusCode == 200) {
      final result = myStockFromJson(response.body);
      _myStocks = result;
      print(" ***** result from mystocks  *****");
      print(_myStocks);
      print("****************************");
      _isMystocks = false;
      notifyListeners();
    } else {
      print("******** Error from my stocks *******");
      _isMystocks = false;
    }
  }

//   [02] ========= return warehouse stocks =====
  Future<bool> warehouseReturn() async {
    _isWarehouse = true;
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    Map<String, dynamic> _data = {"page": 0, "size": 100};
    var url = Uri.parse(api + "sales_person/return_stock");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: jsonEncode(_data));
    print("***** responce body from warehouse return ****");
    print(response.body);
    print("========================================");
    if (response.statusCode == 200) {
      final result = returnWarehouseFromJson(response.body);
      _returnWarehouse = result;
      print(" ***** result from warehouse return  *****");
      print(_returnWarehouse);
      print("****************************");
      _isWarehouse = false;
      notifyListeners();
    } else {
      print("******** Error from return warehouse *******");
      _isWarehouse = false;
      notifyListeners();
    }
  }
}
