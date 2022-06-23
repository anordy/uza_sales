import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/model/cart_item.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uza_sales/app/retailer/model/cart_response.dart';
import 'package:uza_sales/app/retailer/model/store_cart.dart';
import 'package:uza_sales/app/retailer/network/api.dart';

class CartProvider extends ChangeNotifier {
  // variable
  Map<String, CartItem> _items = {};
  double _totalPrice = 0.0;
  bool _hasError = false;
  bool _isCartLoading = false;
  List<StoreCart> _storesCarts = [];
  List<Cart> _carts = [];

  // getter
  bool get hasError => _hasError;
  List<StoreCart> get storesCarts => _storesCarts;
  List<Cart> get carts => _carts;
  bool get isCartLoading => _isCartLoading;

  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalPrice {
    return _totalPrice;
  }

  // get counts
  int get itemCount {
    return _items.length;
  }

  // add item to cart
  void addItem(
      String prodId, String name, double price, String type, int quantity) {
    // if items arleady in cart
    if (_items.containsKey(prodId)) {
      _items.update(
          prodId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              name: existingCartItem.name,
              type: existingCartItem.type,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1));
    } else {
      _items.putIfAbsent(
          prodId,
          () => CartItem(
              id: prodId,
              name: name,
              quantity: quantity,
              price: price,
              type: type));
    }
    notifyListeners();
  }

  // remove all items
  void removeItem(String id) {
    _items.remove(id);
    sendCartsData();
    notifyListeners();
  }

  // add single items
  void addSingleItems(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id].quantity >= 1) {
      _items.update(
          id,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              name: existingCartItem.name,
              price: existingCartItem.price,
              type: existingCartItem.type,
              quantity: existingCartItem.quantity + 1));
    }
    sendCartsData();
    notifyListeners();
  }

  // remove single items
  void removeSingleItems(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    print(" =====product id ==== ${_items[id].quantity}");
    if (_items[id].quantity > 1) {
      _items.update(
          id,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              name: existingCartItem.name,
              price: existingCartItem.price,
              type: existingCartItem.type,
              quantity: existingCartItem.quantity - 1));
    } else if (_items[id].quantity <= 1) {
      print("======== remove item =============");
      removeItem(id);
    }
    sendCartsData();
    notifyListeners();
  }

  // get total amount
  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  // clear cart
  void clear() {
    _items = {};
    notifyListeners();
  }

  // get cart total price in dialog
  getTotalPrice(double selectedPrice, int selectedQuantity) {
    var totalPrice = 0.0;
    print("selected price is " + selectedPrice.toString());
    print("quantity is " + selectedQuantity.toString());
    totalPrice = selectedPrice * selectedQuantity;
    print("totalPrice:  $totalPrice");
    _totalPrice = totalPrice;
    notifyListeners();
    return totalPrice;
  }

  // ==============ADD TO CART RESPONSE WITH MULTIPLE STORE  ========
  Future<bool> sendCartsData() async {
    _isCartLoading = true;
    notifyListeners();
    Map<String, dynamic> _cartObject = {};
    List<Map<String, dynamic>> _cartMapListObject = [];
    for (var i = 0; i < items.length; i++) {
      _cartObject = {
        "productId": items.values.toList()[i].id,
        "type": items.values.toList()[i].type,
        "quantity": items.values.toList()[i].quantity,
      };
      _cartMapListObject.add(_cartObject);
    }
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString("accessToken");
    print(_cartMapListObject);
    List<Map<String, dynamic>> data = _cartMapListObject;
    var url = Uri.parse(api + "order/add_cart");
    final response = await http.post(url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode(data));
    print(" ============== resoponse from cart =========");
    print(response.body);
    print("============================================");
    try {
      if (response.statusCode == 200) {
        _isCartLoading = false;
        _storesCarts.clear();
        notifyListeners();
        final cartMap = StoreCartFromJson(response.body);
        _storesCarts.addAll(cartMap);
        print(
            "=================   checking >>>>>>>  ===========================");

        print(_storesCarts.length);
        notifyListeners();
      } else {
        print("**** Error on  create cart response with distrubuter  ****");
        _hasError = true;
        _isCartLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print("**** Error ****");
      print(e);
    }
    return _hasError;
  }

  // remove all items
  void removeRItem(String id) {
    print(id);
    _storesCarts[0].cartResponse.removeWhere((item) => item.productId == id);
    notifyListeners();
  }
}
