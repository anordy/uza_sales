
import 'dart:convert';

UserResponce userResponceFromJson(String str) => UserResponce.fromJson(json.decode(str));

String userResponceToJson(UserResponce data) => json.encode(data.toJson());

class UserResponce {
    UserResponce({
        this.id,
        this.username,
        this.email,
        this.firstname,
        this.lastname,
        this.nextStep,
        this.roles,
        this.accessToken,
        this.tokenType,
    });

    String id;
    String username;
    String firstname;
    String lastname;
    dynamic email;
    String nextStep;
    List<String> roles;
    String accessToken;
    String tokenType;

    factory UserResponce.fromJson(Map<String, dynamic> json) => UserResponce(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        nextStep: json["nextStep"],
        firstname: json['firstname'],
        lastname: json['lastname'],
        roles: List<String>.from(json["roles"].map((x) => x)),
        accessToken: json["accessToken"],
        tokenType: json["tokenType"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "nextStep": nextStep,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "accessToken": accessToken,
        "tokenType": tokenType,
    };
}
