import 'dart:convert';

LokasiModel lokasiModelFromJson(String str) =>
    LokasiModel.fromJson(json.decode(str));

String lokasiModelToJson(LokasiModel data) => json.encode(data.toJson());

class LokasiModel {
  final int id;
  final String nama;
  final String gambar;
  final String alamat;
  final String pembimbingLapangan;
  final String dosenPembimbing;
  final double pesentasiKehadiran;

  LokasiModel({
    required this.id,
    required this.nama,
    required this.gambar,
    required this.alamat,
    required this.pembimbingLapangan,
    required this.dosenPembimbing,
    required this.pesentasiKehadiran,
  });

  factory LokasiModel.fromJson(Map<String, dynamic> json) => LokasiModel(
        id: json["id"],
        nama: json["nama"],
        gambar: json["gambar"],
        alamat: json["alamat"],
        pembimbingLapangan: json["pembimbing_lapangan"],
        dosenPembimbing: json["dosen_pembimbing"],
        pesentasiKehadiran: json["pesentasi_kehadiran"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "gambar": gambar,
        "alamat": alamat,
        "pembimbing_lapangan": pembimbingLapangan,
        "dosen_pembimbing": dosenPembimbing,
        "pesentasi_kehadiran": pesentasiKehadiran,
      };
}
