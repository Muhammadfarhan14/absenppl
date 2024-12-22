import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simor/models/datang_model.dart';

import '../config/core.dart';

class StatusRepository {
  final http.Client client;
  final SharedPreferences sharedPreferences;
  final String _userTokenKey = 'user_token';

  StatusRepository({required this.client, required this.sharedPreferences});

  Future<Either<String, DatangModel>> checkDatang() async {
    try {
      String token = await getUserToken();
      final response = await client.get(
        Uri.parse('$baseUrl/mahasiswa/datang/detail_datang_by_tanggal'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      if (data['data'][0]['keterangan'].toString() == 'null' ||
          data['data'][0]['keterangan'].toString() == 'hadir') {
        return Right(DatangModel.fromJson(data['data'][0]));
      }

      return const Left("erorr");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> checkPulang() async {
    try {
      String token = await getUserToken();
      final response = await client.get(
        Uri.parse('$baseUrl/mahasiswa/pulang/detail_pulang_by_tanggal'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);
      final status = data['data'][0]['keterangan'].toString();

      if (data['data'][0]['keterangan'].toString() == 'hadir') {
        return Right(status);
      }

      return const Left("erorr");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(_userTokenKey) ?? "";
  }
}
