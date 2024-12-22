import 'dart:convert';

PembimbingModel pembimbingModelFromJson(String str) =>
    PembimbingModel.fromJson(json.decode(str));

String pembimbingModelToJson(PembimbingModel data) =>
    json.encode(data.toJson());

class PembimbingModel {
  final String namaPembimbingLapangan;
  final String namaDosenPembimbing;
  final String roles;
  final Lokasi lokasi;

  PembimbingModel({
    required this.namaPembimbingLapangan,
    required this.namaDosenPembimbing,
    required this.roles,
    required this.lokasi,
  });

  factory PembimbingModel.fromJson(Map<String, dynamic> json) =>
      PembimbingModel(
        namaPembimbingLapangan: json["nama_pembimbing_lapangan"],
        namaDosenPembimbing: json["nama_dosen_pembimbing"],
        roles: json["roles"],
        lokasi: Lokasi.fromJson(json["lokasi"]),
      );

  Map<String, dynamic> toJson() => {
        "nama_pembimbing_lapangan": namaPembimbingLapangan,
        "nama_dosen_pembimbing": namaDosenPembimbing,
        "roles": roles,
        "lokasi": lokasi.toJson(),
      };
}

class Lokasi {
  final int id;
  final String gambar;
  final String nama;
  final String alamat;
  final DateTime createdAt;
  final DateTime updatedAt;

  Lokasi({
    required this.id,
    required this.gambar,
    required this.nama,
    required this.alamat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Lokasi.fromJson(Map<String, dynamic> json) => Lokasi(
        id: json["id"],
        gambar: json["gambar"],
        nama: json["nama"],
        alamat: json["alamat"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gambar": gambar,
        "nama": nama,
        "alamat": alamat,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
