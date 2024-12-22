import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:simor/models/cek_mahasiswa.dart';
import 'package:simor/services/pebimbing_repository.dart';

import '../../models/penilaian_model.dart';

part 'pembimbing_state.dart';

class PembimbingCubit extends Cubit<PembimbingState> {
  final PembimbingRepository pembimbingRepository;
  PembimbingCubit(this.pembimbingRepository) : super(PembimbingInitial());

  Future<void> getMahasiswa() async {
    emit(PembimbingLoading());
    final result = await pembimbingRepository.getMhs();
    result.fold(
      (erorr) => emit(PembimbingFailure(erorr)),
      (success) {
        emit(PembimbingLoaded(success));
      },
    );
  }

  Future<void> cekMahasiswa(String idPpl) async {
    emit(PembimbingLoading());
    final result = await pembimbingRepository.cekMahasiswa(idPpl);
    result.fold(
      (erorr) => emit(PembimbingFailure(erorr)),
      (success) => emit(PembimbingCekMhs(success)),
    );
  }

  Future<void> konfirmasiDatang(String nim) async {
    emit(PembimbingLoading());
    final result = await pembimbingRepository.konfirmasiDatang(nim);
    result.fold(
      (erorr) => emit(PembimbingFailure(erorr)),
      (succes) => null,
    );
  }

  Future<void> konfirmasiPulang(String nim) async {
    emit(PembimbingLoading());
    final result = await pembimbingRepository.konfirmasiPulang(nim);
    result.fold(
      (erorr) => emit(PembimbingFailure(erorr)),
      (succes) => null,
    );
  }

  Future<void> getMahasiswaPenilaian() async {
    emit(PembimbingLoading());
    final result = await pembimbingRepository.getPenilaian();
    result.fold(
      (erorr) => emit(PembimbingFailure(erorr)),
      (success) => emit(PembimbingPenilaian(success)),
    );
  }

  Future<void> sendNilai(List<int> data, String id) async {
    final result = await pembimbingRepository.sendNilai(data, id);
    result.fold(
      (l) => debugPrint(l),
      (r) => null,
    );
  }
}
