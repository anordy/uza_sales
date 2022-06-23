import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uza_sales/app/retailer/model/category_model.dart';
import 'package:uza_sales/app/retailer/model/product_model.dart';
import 'package:uza_sales/app/retailer/network/api.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryProvider() {
    fetchCategory();
    // fetchProducts();
    // getProducts();
  }

  // variables
  bool _isGetLoading = false;
  bool _isProductLoad = false;

  bool _isCatLoad = false;
  bool _isSubCatLoad = false;
  int _selectedCategory = 0;
  int _selectedSubCategory = 0;
  List<Category> _availableCategory = [];
  List<SubCategory> _availableSubCategory = [];
  List<Product> _availableProducts;
  // List<Product> _availableProducts;
  // ProductList _productList;

  // getters
  bool get isProductLoad => _isProductLoad;
  bool get isCatLoad => _isCatLoad;
  bool get isSubCatLoad => _isSubCatLoad;
  int get selectedCategory => _selectedCategory;
  int get selectedsubCategory => _selectedSubCategory;
  List<SubCategory> get availableSubCategory => _availableSubCategory;
  bool get isGetLoading => _isGetLoading;
  // ProductList get productList =>  _productList;
  List<Category> get availableCategory => _availableCategory;
  List<Product> get availableProducts => _availableProducts;
  // List<Product> get availableProducts => _availableProducts;

  // [01]  Fetch Category ]]]]]]]]
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
    // print("*********** responce from main category ************");
    // print(response.body);
    // print("====================================================");
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
      print(
          "=====================    name of subcategory ======================");
      print("Selected subcategory   $selectedsubCategory");
      print(_availableCategory[selectedCategory]
          .subCategories[selectedsubCategory]
          .name);
      print("===========================================");
      fetchProducts(
          _availableCategory[selectedCategory].id,
          _availableCategory[selectedCategory]
              .subCategories[selectedsubCategory]
              .id,
          "",
          "");
      // print("****** responce from category *******");
      print(result[0].subCategories[0].name);
      // print("**********************");
      _isCatLoad = false;
      notifyListeners();
    } else {
      print("********  Error  from  category   *******");
      _isCatLoad = false;
    }
  }

  // onclick category
  onClickCategory(@required catId, @required index) {
    _selectedCategory = index;
    print("**** CatId  $catId index  $index ******");
    fetchsubCategory(catId: catId);
    fetchProducts(
        _availableCategory[selectedCategory].id,
        _availableCategory[selectedCategory]
            .subCategories[selectedsubCategory]
            .id,
        "",
        "");
    notifyListeners();
  }

// fetch subCategories
  Future<SubCategory> fetchsubCategory({@required catId}) async {
    print({"catId": catId});
    _isSubCatLoad = true;
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String accessToken = sharedPreferences.getString("accessToken");
    notifyListeners();
    var url = Uri.parse(api + "product_category/get?parent=$catId");
    final response = await http.get(url, headers: <String, String>{
      "Accept": "application/json",
      "Content-Type": "application/json",
      // "Authorization": "Bearer $accessToken"
    });
    print("*********** responce from subcategory ************");
    print(response.body);
    if (response.statusCode == 200) {
      final result = subCategoryFromJson(response.body);

      _availableSubCategory.clear();
      _availableSubCategory.add(new SubCategory(id: '', name: "All"));
      _availableSubCategory.addAll(result);
      print("****** responce from subcategory *******");
      print(result);
      print("**********************");
      _isSubCatLoad = false;
      notifyListeners();
    } else {
      print("******** Error from subcategory *******");
      _isSubCatLoad = false;
    }
  }

  // onclick category
  onClicksubCategory(@required catId, @required subId, @required index) {
    _selectedSubCategory = index;
    print("**** categoryId  $catId index  $_selectedCategory ******");
    _availableProducts.clear();
    print("**** SubcategoryId  $subId index  $_selectedSubCategory ******");
    fetchProducts(catId, subId, "", "");
    notifyListeners();
  }

  // [02]  Fetch Products with aceesToken ]]]]]]]]
  Future<Product> fetchProducts(
      @required catId, @required subId, String search, String sort) async {
    print(
        "===========================   call fetch products ========================");
    print({"catId": catId, "subId": subId, "search": search});
    _isProductLoad = true;
    notifyListeners();
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String accessToken = sharedPreferences.getString("accessToken");
    Map<String, dynamic> _data = {"page": 0, "size": 100};
    var url = Uri.parse(api +
        "product/get?parent=main&CategoryId=$catId&categoryId=$subId&distributor=true&name=$search&sort=$sort");
    print(url);
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          // "Authorization": "Bearer $accessToken"
        },
        body: jsonEncode(_data));
    print("***** responce body from products with access token  ****");
    print(response.body);
    if (response.statusCode == 200) {
      // _availableProducts.clear();
      final result = productFromJson(response.body);
      // _availableProducts.clear();
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

// [02]  Get Products ***
  // Future<Product> getProducts() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String accessToken = sharedPreferences.getString("accessToken");
  //   _isProductLoad = true;
  //   notifyListeners();
  //   var url = Uri.parse(api + "product/list_v0");
  //   final response = await http.get(url, headers: <String, String>{
  //     "Accept": "application/json",
  //     "Content-Type": "application/json",
  //   });
  //   if (response.statusCode == 200) {
  //     final result = productDatumFromJson(response.body);
  //     if (accessToken == null) {
  //       _availableProducts = result;
  //       // print(" ***** result from products with no accessToken *****");
  //       // print(availableProducts);
  //       // print("****************************");
  //     } else {
  //       //  print("failed to load due to accessToken");
  //       //  print(_availableProducts);
  //       //  print("********************************");
  //     }

  //     _isProductLoad = false;
  //     notifyListeners();
  //   } else {
  //     print("******** Error from Products *******");
  //     _isProductLoad = false;
  //   }
  // }

}
