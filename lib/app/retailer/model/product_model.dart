// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
        this.discountPercentage,
        this.discount,
        
        this.supplierId,
        this.supplier,
        this.status,
    });

    String id;
    DateTime createdDate;
    String name;
    String categoryId;
    String category;
    String description;
    String image;
    String primaryUnit;
    double primaryUnitPrice;
    String secondaryUnit;
    double secondaryUnitPrice;
    dynamic discountPercentage;
    Discount discount;
    String supplierId;
    String supplier;
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
        discountPercentage: json["discountPercentage"],
        discount: Discount.fromJson(json["discount"]),
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
        "discountPercentage": discountPercentage,
        "discount": discount.toJson(),
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

class Discount {
    Discount({
        this.id,
        this.createdDate,
        this.productId,
        this.product,
        this.zoneIds,
        this.zones,
        this.originalPrice,
        this.discountRate,
        this.newPrice,
        this.numberOfProductsToBeSold,
        this.visibility,
        this.status,
    });

    dynamic id;
    dynamic createdDate;
    dynamic productId;
    dynamic product;
    dynamic zoneIds;
    dynamic zones;
    double originalPrice;
    dynamic discountRate;
    double newPrice;
    dynamic numberOfProductsToBeSold;
    dynamic visibility;
    String status;

    factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        id: json["id"],
        createdDate: json["createdDate"],
        productId: json["productId"],
        product: json["product"],
        zoneIds: json["zoneIds"],
        zones: json["zones"],
        originalPrice: json["originalPrice"],
        discountRate: json["discountRate"],
        newPrice: json["newPrice"],
        numberOfProductsToBeSold: json["numberOfProductsToBeSold"],
        visibility: json["visibility"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate,
        "productId": productId,
        "product": product,
        "zoneIds": zoneIds,
        "zones": zones,
        "originalPrice": originalPrice,
        "discountRate": discountRate,
        "newPrice": newPrice,
        "numberOfProductsToBeSold": numberOfProductsToBeSold,
        "visibility": visibility,
        "status": status,
    };
}
