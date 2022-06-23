// To parse this JSON data, do
//
//     final RouteModel = routeModelFromJson(jsonString);

import 'dart:convert';

RouteModel routeModelFromJson(String str) => RouteModel.fromJson(json.decode(str));

String routeModelToJson(RouteModel data) => json.encode(data.toJson());

class RouteModel {
    RouteModel({
        this.totalItems,
        this.totalPages,
        this.content,
    });

    int totalItems;
    int totalPages;
    Content content;

    factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
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
        this.route,
        this.visitedOutlets,
        this.notVisitedOutlets,
    });

    List<MyRoute> route;
    int visitedOutlets;
    int notVisitedOutlets;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        route: List<MyRoute>.from(json["route"].map((x) => MyRoute.fromJson(x))),
        visitedOutlets: json["visitedOutlets"],
        notVisitedOutlets: json["notVisitedOutlets"],
    );

    Map<String, dynamic> toJson() => {
        "route": List<dynamic>.from(route.map((x) => x.toJson())),
        "visitedOutlets": visitedOutlets,
        "notVisitedOutlets": notVisitedOutlets,
    };
}

class MyRoute {
    MyRoute({
        this.id,
        this.createdDate,
        this.groupId,
        this.stores,
        this.date,
        this.salesPersonId,
        this.status,
    });

    String id;
    DateTime createdDate;
    String groupId;
    List<SalesStore> stores;
    DateTime date;
    String salesPersonId;
    String status;

    factory MyRoute.fromJson(Map<String, dynamic> json) => MyRoute(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        groupId: json["groupId"],
        stores: List<SalesStore>.from(json["stores"].map((x) => SalesStore.fromJson(x))),
        date: DateTime.parse(json["date"]),
        salesPersonId: json["salesPersonId"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "groupId": groupId,
        "stores": List<dynamic>.from(stores.map((x) => x.toJson())),
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "salesPersonId": salesPersonId,
        "status": status,
    };
}

class SalesStore {
    SalesStore({
        this.id,
        this.createdDate,
        this.name,
        this.address,
        this.phone,
        this.location,
        this.storeOwnerId,
        this.storeKeeperId,
        this.category,
        this.storeKeeperOrderPermission,
        this.averageOrderValue,
        this.lastVisitDate,
        this.lastOrderDate,
        this.zoneId,
        this.image,
        this.createdBy,
        this.isCreatedByOwner,
        this.status,
    });

    String id;
    DateTime createdDate;
    String name;
    String address;
    String phone;
    Location location;
    String storeOwnerId;
    String storeKeeperId;
    dynamic category;
    bool storeKeeperOrderPermission;
    dynamic averageOrderValue;
    dynamic lastVisitDate;
    dynamic lastOrderDate;
    String zoneId;
    dynamic image;
    dynamic createdBy;
    dynamic isCreatedByOwner;
    String status;

    factory SalesStore.fromJson(Map<String, dynamic> json) => SalesStore(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        name: json["name"],
        address: json["address"],
        phone: json["phone"] == null ? null : json["phone"],
        location: Location.fromJson(json["location"]),
        storeOwnerId: json["storeOwnerId"],
        storeKeeperId: json["storeKeeperId"] == null ? null : json["storeKeeperId"],
        category: json["category"],
        storeKeeperOrderPermission: json["storeKeeperOrderPermission"],
        averageOrderValue: json["averageOrderValue"],
        lastVisitDate: json["lastVisitDate"],
        lastOrderDate: json["lastOrderDate"],
        zoneId: json["zoneId"],
        image: json["image"],
        createdBy: json["createdBy"],
        isCreatedByOwner: json["isCreatedByOwner"],
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "name": name,
        "address": address,
        "phone": phone == null ? null : phone,
        "location": location.toJson(),
        "storeOwnerId": storeOwnerId,
        "storeKeeperId": storeKeeperId == null ? null : storeKeeperId,
        "category": category,
        "storeKeeperOrderPermission": storeKeeperOrderPermission,
        "averageOrderValue": averageOrderValue,
        "lastVisitDate": lastVisitDate,
        "lastOrderDate": lastOrderDate,
        "zoneId": zoneId,
        "image": image,
        "createdBy": createdBy,
        "isCreatedByOwner": isCreatedByOwner,
        "status": status == null ? null : status,
    };
}

class Location {
    Location({
        this.latitude,
        this.longitude,
    });

