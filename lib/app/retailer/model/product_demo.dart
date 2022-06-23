// // To parse this JSON data, do
// //
// //     final productDatum = productDatumFromJson(jsonString);

// import 'dart:convert';

// List<Product> productDatumFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

// String productDatumToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
// // class ProductList {
// //   final List<Product> productDatums;

// //   ProductList({
// //     this.productDatums,
// // });

// //   factory ProductList.fromJson(List<dynamic> parsedJson) {

// //     List<Product> productDatums = new List<Product>();
// //     productDatums = parsedJson.map((i)=>Product.fromJson(i)).toList();

// //     return new ProductList(
// //       productDatums: productDatums
// //     );
// //   }
// // }
// class Product {
//     Product({
//         this.id,
//         this.createdDate,
//         this.name,
//         this.category,
//         this.description,
//         this.image,
//         this.primaryUnit,
//         this.primaryUnitPrice,
//         this.secondaryUnit,
//         this.secondaryUnitPrice,
//         this.discountPercentage,
//         this.discountAmount,
//         this.supplierId,
//     });

//     String id;
//     DateTime createdDate;
//     String name;
//     String category;
//     String description;
//     String image;
//     String primaryUnit;
//     double primaryUnitPrice;
//     String secondaryUnit;
//     double secondaryUnitPrice;
//     int discountPercentage;
//     double discountAmount;
//     dynamic supplierId;

//     factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         createdDate: DateTime.parse(json["createdDate"]),
//         name: json["name"],
//         category: json["category"],
//         description: json["description"],
//         image: json["image"],
//         primaryUnit: json["primaryUnit"],
//         primaryUnitPrice: json["primaryUnitPrice"],
//         secondaryUnit: json["secondaryUnit"],
//         secondaryUnitPrice: json["secondaryUnitPrice"],
//         discountPercentage: json["discountPercentage"],
//         discountAmount: json["discountAmount"],
//         supplierId: json["supplierId"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
//         "name": name,
//         "category": category,
//         "description": description,
//         "image": image,
//         "primaryUnit": primaryUnit,
//         "primaryUnitPrice": primaryUnitPrice,
//         "secondaryUnit": secondaryUnit,
//         "secondaryUnitPrice": secondaryUnitPrice,
//         "discountPercentage": discountPercentage,
//         "discountAmount": discountAmount,
//         "supplierId": supplierId,
//     };
// }
