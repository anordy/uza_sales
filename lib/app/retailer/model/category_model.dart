// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
    Category({
        this.name,
        this.id,
        this.subCategories,
    });

    String name;
    String id;
    List<SubCategory> subCategories;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        id: json["id"],
        subCategories: List<SubCategory>.from(json["subCategories"].map((x) => SubCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "subCategories": List<dynamic>.from(subCategories.map((x) => x.toJson())),
    };
}


List<SubCategory> subCategoryFromJson(String str) => List<SubCategory>.from(json.decode(str).map((x) => SubCategory.fromJson(x)));

String subCategoryToJson(List<SubCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class SubCategory {
    SubCategory({
        this.name,
        this.id,
    });

    String name;
    String id;

    factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        name: json["name"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
    };
}
