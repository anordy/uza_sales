// To parse this JSON data, do
//
//     final PosVisibility = visibilityFromJson(jsonString);

import 'dart:convert';

PosVisibility visibilityFromJson(String str) => PosVisibility.fromJson(json.decode(str));

String visibilityToJson(PosVisibility data) => json.encode(data.toJson());

class PosVisibility {
    PosVisibility({
        this.code,
        this.message,
        this.data,
    });

    int code;
    Message message;
    Data data;

    factory PosVisibility.fromJson(Map<String, dynamic> json) => PosVisibility(
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
        this.comment,
        this.images,
        this.storeId,
        this.salesPersonId,
        this.visitId,
        this.status,
    });

    String id;
    DateTime createdDate;
    String comment;
    List<String> images;
    String storeId;
    String salesPersonId;
    String visitId;
    String status;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        comment: json["comment"],
        images: List<String>.from(json["images"].map((x) => x)),
        storeId: json["storeId"],
        salesPersonId: json["salesPersonId"],
        visitId: json["visitId"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "comment": comment,
        "images": List<dynamic>.from(images.map((x) => x)),
        "storeId": storeId,
        "salesPersonId": salesPersonId,
        "visitId": visitId,
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
