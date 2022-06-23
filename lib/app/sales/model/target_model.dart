// To parse this JSON data, do
//
//     final target = targetFromJson(jsonString);

import 'dart:convert';

Target targetFromJson(String str) => Target.fromJson(json.decode(str));

String targetToJson(Target data) => json.encode(data.toJson());

class Target {
    Target({
        this.revenue,
        this.products,
    });

    Revenue revenue;
    List<Product> products;

    factory Target.fromJson(Map<String, dynamic> json) => Target(
        revenue: Revenue.fromJson(json["revenue"] == null ? 0 : json["revenue"]  ),
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "revenue": revenue.toJson(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Product {
    Product({
        this.unit,
        this.productId,
        this.productName,
        this.sales,
        this.target,
    });

    String unit;
    String productId;
    String productName;
    int sales;
    int target;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        unit: json["unit"],
        productId: json["productId"],
        productName: json["productName"],
        sales: json["sales"],
        target: json["target"],
    );

    Map<String, dynamic> toJson() => {
        "unit": unit,
        "productId": productId,
        "productName": productName,
        "sales": sales,
        "target": target,
    };
}

class Revenue {
    Revenue({
        this.unit,
        this.sales,
        this.target,
    });

    String unit;
    double sales;
    double target;

    factory Revenue.fromJson(Map<String, dynamic> json) => Revenue(
        unit: json["unit"],
        sales: json["sales"],
        target: json["target"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "unit": unit,
        "sales": sales,
        "target": target,
    };
}
