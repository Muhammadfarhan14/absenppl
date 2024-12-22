import 'dart:convert';

Kendala2Model kendala2ModelFromJson(String str) =>
    Kendala2Model.fromJson(json.decode(str));

class Kendala2Model {
  final String nama;
  final String alamat;
  final Kendala kendala;

  Kendala2Model({
    required this.nama,
    required this.alamat,
    required this.kendala,
  });

  factory Kendala2Model.fromJson(Map<String, dynamic> json) => Kendala2Model(
        nama: json["nama"],
        alamat: json["alamat"],
        kendala: Kendala.fromJson(json["kendala"]),
      );
}

class Kendala {
  final int id;
  final String deskripsi;
  final int status;
  final DateTime tanggal;

  Kendala({
    required this.id,
    required this.deskripsi,
    required this.status,
    required this.tanggal,
  });

  factory Kendala.fromJson(Map<String, dynamic> json) => Kendala(
        id: json["id"],
        deskripsi: json["deskripsi"],
        status: json["status"],
        tanggal: DateTime.parse(json["tanggal"]),
      );
}
