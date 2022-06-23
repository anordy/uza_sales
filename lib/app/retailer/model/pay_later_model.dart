// To parse this JSON data, do
//
//     final payLater = payLaterFromJson(jsonString);

import 'dart:convert';

PayLater payLaterFromJson(String str) => PayLater.fromJson(json.decode(str));

String payLaterToJson(PayLater data) => json.encode(data.toJson());

class PayLater {
    PayLater({
        this.code,
        this.message,
        this.data,
    });

    int code;
    Message message;
    Data data;

    factory PayLater.fromJson(Map<String, dynamic> json) => PayLater(
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
        this.points,
        this.payLater,
        this.payLaterDetails,
    });

    String id;
    DateTime createdDate;
    String name;
    String address;
    dynamic phone;
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
    dynamic createdBy;
    dynamic isCreatedByOwner;
    String status;
    dynamic points;
    bool payLater;
    PayLaterDetails payLaterDetails;

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
        lastOrderDate: DateTime.parse(json["lastOrderDate"]),
        zoneId: json["zoneId"],
        image: json["image"],
        createdBy: json["createdBy"],
        isCreatedByOwner: json["isCreatedByOwner"],
        status: json["status"],
        points: json["points"],
        payLater: json["payLater"],
        payLaterDetails: PayLaterDetails.fromJson(json["payLaterDetails"]),
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
        "lastOrderDate": "${lastOrderDate.year.toString().padLeft(4, '0')}-${lastOrderDate.month.toString().padLeft(2, '0')}-${lastOrderDate.day.toString().padLeft(2, '0')}",
        "zoneId": zoneId,
        "image": image,
        "createdBy": createdBy,
        "isCreatedByOwner": isCreatedByOwner,
        "status": status,
        "points": points,
        "payLater": payLater,
        "payLaterDetails": payLaterDetails.toJson(),
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

class PayLaterDetails {
    PayLaterDetails({
        this.averageMontlySale,
        this.tin,
        this.nida,
    });

    double averageMontlySale;
    String tin;
    String nida;

    factory PayLaterDetails.fromJson(Map<String, dynamic> json) => PayLaterDetails(
        averageMontlySale: json["averageMontlySale"],
        tin: json["tin"],
        nida: json["nida"],
    );

    Map<String, dynamic> toJson() => {
        "averageMontlySale": averageMontlySale,
        "tin": tin,
        "nida": nida,
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
