// To parse this JSON data, do
//
//     final points = pointsFromJson(jsonString);

import 'dart:convert';

Points pointsFromJson(String str) => Points.fromJson(json.decode(str));

String pointsToJson(Points data) => json.encode(data.toJson());

class Points {
    Points({
        this.points,
    });

    int points;

    factory Points.fromJson(Map<String, dynamic> json) => Points(
        points: json["points"],
    );

    Map<String, dynamic> toJson() => {
        "points": points,
    };
}
