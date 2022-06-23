import 'dart:convert';

List<Country> countryFromJson(String str) => List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

String countryToJson(List<Country> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class CountryList {
  final List<Country> countries;

  CountryList({
    this.countries
});

  factory CountryList.fromJson(List<dynamic> parsedJson) {

    List<Country> countries = new List<Country>();
    countries = parsedJson.map((i)=>Country.fromJson(i)).toList();

    return new CountryList(
      countries: countries
    );
  }
}

class RegionList {
  final List<Country> regions;

  RegionList({
    this.regions
});

  factory RegionList.fromJson(List<dynamic> parsedJson) {

    List<Country> regions = new List<Country>();
    regions = parsedJson.map((i)=>Country.fromJson(i)).toList();

    return new RegionList(
      regions: regions
    );
  }
}

class DisitrictList {
  final List<Country> districts;

  DisitrictList({
    this.districts
});

  factory DisitrictList.fromJson(List<dynamic> parsedJson) {

    List<Country> districts = new List<Country>();
    districts = parsedJson.map((i)=>Country.fromJson(i)).toList();

    return new DisitrictList(
      districts: districts
    );
  }
}


class ZoneList {
  final List<Country> zones;

  ZoneList({
    this.zones
});

  factory ZoneList.fromJson(List<dynamic> parsedJson) {

    List<Country> zones = new List<Country>();
    zones = parsedJson.map((i)=>Country.fromJson(i)).toList();

    return new ZoneList(
      zones: zones
    );
  }
}

class Country {
    Country({
        this.name,
        this.id,
    });

    String name;
    String id;

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["name"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
    };
}
