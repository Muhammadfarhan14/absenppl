import 'dart:convert';

KegiatanModel kegiatanModelFromJson(String str) =>
    KegiatanModel.fromJson(json.decode(str));

String kegiatanModelToJson(KegiatanModel data) => json.encode(data.toJson());

class KegiatanModel {
  final String id;
  final String jam;
  final String deskripsi;

  KegiatanModel({
    required this.id,
    required this.jam,
    required this.deskripsi,
  });

  factory KegiatanModel.fromJson(Map<String, dynamic> json) => KegiatanModel(
        id: json["id"],
        jam: json["jam"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jam": jam,
        "deskripsi": deskripsi,
      };
}
