import 'dart:convert';

DosenMahasiswaModel dosenMahasiswaModelFromJson(String str) =>
    DosenMahasiswaModel.fromJson(json.decode(str));

String dosenMahasiswaModelToJson(DosenMahasiswaModel data) =>
    json.encode(data.toJson());

class DosenMahasiswaModel {
  final int id;
  final String nama;
  final String nim;
  final String gambar;
  final String pdf;
  final List<Kegiatan> kegiatan;
  final List<Datang> datang;
  final List<Pulang> pulang;

  DosenMahasiswaModel({
    required this.id,
    required this.nama,
    required this.nim,
    required this.gambar,
    required this.pdf,
    required this.kegiatan,
    required this.datang,
    required this.pulang,
  });

  factory DosenMahasiswaModel.fromJson(Map<String, dynamic> json) =>
      DosenMahasiswaModel(
        id: json["id"],
        nama: json["nama"],
        nim: json["nim"],
        gambar: json["gambar"],
        pdf: json["pdf"],
        kegiatan: List<Kegiatan>.from(
            json["kegiatan"].map((x) => Kegiatan.fromJson(x))),
        datang:
            List<Datang>.from(json["datang"].map((x) => Datang.fromJson(x))),
        pulang:
            List<Pulang>.from(json["pulang"].map((x) => Pulang.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "nim": nim,
        "gambar": gambar,
        "pdf": pdf,
        "kegiatan": List<dynamic>.from(kegiatan.map((x) => x.toJson())),
        "datang": List<dynamic>.from(datang.map((x) => x.toJson())),
        "pulang": List<dynamic>.from(pulang.map((x) => x.toJson())),
      };
}

class Datang {
  final int id;
  final int mahasiswaId;
  final String gambar;
  final String keterangan;
  final DateTime tanggal;
  final String jamDatang;

  Datang({
    required this.id,
    required this.mahasiswaId,
    required this.gambar,
    required this.keterangan,
    required this.tanggal,
    required this.jamDatang,
  });

  factory Datang.fromJson(Map<String, dynamic> json) => Datang(
        id: json["id"],
        mahasiswaId: json["mahasiswa_id"],
        gambar: json["gambar"],
        keterangan: json["keterangan"],
        tanggal: DateTime.parse(json["tanggal"]),
        jamDatang: json["jam_datang"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mahasiswa_id": mahasiswaId,
        "gambar": gambar,
        "keterangan": keterangan,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "jam_datang": jamDatang,
      };
}

class Kegiatan {
  final int id;
  final int mahasiswaId;
  final String deskripsi;
  final String jamMulai;

  Kegiatan({
    required this.id,
    required this.mahasiswaId,
    required this.deskripsi,
    required this.jamMulai,
  });

  factory Kegiatan.fromJson(Map<String, dynamic> json) => Kegiatan(
        id: json["id"],
        mahasiswaId: json["mahasiswa_id"],
        deskripsi: json["deskripsi"],
        jamMulai: json["jam_mulai"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mahasiswa_id": mahasiswaId,
        "deskripsi": deskripsi,
        "jam_mulai": jamMulai,
      };
}

class Pulang {
  final int id;
  final int mahasiswaId;
  final String gambar;
  final String keterangan;
  final String jamPulang;

  Pulang({
    required this.id,
    required this.mahasiswaId,
    required this.gambar,
    required this.keterangan,
    required this.jamPulang,
  });

  factory Pulang.fromJson(Map<String, dynamic> json) => Pulang(
        id: json["id"],
        mahasiswaId: json["mahasiswa_id"],
        gambar: json["gambar"],
        keterangan: json["keterangan"],
        jamPulang: json["jam_pulang"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mahasiswa_id": mahasiswaId,
        "gambar": gambar,
        "keterangan": keterangan,
        "jam_pulang": jamPulang,
      };
}