    String latitude;
    String longitude;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}
















































// // To parse this JSON data, do
// //
// //     final RouteModel = routeModelFromJson(jsonString);

// import 'dart:convert';

// List<RouteModel> routeModelFromJson(String str) => List<RouteModel>.from(json.decode(str).map((x) => RouteModel.fromJson(x)));

// String myRouteToJson(List<RouteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class RouteModel {
//     RouteModel({
//         this.id,
//         this.createdDate,
//         this.groupId,
//         this.stores,
//         this.date,
//         this.salesPersonId,
//         this.status,
//     });

//     String id;
//     DateTime createdDate;
//     String groupId;
//     List<SalesStore> stores;
//     DateTime date;
//     String salesPersonId;
//     String status;

//     factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
//         id: json["id"],
//         createdDate: DateTime.parse(json["createdDate"]),
//         groupId: json["groupId"],
//         stores: List<SalesStore>.from(json["stores"].map((x) => SalesStore.fromJson(x))),
//         date: DateTime.parse(json["date"]),
//         salesPersonId: json["salesPersonId"],
//         status: json["status"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
//         "groupId": groupId,
//         "stores": List<dynamic>.from(stores.map((x) => x.toJson())),
//         "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//         "salesPersonId": salesPersonId,
//         "status": status,
//     };
// }

// class SalesStore {
//     SalesStore({
//         this.id,
//         this.createdDate,
//         this.name,
//         this.address,
//         this.phone,
//         this.location,
//         this.storeOwnerId,
//         this.storeKeeperId,
//         this.category,
//         this.storeKeeperOrderPermission,
//         this.averageOrderValue,
//         this.lastVisitDate,
//         this.lastOrderDate,
//         this.zoneId,
//         this.image,
//         this.createdBy,
//         this.isCreatedByOwner,
//         this.status,
//     });

//     String id;
//     DateTime createdDate;
//     String name;
//     String address;
//     String phone;
//     Location location;
//     String storeOwnerId;
//     String storeKeeperId;
//     dynamic category;
//     bool storeKeeperOrderPermission;
//     dynamic averageOrderValue;
//     dynamic lastVisitDate;
//     dynamic lastOrderDate;
//     String zoneId;
//     dynamic image;
//     dynamic createdBy;
//     dynamic isCreatedByOwner;
//     String status;

//     factory SalesStore.fromJson(Map<String, dynamic> json) => SalesStore(
//         id: json["id"],
//         createdDate: DateTime.parse(json["createdDate"]),
//         name: json["name"] == null ? null : json["name"] as String,
//         address: json["address"] == null ? null : json["address"] as String,
//         phone: json["phone"] == null ? null : json["phone"] as String,
//         location: Location.fromJson(json["location"] == null ? null : json["location"]),
//         storeOwnerId: json["storeOwnerId"],
//         storeKeeperId: json["storeKeeperId"],
//         category: json["category"] == null ? null : json["cactegory"] as String,
//         storeKeeperOrderPermission: json["storeKeeperOrderPermission"],
//         averageOrderValue: json["averageOrderValue"],
//         lastVisitDate: json["lastVisitDate"],
//         lastOrderDate: json["lastOrderDate"],
//         zoneId: json["zoneId"],
//         image: json["image"],
//         createdBy: json["createdBy"],
//         isCreatedByOwner: json["isCreatedByOwner"],
//         status: json["status"] == null ? null : json["status"] as String,
//     );

//     Map<String, dynamic> toJson() => {
      
//         "id": id,
//         "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
//         "name": name,
//         "address": address,
//         "phone": phone,
//         "location": location.toJson(),
//         "storeOwnerId": storeOwnerId,
//         "storeKeeperId": storeKeeperId,
//         "category": category,
//         "storeKeeperOrderPermission": storeKeeperOrderPermission,
//         "averageOrderValue": averageOrderValue,
//         "lastVisitDate": lastVisitDate,
//         "lastOrderDate": lastOrderDate,
//         "zoneId": zoneId,
//         "image": image,
//         "createdBy": createdBy,
//         "isCreatedByOwner": isCreatedByOwner,
//         "status": status,
//     };
// }

// class Location {
//     Location({
//         this.latitude,
//         this.longitude,
//     });
//     String latitude;
//     String longitude;
//     factory Location.fromJson(Map<String, dynamic> json) => Location(
//         latitude: json["latitude"] == null ? null : json["latitude"] as String,
//         longitude: json["longitude"] == null ? null : json["longitude"] as String,
//     );

//     Map<String, dynamic> toJson() => {
//         "latitude": latitude,
//         "longitude": longitude,
//     };
// }
