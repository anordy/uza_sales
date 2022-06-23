// To parse this JSON data, do
//
//     final salesStoreResponce = salesStoreResponceFromJson(jsonString);

import 'dart:convert';

SalesStoreResponce salesStoreResponceFromJson(String str) => SalesStoreResponce.fromJson(json.decode(str));

String salesStoreResponceToJson(SalesStoreResponce data) => json.encode(data.toJson());

class SalesStoreResponce {
    SalesStoreResponce({
        this.code,
        this.message,
        this.data,
    });

    int code;
    Message message;
    Data data;

    factory SalesStoreResponce.fromJson(Map<String, dynamic> json) => SalesStoreResponce(
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
    });

    String id;
    DateTime createdDate;
    String name;
    String address;
    String phone;
    Location location;
    String storeOwnerId;
    dynamic storeKeeperId;
    String category;
    bool storeKeeperOrderPermission;
    dynamic averageOrderValue;
    dynamic lastVisitDate;
    dynamic lastOrderDate;
    String zoneId;
    dynamic image;
    String createdBy;
    bool isCreatedByOwner;
    String status;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        averageOrderValue: json["averageOrderValue"],
        lastVisitDate: json["lastVisitDate"],
        lastOrderDate: json["lastOrderDate"],
        zoneId: json["zoneId"],
        image: json["image"],
        createdBy: json["createdBy"],
        isCreatedByOwner: json["isCreatedByOwner"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
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
        "lastOrderDate": lastOrderDate,
        "zoneId": zoneId,
        "image": image,
        "createdBy": createdBy,
        "isCreatedByOwner": isCreatedByOwner,
        "status": status,
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
