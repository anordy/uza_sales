// To parse this JSON data, do
//
//     final returnWarehouse = returnWarehouseFromJson(jsonString);

import 'dart:convert';

ReturnWarehouse returnWarehouseFromJson(String str) => ReturnWarehouse.fromJson(json.decode(str));

String returnWarehouseToJson(ReturnWarehouse data) => json.encode(data.toJson());

class ReturnWarehouse {
    ReturnWarehouse({
        this.id,
        this.createdDate,
        this.salesPersonId,
        this.salesPersonName,
        this.distributorId,
        this.distributorName,
        this.distributorPhone,
        this.stocks,
        this.confirmed,
    });

    String id;
    DateTime createdDate;
    String salesPersonId;
    String salesPersonName;
    String distributorId;
    String distributorName;
    String distributorPhone;
    List<Stock> stocks;
    bool confirmed;

    factory ReturnWarehouse.fromJson(Map<String, dynamic> json) => ReturnWarehouse(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        salesPersonId: json["salesPersonId"],
        salesPersonName: json["salesPersonName"],
        distributorId: json["distributorId"],
        distributorName: json["distributorName"],
        distributorPhone: json["distributorPhone"],
        stocks: List<Stock>.from(json["stocks"].map((x) => Stock.fromJson(x))),
        confirmed: json["confirmed"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "salesPersonId": salesPersonId,
        "salesPersonName": salesPersonName,
        "distributorId": distributorId,
        "distributorName": distributorName,
        "distributorPhone": distributorPhone,
        "stocks": List<dynamic>.from(stocks.map((x) => x.toJson())),
        "confirmed": confirmed,
    };
}

class Stock {
    Stock({
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

    factory Stock.fromJson(Map<String, dynamic> json) => Stock(
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
