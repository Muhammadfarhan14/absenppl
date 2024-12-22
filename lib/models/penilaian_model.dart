import 'dart:convert';

PenilaianModel penilaianModelFromJson(String str) =>
    PenilaianModel.fromJson(json.decode(str));

String penilaianModelToJson(PenilaianModel data) => json.encode(data.toJson());

class PenilaianModel {
  final int id;
  final String nama;
  final String nim;
  final String gambar;
  final Lokasi lokasi;
  final int status;

  PenilaianModel({
    required this.id,
    required this.nama,
    required this.nim,
    required this.gambar,
    required this.lokasi,
    required this.status,
  });

  factory PenilaianModel.fromJson(Map<String, dynamic> json) => PenilaianModel(
        id: json["id"],
        nama: json["nama"],
        nim: json["nim"],
        gambar: json["gambar"],
        lokasi: Lokasi.fromJson(json["lokasi"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "nim": nim,
        "gambar": gambar,
        "lokasi": lokasi.toJson(),
        "status": status,
      };
}

class Lokasi {
  final int id;
  final String gambar;
  final String nama;
  final String alamat;

  Lokasi({
    required this.id,
    required this.gambar,
    required this.nama,
    required this.alamat,
  });

  factory Lokasi.fromJson(Map<String, dynamic> json) => Lokasi(
        id: json["id"],
        gambar: json["gambar"],
        nama: json["nama"],
        alamat: json["alamat"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gambar": gambar,
        "nama": nama,
        "alamat": alamat,
      };
}
