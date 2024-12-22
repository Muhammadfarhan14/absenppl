import 'dart:convert';

DatangModel datangModelFromJson(String str) =>
    DatangModel.fromJson(json.decode(str));

class DatangModel {
  final int id;
  final int mahasiswaId;
  final dynamic gambar;
  final dynamic keterangan;
  final DateTime tanggal;
  final DateTime createdAt;
  final DateTime updatedAt;

  DatangModel({
    required this.id,
    required this.mahasiswaId,
    required this.gambar,
    required this.keterangan,
    required this.tanggal,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DatangModel.fromJson(Map<String, dynamic> json) => DatangModel(
        id: json["id"],
        mahasiswaId: json["mahasiswa_id"],
        gambar: json["gambar"].toString(),
        keterangan: json["keterangan"].toString(),
        tanggal: DateTime.parse(json["tanggal"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
