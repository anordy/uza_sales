// To parse this JSON data, do
//
//     final cartResponse = cartResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<StoreCart> StoreCartFromJson(String str) => List<StoreCart>.from(json.decode(str).map((x) => StoreCart.fromJson(x)));

String StoreCartToJson(List<StoreCart> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreCart {
    StoreCart({
      @required  this.distributorName,
      @required  this.distributorId,
      @required  this.itemSum,
      @required  this.cartResponse,
      @required  this.minimumAmountPerOrder,
    });

    String distributorName;
    String distributorId;
    double itemSum;
    List<Cart> cartResponse;
    double minimumAmountPerOrder;

    factory StoreCart.fromJson(Map<String, dynamic> json) => StoreCart(
        distributorName: json["distributorName"],
        distributorId: json["distributorId"],
        itemSum: json["itemSum"],
        cartResponse: List<Cart>.from(json["items"].map((x) => Cart.fromJson(x))),
        minimumAmountPerOrder: json["minimumAmountPerOrder"],
    );

    Map<String, dynamic> toJson() => {
        "distributorName": distributorName,
        "distributorId": distributorId,
        "itemSum": itemSum,
        "items": List<dynamic>.from(cartResponse.map((x) => x.toJson())),
        "minimumAmountPerOrder": minimumAmountPerOrder,
    };
}

class Cart {
    Cart({
      @required  this.productId,
      @required  this.productName,
      @required  this.count,
      @required  this.type,
      @required  this.unit,
      @required  this.unitPrice,
      @required  this.discountAmount,
      @required  this.totalPrice,
      @required  this.supplierId,
      @required  this.secondaryToPrimaryRelation,
    });

    String productId;
    String productName;
    int count;
    String type;
    String unit;
    double unitPrice;
    double discountAmount;
    double totalPrice;
    String supplierId;
    dynamic secondaryToPrimaryRelation;

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        productId: json["productId"],
        productName: json["productName"],
        count: json["count"],
        type: json["type"],
        unit: json["unit"],
        unitPrice: json["unitPrice"],
        discountAmount: json["discountAmount"],
        totalPrice: json["totalPrice"],
        supplierId: json["supplierId"],
        secondaryToPrimaryRelation: json["secondaryToPrimaryRelation"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "count": count,
        "type": type,
        "unit": unit,
        "unitPrice": unitPrice,
        "discountAmount": discountAmount,
        "totalPrice": totalPrice,
        "supplierId": supplierId,
        "secondaryToPrimaryRelation": secondaryToPrimaryRelation,
    };
}
