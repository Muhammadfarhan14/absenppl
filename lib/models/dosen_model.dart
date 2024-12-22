import 'dart:convert';

DosenModel dosenModelFromJson(String str) =>
    DosenModel.fromJson(json.decode(str));

class DosenModel {
  final String nama;
  final String gambar;
  final String roles;

  DosenModel({
    required this.nama,
    required this.gambar,
    required this.roles,
  });

  factory DosenModel.fromJson(Map<String, dynamic> json) => DosenModel(
        nama: json["nama"],
        gambar: json["gambar"],
        roles: json["roles"],
      );
}
