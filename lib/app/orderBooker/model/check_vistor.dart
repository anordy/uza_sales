// To parse this JSON data, do
//
//     final checkVisitor = checkVisitorFromJson(jsonString);

import 'dart:convert';

CheckVisitor checkVisitorFromJson(String str) => CheckVisitor.fromJson(json.decode(str));

String checkVisitorToJson(CheckVisitor data) => json.encode(data.toJson());

class CheckVisitor {
    CheckVisitor({
        this.code,
        this.message,
        this.data,
    });

    int code;
    Message message;
    Data data;

    factory CheckVisitor.fromJson(Map<String, dynamic> json) => CheckVisitor(
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
        this.routeId,
        this.storeId,
        this.checkInTime,
        this.checkOutTime,
        this.salesPersonId,
        this.isOrderPending,
        this.shopStatus,
        this.nextAppointment,
        this.image,
        this.status,
    });

    String id;
    DateTime createdDate;
    String routeId;
    String storeId;
    DateTime checkInTime;
    DateTime checkOutTime;
    String salesPersonId;
    bool isOrderPending;
    String shopStatus;
    DateTime nextAppointment;
    dynamic image;
    String status;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        routeId: json["routeId"],
        storeId: json["storeId"],
        checkInTime: DateTime.parse(json["checkInTime"]),
        checkOutTime: json["checkOutTime"] == null ? DateTime.now() : DateTime.parse(json["checkOutTime"]),
        salesPersonId: json["salesPersonId"],
        isOrderPending: json["isOrderPending"],
        shopStatus: json["shopStatus"],
        nextAppointment: DateTime.parse(json["nextAppointment"]),
        image: json["image"] == null ? null : json["image"] as String,
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "routeId": routeId,
        "storeId": storeId,
        "checkInTime": checkInTime.toIso8601String(),
        "checkOutTime": checkOutTime.toIso8601String(),
        "salesPersonId": salesPersonId,
        "isOrderPending": isOrderPending,
        "shopStatus": shopStatus,
        "nextAppointment": "${nextAppointment.year.toString().padLeft(4, '0')}-${nextAppointment.month.toString().padLeft(2, '0')}-${nextAppointment.day.toString().padLeft(2, '0')}",
        "image": image,
        "status": status,
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
