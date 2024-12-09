import 'dart:convert';

List<CommunityForumEntry> communityForumEntryFromJson(String str) => List<CommunityForumEntry>.from(json.decode(str).map((x) => CommunityForumEntry.fromJson(x)));

String communityForumEntryToJson(List<CommunityForumEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommunityForumEntry {
    String model;
    String pk;
    Fields fields;

    CommunityForumEntry({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory CommunityForumEntry.fromJson(Map<String, dynamic> json) => CommunityForumEntry(
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
    DateTime time;
    String comment;

    Fields({
        required this.user,
        required this.time,
        required this.comment,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        time: DateTime.parse(json["time"]),
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "time": "${time.year.toString().padLeft(4, '0')}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}",
        "comment": comment,
    };
}