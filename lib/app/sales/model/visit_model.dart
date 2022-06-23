// To parse this JSON data, do
//
//     final visitModel = visitModelFromJson(jsonString);

import 'dart:convert';

VisitModel visitModelFromJson(String str) => VisitModel.fromJson(json.decode(str));

String visitModelToJson(VisitModel data) => json.encode(data.toJson());

class VisitModel {
    VisitModel({
        this.totalItems,
        this.totalPages,
        this.visit,
    });

    int totalItems;
    int totalPages;
    List<Visit> visit;

    factory VisitModel.fromJson(Map<String, dynamic> json) => VisitModel(
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        visit: List<Visit>.from(json["content"].map((x) => Visit.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "totalPages": totalPages,
        "visit": List<dynamic>.from(visit.map((x) => x.toJson())),
    };
}

class Visit {
    Visit({
        this.id,
        this.createdDate,
        this.routeId,
        this.storeId,
        this.storeName,
        this.address,
        this.phone,
        this.checkInTime,
        this.checkOutTime,
        this.salesPersonId,
        this.isOrderPending,
        this.shopStatus,
        this.nextAppointment,
        this.image,
        this.status,
    });

    dynamic id;
    DateTime createdDate;
    String routeId;
    String storeId;
    String storeName;
    String address;
    String phone;
    DateTime checkInTime;
    DateTime checkOutTime;
    String salesPersonId;
    bool isOrderPending;
    String shopStatus;
    DateTime nextAppointment;
    String image;
    String status;

    factory Visit.fromJson(Map<String, dynamic> json) => Visit(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        routeId: json["routeId"],
        storeId: json["storeId"],
        storeName: json["storeName"],
        address: json["address"],
        phone: json["phone"],
        checkInTime: DateTime.parse(json["checkInTime"]),
        checkOutTime: json["checkOutTime"] == null ? null : DateTime.parse(json["checkOutTime"]  as String),
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
        "storeName": storeName,
        "address": address,
        "phone": phone,
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
