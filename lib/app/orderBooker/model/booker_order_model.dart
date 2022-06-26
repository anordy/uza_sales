// To parse this JSON data, do
//
//     final bookerOrder = bookerOrderFromJson(jsonString);

import 'dart:convert';

BookerOrder bookerOrderFromJson(String str) =>
    BookerOrder.fromJson(json.decode(str));

String bookerOrderToJson(BookerOrder data) => json.encode(data.toJson());

class BookerOrder {
  BookerOrder({
    this.code,
    this.message,
    this.data,
  });

  int code;
  Message message;
  Data data;

  factory BookerOrder.fromJson(Map<String, dynamic> json) => BookerOrder(
        code: json["code"],
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.code,
    this.createdDate,
    this.parentOrderId,
    this.items,
    this.discountAmount,
    this.discountCoupon,
    this.grandTotal,
    this.paymentStatus,
    this.creditedAmount,
    this.cashedAmount,
    this.creditype,
    this.creditStatus,
    this.status,
    this.deliveredDate,
    this.repaymentDate,
    this.store,
    this.distributor,
    this.salesPerson,
    this.cancelReason,
  });

  String id;
  String code;
  DateTime createdDate;
  String parentOrderId;
  List<Item> items;
  double discountAmount;
  dynamic discountCoupon;
  double grandTotal;
  String paymentStatus;
  dynamic creditedAmount;
  dynamic cashedAmount;
  dynamic creditype;
  dynamic creditStatus;
  String status;
  dynamic deliveredDate;
  dynamic repaymentDate;
  Store store;
  dynamic distributor;
  SalesPerson salesPerson;
  dynamic cancelReason;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        code: json["code"],
        createdDate: DateTime.parse(json["createdDate"]),
        parentOrderId: json["parentOrderId"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        discountAmount: json["discountAmount"],
        discountCoupon: json["discountCoupon"],
        grandTotal: json["grandTotal"],
        paymentStatus: json["paymentStatus"],
        creditedAmount: json["creditedAmount"],
        cashedAmount: json["cashedAmount"],
        creditype: json["creditype"],
        creditStatus: json["creditStatus"],
        status: json["status"],
        deliveredDate: json["deliveredDate"],
        repaymentDate: json["repaymentDate"],
        store: Store.fromJson(json["store"]),
        distributor: json["distributor"],
        salesPerson: SalesPerson.fromJson(json["salesPerson"]),
        cancelReason: json["cancelReason"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "createdDate":
            "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "parentOrderId": parentOrderId,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "discountAmount": discountAmount,
        "discountCoupon": discountCoupon,
        "grandTotal": grandTotal,
        "paymentStatus": paymentStatus,
        "creditedAmount": creditedAmount,
        "cashedAmount": cashedAmount,
        "creditype": creditype,
        "creditStatus": creditStatus,
        "status": status,
        "deliveredDate": deliveredDate,
        "repaymentDate": repaymentDate,
        "store": store.toJson(),
        "distributor": distributor,
        "salesPerson": salesPerson.toJson(),
        "cancelReason": cancelReason,
      };
}

class Item {
  Item({
    this.productId,
    this.productName,
    this.count,
    this.type,
    this.unit,
    this.unitPrice,
    this.discountAmount,
    this.totalPrice,
    this.supplierId,
    this.secondaryToPrimaryRelation,
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
  String secondaryToPrimaryRelation;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
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

class SalesPerson {
  SalesPerson({
    this.id,
    this.createdDate,
    this.userId,
    this.distributorId,
    this.creditLimit,
    this.spentCredit,
    this.totalSale,
    this.activities,
    this.status,
    this.type,
  });

  String id;
  DateTime createdDate;
  String userId;
  dynamic distributorId;
  double creditLimit;
  dynamic spentCredit;
  dynamic totalSale;
  List<Activity> activities;
  String status;
  String type;

  factory SalesPerson.fromJson(Map<String, dynamic> json) => SalesPerson(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        userId: json["userId"],
        distributorId: json["distributorId"],
        creditLimit: json["creditLimit"],
        spentCredit: json["spentCredit"],
        totalSale: json["totalSale"],
        activities: List<Activity>.from(
            json["activities"].map((x) => Activity.fromJson(x))),
        status: json["status"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate":
            "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "userId": userId,
        "distributorId": distributorId,
        "creditLimit": creditLimit,
        "spentCredit": spentCredit,
        "totalSale": totalSale,
        "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
        "status": status,
        "type": type,
      };
}

class Activity {
  Activity({
    this.name,
    this.time,
    this.visitId,
  });

  String name;
  DateTime time;
  String visitId;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        name: json["name"],
        time: DateTime.parse(json["time"]),
        visitId: json["visitId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "time": time.toIso8601String(),
        "visitId": visitId,
      };
}

class Store {
  Store({
    this.id,
    this.createdDate,
    this.name,
    this.address,
    this.phone,
    this.location,
    this.storeOwnerId,
    this.storeKeeperId,
    this.category,
    this.storeKeeperOrderPermission,
    this.averageOrderValue,
    this.lastVisitDate,
    this.lastOrderDate,
    this.zoneId,
    this.image,
    this.createdBy,
    this.isCreatedByOwner,
    this.status,
    this.points,
    this.payLater,
    this.payLaterDetails,
  });

  String id;
  DateTime createdDate;
  String name;
  String address;
  String phone;
  Location location;
  String storeOwnerId;
  dynamic storeKeeperId;
  dynamic category;
  bool storeKeeperOrderPermission;
  double averageOrderValue;
  dynamic lastVisitDate;
  DateTime lastOrderDate;
  String zoneId;
  dynamic image;
  String createdBy;
  bool isCreatedByOwner;
  String status;
  dynamic points;
  dynamic payLater;
  dynamic payLaterDetails;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        location: Location.fromJson(json["location"]),
        storeOwnerId: json["storeOwnerId"],
        storeKeeperId: json["storeKeeperId"],
        category: json["category"],
        storeKeeperOrderPermission: json["storeKeeperOrderPermission"],
        averageOrderValue: json["averageOrderValue"].toDouble(),
        lastVisitDate: json["lastVisitDate"],
        lastOrderDate: DateTime.parse(json["lastOrderDate"]),
        zoneId: json["zoneId"],
        image: json["image"],
        createdBy: json["createdBy"],
        isCreatedByOwner: json["isCreatedByOwner"],
        status: json["status"],
        points: json["points"],
        payLater: json["payLater"],
        payLaterDetails: json["payLaterDetails"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate":
            "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "name": name,
        "address": address,
        "phone": phone,
        "location": location.toJson(),
        "storeOwnerId": storeOwnerId,
        "storeKeeperId": storeKeeperId,
        "category": category,
        "storeKeeperOrderPermission": storeKeeperOrderPermission,
        "averageOrderValue": averageOrderValue,
        "lastVisitDate": lastVisitDate,
        "lastOrderDate":
            "${lastOrderDate.year.toString().padLeft(4, '0')}-${lastOrderDate.month.toString().padLeft(2, '0')}-${lastOrderDate.day.toString().padLeft(2, '0')}",
        "zoneId": zoneId,
        "image": image,
        "createdBy": createdBy,
        "isCreatedByOwner": isCreatedByOwner,
        "status": status,
        "points": points,
        "payLater": payLater,
        "payLaterDetails": payLaterDetails,
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

class Message {
  Message({
    this.sw,
    this.en,
  });

  String sw;
  String en;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        sw: json["sw"],
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "sw": sw,
        "en": en,
      };
}
