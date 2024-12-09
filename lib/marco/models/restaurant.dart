// To parse this JSON data, do
//
//     final tempatKuliner = tempatKulinerFromJson(jsonString);

import 'dart:convert';

List<TempatKuliner> tempatKulinerFromJson(String str) => List<TempatKuliner>.from(json.decode(str).map((x) => TempatKuliner.fromJson(x)));

String tempatKulinerToJson(List<TempatKuliner> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TempatKuliner {
  String model;
  String pk;
  Fields fields;

  TempatKuliner({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory TempatKuliner.fromJson(Map<String, dynamic> json) => TempatKuliner(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  String nama;
  String description;
  String alamat;
  String longitude;
  String latitude;
  String jamBuka;
  String jamTutup;
  String rating;
  String fotoLink;
  List<int> variasi;

  Fields({
    required this.nama,
    required this.description,
    required this.alamat,
    required this.longitude,
    required this.latitude,
    required this.jamBuka,
    required this.jamTutup,
    required this.rating,
    required this.fotoLink,
    required this.variasi,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    nama: json["nama"],
    description: json["description"],
    alamat: json["alamat"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    jamBuka: json["jamBuka"],
    jamTutup: json["jamTutup"],
    rating: json["rating"],
    fotoLink: json["foto_link"],
    variasi: List<int>.from(json["variasi"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "description": description,
    "alamat": alamat,
    "longitude": longitude,
    "latitude": latitude,
    "jamBuka": jamBuka,
    "jamTutup": jamTutup,
    "rating": rating,
    "foto_link": fotoLink,
    "variasi": List<dynamic>.from(variasi.map((x) => x)),
  };
}