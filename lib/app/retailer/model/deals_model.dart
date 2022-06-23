// To parse this JSON data, do
//
//     final deals = dealsFromJson(jsonString);

import 'dart:convert';

List<Deals> dealsFromJson(String str) => List<Deals>.from(json.decode(str).map((x) => Deals.fromJson(x)));

String dealsToJson(List<Deals> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Deals {
    Deals({
        this.id,
        this.createdDate,
        this.name,
        this.startDate,
        this.endDate,
        this.product,
        this.zoneIds,
        this.zones,
        this.supplierId,
        this.distributorId,
        this.price,
        this.visibility,
        this.status,
    });

    String id;
    DateTime createdDate;
    String name;
    DateTime startDate;
    DateTime endDate;
    Product product;
    List<String> zoneIds;
    List<Zone> zones;
    String supplierId;
    String distributorId;
    double price;
    String visibility;
    String status;

    factory Deals.fromJson(Map<String, dynamic> json) => Deals(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        name: json["name"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        product: Product.fromJson(json["product"]),
        zoneIds: List<String>.from(json["zoneIds"].map((x) => x)),
        zones: List<Zone>.from(json["zones"].map((x) => Zone.fromJson(x))),
        supplierId: json["supplierId"],
        distributorId: json["distributorId"],
        price: json["price"],
        visibility: json["visibility"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "name": name,
        "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "product": product.toJson(),
        "zoneIds": List<dynamic>.from(zoneIds.map((x) => x)),
        "zones": List<dynamic>.from(zones.map((x) => x.toJson())),
        "supplierId": supplierId,
        "distributorId": distributorId,
        "price": price,
        "visibility": visibility,
        "status": status,
    };
}

class Product {
    Product({
        this.id,
        this.createdDate,
        this.name,
        this.categoryId,
        this.category,
        this.description,
        this.image,
        this.primaryUnit,
        this.primaryUnitPrice,
        this.secondaryUnit,
        this.secondaryUnitPrice,
        this.discount,
        this.campaign,
        this.supplierId,
        this.supplier,
        this.status,
    });

    String id;
    DateTime createdDate;
    String name;
    String categoryId;
    dynamic category;
    String description;
    String image;
    String primaryUnit;
    double primaryUnitPrice;
    String secondaryUnit;
    double secondaryUnitPrice;
    dynamic discount;
    dynamic campaign;
    String supplierId;
    dynamic supplier;
    String status;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        name: json["name"],
        categoryId: json["categoryId"],
        category: json["category"],
        description: json["description"],
        image: json["image"],
        primaryUnit: json["primaryUnit"],
        primaryUnitPrice: json["primaryUnitPrice"],
        secondaryUnit: json["secondaryUnit"],
        secondaryUnitPrice: json["secondaryUnitPrice"],
        discount: json["discount"],
        campaign: json["campaign"],
        supplierId: json["supplierId"],
        supplier: json["supplier"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "name": name,
        "categoryId": categoryId,
        "category": category,
        "description": description,
        "image": image,
        "primaryUnit": primaryUnit,
        "primaryUnitPrice": primaryUnitPrice,
        "secondaryUnit": secondaryUnit,
        "secondaryUnitPrice": secondaryUnitPrice,
        "discount": discount,
        "campaign": campaign,
        "supplierId": supplierId,
        "supplier": supplier,
        "status": status,
    };
}

class Zone {
    Zone({
        this.name,
        this.id,
    });

    String name;
    String id;

    factory Zone.fromJson(Map<String, dynamic> json) => Zone(
        name: json["name"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
    };
}
