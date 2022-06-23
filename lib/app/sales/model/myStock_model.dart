// To parse this JSON data, do
//
//     final myStock = myStockFromJson(jsonString);

import 'dart:convert';

MyStock myStockFromJson(String str) => MyStock.fromJson(json.decode(str));

String myStockToJson(MyStock data) => json.encode(data.toJson());

class MyStock {
    MyStock({
        this.totalItems,
        this.totalPages,
        this.stocksContent,
    });

    int totalItems;
    int totalPages;
    List<StocksContent> stocksContent;

    factory MyStock.fromJson(Map<String, dynamic> json) => MyStock(
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        stocksContent: List<StocksContent>.from(json["content"].map((x) => StocksContent.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "totalPages": totalPages,
        "content": List<dynamic>.from(stocksContent.map((x) => x.toJson())),
    };
}

class StocksContent {
    StocksContent({
        this.id,
        this.createdDate,
        this.salesPersonId,
        this.salesPersonName,
        this.productId,
        this.productName,
        this.quantity,
        this.unit,
        this.productExpireDate,
    });

    String id;
    DateTime createdDate;
    String salesPersonId;
    String salesPersonName;
    String productId;
    String productName;
    int quantity;
    String unit;
    DateTime productExpireDate;

    factory StocksContent.fromJson(Map<String, dynamic> json) => StocksContent(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        salesPersonId: json["salesPersonId"],
        salesPersonName: json["salesPersonName"],
        productId: json["productId"],
        productName: json["productName"],
        quantity: json["quantity"],
        unit: json["unit"],
        productExpireDate: DateTime.parse(json["productExpireDate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "salesPersonId": salesPersonId,
        "salesPersonName": salesPersonName,
        "productId": productId,
        "productName": productName,
        "quantity": quantity,
        "unit": unit,
        "productExpireDate": "${productExpireDate.year.toString().padLeft(4, '0')}-${productExpireDate.month.toString().padLeft(2, '0')}-${productExpireDate.day.toString().padLeft(2, '0')}",
    };
}
