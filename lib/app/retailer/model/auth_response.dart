
import 'dart:convert';

AuthResponce authResponceFromJson(String str) => AuthResponce.fromJson(json.decode(str));

String authResponceToJson(AuthResponce data) => json.encode(data.toJson());

class AuthResponce {
    AuthResponce({
        this.code,
        this.message,
    });

    int code;
    Message message;

    factory AuthResponce.fromJson(Map<String, dynamic> json) => AuthResponce(
        code: json["code"],
        message: Message.fromJson(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message.toJson(),
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
