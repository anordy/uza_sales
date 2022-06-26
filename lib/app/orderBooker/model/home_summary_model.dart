// To parse this JSON data, do
//
//     final homeSummary = homeSummaryFromJson(jsonString);

import 'dart:convert';

HomeSummary homeSummaryFromJson(String str) =>
    HomeSummary.fromJson(json.decode(str));

String homeSummaryToJson(HomeSummary data) => json.encode(data.toJson());

class HomeSummary {
  HomeSummary({
    this.totalPaid,
    this.totalCredited,
    this.totalSales,
  });

  Total totalPaid;
  Total totalCredited;
  Total totalSales;

  factory HomeSummary.fromJson(Map<String, dynamic> json) => HomeSummary(
        totalPaid: Total.fromJson(json["totalPaid"]),
        totalCredited: Total.fromJson(json["totalCredited"]),
        totalSales: Total.fromJson(json["totalSales"]),
      );

  Map<String, dynamic> toJson() => {
        "totalPaid": totalPaid.toJson(),
        "totalCredited": totalCredited.toJson(),
        "totalSales": totalSales.toJson(),
      };
}

class Total {
  Total({
    this.amount,
    this.orders,
  });

  int amount;
  int orders;

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        amount: json["amount"],
        orders: json["orders"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "orders": orders,
      };
}
