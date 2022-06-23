
import 'dart:convert';

AdsData adsDataFromJson(String str) => AdsData.fromJson(json.decode(str));

String adsDataToJson(AdsData data) => json.encode(data.toJson());

class AdsData {
    AdsData({
        this.totalItems,
        this.totalPages,
        this.ads,
    });

    int totalItems;
    int totalPages;
    List<Ads> ads;

    factory AdsData.fromJson(Map<String, dynamic> json) => AdsData(
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        ads: List<Ads>.from(json["content"].map((x) => Ads.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "totalPages": totalPages,
        "content": List<dynamic>.from(ads.map((x) => x.toJson())),
    };
}

class Ads {
    Ads({
        this.id,
        this.createdDate,
        this.name,
        this.description,
        this.image,
        this.supplierId,
        this.distributorId,
        this.products,
        this.startDate,
        this.endDate,
        this.tagline,
        this.status,
    });

    String id;
    DateTime createdDate;
    String name;
    String description;
    dynamic image;
    String supplierId;
    String distributorId;
    List<String> products;
    DateTime startDate;
    DateTime endDate;
    String tagline;
    String status;

    factory Ads.fromJson(Map<String, dynamic> json) => Ads(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        name: json["name"],
        description: json["description"],
        image: json["image"],
        supplierId: json["supplierId"],
        distributorId: json["distributorId"],
        products: List<String>.from(json["products"].map((x) => x)),
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        tagline: json["tagline"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "name": name,
        "description": description,
        "image": image,
        "supplierId": supplierId,
        "distributorId": distributorId,
        "products": List<dynamic>.from(products.map((x) => x)),
        "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "tagline": tagline,
        "status": status,
    };
}

