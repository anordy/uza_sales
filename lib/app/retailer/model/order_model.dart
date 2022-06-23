// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order(
      {this.id,
      this.createdDate,
      this.parentOrderId,
      this.items,
      this.discountAmount,
      this.discountCoupon,
      this.grandTotal,
      this.status,
      this.store,
      this.distributor,
      this.salesPerson,
      this.paymentStatus});

  String id;
  String createdDate;
  String parentOrderId;
  List<Item> items;
  double discountAmount;
  dynamic discountCoupon;
  double grandTotal;
  String status;
  String paymentStatus;
  Store store;
  dynamic distributor;
  dynamic salesPerson;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
      id: json["id"],
      createdDate: json["createdDate"],
      parentOrderId: json["parentOrderId"],
      items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      discountAmount: json["discountAmount"],
      discountCoupon: json["discountCoupon"],
      grandTotal: json["grandTotal"],
      status: json["status"],
      store: Store.fromJson(json["store"]),
      distributor: json["distributor"],
      salesPerson: json["salesPerson"],
      paymentStatus: json['paymentStatus']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate,
        "parentOrderId": parentOrderId,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "discountAmount": discountAmount,
        "discountCoupon": discountCoupon,
        "grandTotal": grandTotal,
        "status": status,
        "store": store.toJson(),
        "distributor": distributor,
        "salesPerson": salesPerson,
        "paymentStatus": paymentStatus
      };
}

class Item {
  Item(
      {this.productId,
      this.count,
      this.unitPrice,
      this.discountAmount,
      this.totalPrice,
      this.type,
      this.unit,
      this.supplierId,
      this.productName});
  String productId;
  int count;
  double unitPrice;
  String type;
  double discountAmount;
  double totalPrice;
  String supplierId;
  String unit;
  String productName;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      productId: json["productId"],
      count: json["count"],
      unitPrice: json["unitPrice"],
      discountAmount: json["discountAmount"],
      totalPrice: json["totalPrice"],
      type: json['type'],
      unit: json['unit'],
      supplierId: json["supplierId"],
      productName: json['productName']);

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "count": count,
        "unitPrice": unitPrice,
        "discountAmount": discountAmount,
        "totalPrice": totalPrice,
        "supplierId": supplierId,
        "type": type,
        "productName": productName
      };
}

class Store {
  Store({
    this.id,
    this.createdDate,
    this.name,
    this.address,
    this.location,
    this.storeOwnerId,
    this.storeKeeperId,
    this.storeKeeperOrderPermission,
    this.zoneId,
  });

  String id;
  DateTime createdDate;
  String name;
  String address;
  Location location;
  String storeOwnerId;
  dynamic storeKeeperId;
  bool storeKeeperOrderPermission;
  String zoneId;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        name: json["name"],
        address: json["address"],
        location: Location.fromJson(json["location"]),
        storeOwnerId: json["storeOwnerId"],
        storeKeeperId: json["storeKeeperId"],
        storeKeeperOrderPermission: json["storeKeeperOrderPermission"],
        zoneId: json["zoneId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate":
            "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "name": name,
        "address": address,
        "location": location.toJson(),
        "storeOwnerId": storeOwnerId,
        "storeKeeperId": storeKeeperId,
        "storeKeeperOrderPermission": storeKeeperOrderPermission,
        "zoneId": zoneId,
      };
}

class Location {
  Location({
    this.latitude,
    this.longitude,
  });

  String latitude;
  String longitude;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
