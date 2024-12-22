import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simor/services/dosen_repository.dart';

import '../../models/lokasimhs_model.dart';

part 'lokasi_state.dart';

class LokasiCubit extends Cubit<LokasiState> {
  final DosenRepository dosenRepository;
  LokasiCubit({required this.dosenRepository}) : super(LokasiInitial());

  Future<void> getMahasiswaByLokasi(String tanggal, String id) async {
    emit(LokasiLoading());
    final result = await dosenRepository.getByLokasi(tanggal, id);
    result.fold(
      (erorr) => emit(LokasiFailure(erorr)),
      (success) => Future.delayed(const Duration(seconds: 1), () {
        emit(LokasiLoaded(success));
      }),
    );
  }
}
