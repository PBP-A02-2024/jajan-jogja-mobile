// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

List<Review> reviewFromJson(String str) =>
    List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  int id;
  int userId;
  String userUsername;
  String tempatKuliner;
  String tempatKulinerNama;
  int rating;
  String comment;
  DateTime createdAt;
  int pk;

  Review({
    required this.id,
    required this.userId,
    required this.userUsername,
    required this.tempatKuliner,
    required this.tempatKulinerNama,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.pk,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["user__id"],
        userUsername: json["user__username"],
        tempatKuliner: json["tempat_kuliner"],
        tempatKulinerNama: json["tempat_kuliner__nama"],
        rating: json["rating"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        pk: json["pk"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user__id": userId,
        "user__username": userUsername,
        "tempat_kuliner": tempatKuliner,
        "tempat_kuliner__nama": tempatKulinerNama,
        "rating": rating,
        "comment": comment,
        "created_at": createdAt.toIso8601String(),
        "pk": pk,
      };
}
