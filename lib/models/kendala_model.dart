import 'dart:convert';

KendalaModel kendalaModelFromJson(String str) =>
    KendalaModel.fromJson(json.decode(str));

String kendalaModelToJson(KendalaModel data) => json.encode(data.toJson());

class KendalaModel {
  final int id;
  final int mahasiswaId;
  final String deskripsi;
  final int status;
  final DateTime tanggal;
  final DateTime createdAt;
  final DateTime updatedAt;

  KendalaModel({
    required this.id,
    required this.mahasiswaId,
    required this.deskripsi,
    required this.status,
    required this.tanggal,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KendalaModel.fromJson(Map<String, dynamic> json) => KendalaModel(
        id: json["id"],
        mahasiswaId: json["mahasiswa_id"],
        deskripsi: json["deskripsi"],
        status: json["status"],
        tanggal: DateTime.parse(json["tanggal"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mahasiswa_id": mahasiswaId,
        "deskripsi": deskripsi,
        "status": status,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
