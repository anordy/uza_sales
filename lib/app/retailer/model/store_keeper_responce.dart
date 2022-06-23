import 'dart:convert';

StoreKeeper storeKeeperFromJson(String str) => StoreKeeper.fromJson(json.decode(str));

String storeKeeperToJson(StoreKeeper data) => json.encode(data.toJson());

class StoreKeeper {
    StoreKeeper({
        this.code,
        this.message,
        this.data,
    });

    int code;
    Message message;
    Data data;

    factory StoreKeeper.fromJson(Map<String, dynamic> json) => StoreKeeper(
        code: json["code"],
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message.toJson(),
        "data": data.toJson(),
    };
}

class Data {
    Data({
        this.id,
        this.createdDate,
        this.name,
        this.address,
        this.location,
        this.storeOwnerId,
        this.storeKeeperId,
        this.storeKeeperOrderPermission,
        this.zoneId,
    });

    String id;
    DateTime createdDate;
    String name;
    String address;
    Location location;
    String storeOwnerId;
    String storeKeeperId;
    bool storeKeeperOrderPermission;
    String zoneId;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        name: json["name"],
        address: json["address"],
        location: Location.fromJson(json["location"]),
        storeOwnerId: json["storeOwnerId"],
        storeKeeperId: json["storeKeeperId"],
        storeKeeperOrderPermission: json["storeKeeperOrderPermission"],
        zoneId: json["zoneId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "name": name,
        "address": address,
        "location": location.toJson(),
        "storeOwnerId": storeOwnerId,
        "storeKeeperId": storeKeeperId,
        "storeKeeperOrderPermission": storeKeeperOrderPermission,
        "zoneId": zoneId,
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

class Message {
    Message({
        this.sw,
        this.en,
    });

    String sw;
    String en;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        sw: json["sw"],
        en: json["en"],
    );

    Map<String, dynamic> toJson() => {
        "sw": sw,
        "en": en,
    };
}
