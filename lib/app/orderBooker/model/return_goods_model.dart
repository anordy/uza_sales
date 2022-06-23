// To parse this JSON data, do
//
//     final returnGoods = returnGoodsFromJson(jsonString);

import 'dart:convert';

ReturnGoods returnGoodsFromJson(String str) => ReturnGoods.fromJson(json.decode(str));

String returnGoodsToJson(ReturnGoods data) => json.encode(data.toJson());

class ReturnGoods {
    ReturnGoods({
        this.code,
        this.message,
        this.data,
    });

    int code;
    Message message;
    Data data;

    factory ReturnGoods.fromJson(Map<String, dynamic> json) => ReturnGoods(
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
        this.orderId,
        this.productId,
        this.unit,
        this.reason,
        this.quantity,
        this.salesPersonId,
        this.visitId,
    });

    String id;
    DateTime createdDate;
    String orderId;
    String productId;
    String unit;
    String reason;
    int quantity;
    String salesPersonId;
    String visitId;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        orderId: json["orderId"],
        productId: json["productId"],
        unit: json["unit"],
        reason: json["reason"],
        quantity: json["quantity"],
        salesPersonId: json["salesPersonId"],
        visitId: json["visitId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "orderId": orderId,
        "productId": productId,
        "unit": unit,
        "reason": reason,
        "quantity": quantity,
        "salesPersonId": salesPersonId,
        "visitId": visitId,
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
