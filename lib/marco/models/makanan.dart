// To parse this JSON data, do
//
//     final makanan = makananFromJson(jsonString);

import 'dart:convert';

List<Makanan> makananFromJson(String str) => List<Makanan>.from(json.decode(str).map((x) => Makanan.fromJson(x)));

String makananToJson(List<Makanan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Makanan {
  String model;
  String pk;
  Fields fields;

  Makanan({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Makanan.fromJson(Map<String, dynamic> json) => Makanan(
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
  String tempatKuliner;
  String nama;
  String description;
  int harga;
  String fotoLink;

  Fields({
    required this.tempatKuliner,
    required this.nama,
    required this.description,
    required this.harga,
    required this.fotoLink,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    tempatKuliner: json["tempat_kuliner"],
    nama: json["nama"],
    description: json["description"],
    harga: json["harga"],
    fotoLink: json["foto_link"],
  );

  Map<String, dynamic> toJson() => {
    "tempat_kuliner": tempatKuliner,
    "nama": nama,
    "description": description,
    "harga": harga,
    "foto_link": fotoLink,
  };
}
