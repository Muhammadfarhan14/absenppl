import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simor/models/cek_mahasiswa.dart';
import 'package:simor/models/penilaian_model.dart';

import '../config/core.dart';

class PembimbingRepository {
  final http.Client client;
  final SharedPreferences sharedPreferences;
  final String _userTokenKey = 'user_token';
  PembimbingRepository({required this.sharedPreferences, required this.client});

  Future<Either<String, List<CekMhs>>> getMhs() async {
    try {
      final token = await getUserToken();

      final response = await client.get(
        Uri.parse('$baseUrl/pembimbing-lapangan/onboarding'),
        headers: {
          'accept': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> mhs = data['data']['mahasiswa'];
        List<CekMhs> cleanDataList = [];

        for (var i = 0; i < mhs.length; i++) {
          if (mhs[i]['datang'].length != 0) {
            String keteranganDatang = '';
            if (mhs[i]['datang'][0]['keterangan'] == 'hadir') {
              keteranganDatang = 'hadir';
            }

            String keteranganPulang = '';
            if (mhs[i]['pulang'].length != 0 &&
                mhs[i]['pulang'][0]['keterangan'] == 'hadir') {
              keteranganPulang = 'hadir';
            }

            CekMhs cleanData = CekMhs(
              nim: mhs[i]['nim'],
              gambar: mhs[i]['gambar'],
              nama: mhs[i]['nama'],
              keteranganDatang: keteranganDatang,
              keteranganPulang: keteranganPulang,
              idPpl: mhs[i]['id_PPL'],
            );
            cleanDataList.add(cleanData);
          } else {
            CekMhs cleanData = CekMhs(
              nim: mhs[i]['nim'],
              gambar: mhs[i]['gambar'],
              nama: mhs[i]['nama'],
              keteranganDatang: '',
              keteranganPulang: '',
              idPpl: mhs[i]['id_PPL'],
            );
            cleanDataList.add(cleanData);
          }
        }

        return Right(cleanDataList);
      }
      return Left(
        'Gagal mengambil data mahasiswa. Status code: ${response.statusCode}',
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> konfirmasiDatang(String idPpl) async {
    try {
      final token = await getUserToken();

      final response = await client.post(
        Uri.parse('$baseUrl/pembimbing-lapangan/konfirmasi_presensi_datang'),
        headers: {
          'accept': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: {'id_PPL': idPpl},
      );

      if (response.statusCode == 200) {
        return const Right(null);
      }

      return Left(
        'Gagal Konfimasi absensi mahasiswa. Status code: ${response.statusCode}',
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> konfirmasiPulang(String idPpl) async {
    try {
      final token = await getUserToken();

      final response = await client.post(
        Uri.parse('$baseUrl/pembimbing-lapangan/konfirmasi_presensi_pulang'),
        headers: {
          'accept': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: {'id_PPL': idPpl},
      );

      if (response.statusCode == 200) {
        return const Right(null);
      }

      return Left(
        'Gagal Konfimasi absensi mahasiswa. Status code: ${response.statusCode}',
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, CekMhs>> cekMahasiswa(String idPpl) async {
    try {
      final token = await getUserToken();

      final stopwatch = Stopwatch();
      stopwatch.start();

      final response = await client.get(
        Uri.parse(
          '$baseUrl/pembimbing-lapangan/check_presensi_datang?id_PPL=$idPpl',
        ),
        headers: {
          'accept': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        stopwatch.stop(); // Stop the stopwatch

        final duration = stopwatch.elapsedMilliseconds;
        debugPrint('$duration Miliseconds For Hit Api');
        final data = json.decode(response.body);
        CekMhs cleanData = CekMhs(
          nim: data['data']['nim'],
          gambar: data['data']['gambar'],
          nama: data['data']['nama'],
          keteranganDatang: '',
          keteranganPulang: '',
          idPpl: data['data']['id_PPL'],
        );
        return Right(cleanData);
      }

      return const Left('Kamu tidak terdaftar pada pembimbing ini');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> checkDaysPembimbing() async {
    try {
      final token = await getUserToken();

      final response = await client.get(
        Uri.parse('$baseUrl/pembimbing-lapangan/check_hari_ke_45'),
        headers: {
          'accept': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['data'].toString() != '[]') {
        return Right(data['data']['check45Hari']);
      }

      return const Right(false);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<PenilaianModel>>> getPenilaian() async {
    try {
      final token = await getUserToken();

      final response = await client.get(
        Uri.parse(
          '$baseUrl/pembimbing-lapangan/select_mahasiswa_kriteria_penilaian',
        ),
        headers: {
          'accept': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Right(List<PenilaianModel>.from(
          data['data'].map((e) => PenilaianModel.fromJson(e)).toList(),
        ));
      }

      return const Left('Gagal mengambil data penilaian');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> sendNilai(List<int> data, String id) async {
    try {
      final token = await getUserToken();

      final response = await client.post(
          Uri.parse(
            '$baseUrl/pembimbing-lapangan/kriteria_penilaian?id=$id',
          ),
          headers: {
            'accept': 'application/json',
            'authorization': 'Bearer $token',
          },
          body: {
            'mahasiswa_id': id,
            'inovasi': '${data[0]}',
            'kerja_sama': '${data[1]}',
            'disiplin': '${data[2]}',
            'inisiatif': '${data[3]}',
            'kerajinan': '${data[4]}',
            'sikap': '${data[5]}',
          });

      if (response.statusCode == 200) {
        return const Right(null);
      }

      return const Left('Gagal mengirim Nilai');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(_userTokenKey) ?? '';
  }
}
