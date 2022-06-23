// To parse this JSON data, do
//
//     final stockAvailable = stockAvailableFromJson(jsonString);

import 'dart:convert';

StockAvailable stockAvailableFromJson(String str) => StockAvailable.fromJson(json.decode(str));

String stockAvailableToJson(StockAvailable data) => json.encode(data.toJson());

class StockAvailable {
    StockAvailable({
        this.totalItems,
        this.totalPages,
        this.content,
    });

    int totalItems;
    int totalPages;
    Content content;

    factory StockAvailable.fromJson(Map<String, dynamic> json) => StockAvailable(
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        content: Content.fromJson(json["content"]),
    );

    Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "totalPages": totalPages,
        "content": content.toJson(),
    };
}

class Content {
    Content({
        this.womanProducts,
        this.shoesAccesories,
    });

    List<ShoesAccesory> womanProducts;
    List<ShoesAccesory> shoesAccesories;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        womanProducts: List<ShoesAccesory>.from(json["woman products"].map((x) => ShoesAccesory.fromJson(x))),
        shoesAccesories: List<ShoesAccesory>.from(json["Shoes Accesories"].map((x) => ShoesAccesory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "woman products": List<dynamic>.from(womanProducts.map((x) => x.toJson())),
        "Shoes Accesories": List<dynamic>.from(shoesAccesories.map((x) => x.toJson())),
    };
}

class ShoesAccesory {
    ShoesAccesory({
        this.id,
        this.createdDate,
        this.productId,
        this.productName,
        this.group,
        this.unit,
        this.quantity,
        this.storeId,
        this.storeName,
        this.salesPersonId,
        this.visitId,
    });

    String id;
    DateTime createdDate;
    String productId;
    String productName;
    String group;
    String unit;
    int quantity;
    String storeId;
    String storeName;
    String salesPersonId;
    String visitId;

    factory ShoesAccesory.fromJson(Map<String, dynamic> json) => ShoesAccesory(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        productId: json["productId"],
        productName: json["productName"],
        group: json["group"],
        unit: json["unit"],
        quantity: json["quantity"],
        storeId: json["storeId"],
        storeName: json["storeName"],
        salesPersonId: json["salesPersonId"],
        visitId: json["visitId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "productId": productId,
        "productName": productName,
        "group": group,
        "unit": unit,
        "quantity": quantity,
        "storeId": storeId,
        "storeName": storeName,
        "salesPersonId": salesPersonId,
        "visitId": visitId,
    };
}
