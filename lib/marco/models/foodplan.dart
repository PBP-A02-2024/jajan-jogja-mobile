// To parse this JSON data, do
//
//     final foodPlan = foodPlanFromJson(jsonString);

import 'dart:convert';

List<FoodPlan> foodPlanFromJson(String str) => List<FoodPlan>.from(json.decode(str).map((x) => FoodPlan.fromJson(x)));

String foodPlanToJson(List<FoodPlan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodPlan {
  String model;
  String pk;
  Fields fields;

  FoodPlan({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory FoodPlan.fromJson(Map<String, dynamic> json) => FoodPlan(
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
  int user;
  String nama;
  List<String> tempatKuliner;
  List<String> makanan;

  Fields({
    required this.user,
    required this.nama,
    required this.tempatKuliner,
    required this.makanan,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    nama: json["nama"],
    tempatKuliner: List<String>.from(json["tempat_kuliner"].map((x) => x)),
    makanan: List<String>.from(json["makanan"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "nama": nama,
    "tempat_kuliner": List<dynamic>.from(tempatKuliner.map((x) => x)),
    "makanan": List<dynamic>.from(makanan.map((x) => x)),
  };
}
