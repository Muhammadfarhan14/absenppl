import 'dart:convert';

MahasiswaModel mahasiswaModelFromJson(String str) =>
    MahasiswaModel.fromJson(json.decode(str));

class MahasiswaModel {
  final String nama;
  final String nim;
  final String gambar;
  final String roles;
  final String dosenPembimbing;
  final String pembimbingLapangan;
  final String lokasi;

  MahasiswaModel({
    required this.nama,
    required this.nim,
    required this.gambar,
    required this.roles,
    required this.dosenPembimbing,
    required this.pembimbingLapangan,
    required this.lokasi,
  });

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) => MahasiswaModel(
        nama: json["nama"],
        nim: json["nim"],
        gambar: json["gambar"],
        roles: json["roles"],
        dosenPembimbing: json["dosen_pembimbing"],
        pembimbingLapangan: json["pembimbing_lapangan"],
        lokasi: json["lokasi"],
      );
}
