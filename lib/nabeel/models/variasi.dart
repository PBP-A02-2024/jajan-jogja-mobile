// To parse this JSON data, do
//
//     final variasi = variasiFromJson(jsonString);

import 'dart:convert';

List<Variasi> variasiFromJson(String str) => List<Variasi>.from(json.decode(str).map((x) => Variasi.fromJson(x)));

String variasiToJson(List<Variasi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Variasi {
    Model model;
    int pk;
    Fields fields;

    Variasi({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Variasi.fromJson(Map<String, dynamic> json) => Variasi(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String nama;

    Fields({
        required this.nama,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        nama: json["nama"],
    );

    Map<String, dynamic> toJson() => {
        "nama": nama,
    };
}

enum Model {
    ZOYA_VARIASI
}

final modelValues = EnumValues({
    "zoya.variasi": Model.ZOYA_VARIASI
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
