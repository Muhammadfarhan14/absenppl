import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simor/services/dosen_repository.dart';

import '../../models/lokasi_model.dart';

part 'dosen_state.dart';

class DosenCubit extends Cubit<DosenState> {
  DosenRepository dosenRepository;
  DosenCubit({required this.dosenRepository}) : super(DosenInitial());

  Future<void> getLokasi() async {
    emit(DosenLoading());
    final result = await dosenRepository.getLokasi();
    result.fold(
      (erorr) => emit(DosenFailure(message: erorr)),
      (success) => emit(DosenLoaded(lokasi: success)),
    );
  }

  Future<void> getPdf() async {
    emit(DosenLoading());
    final result = await dosenRepository.getPdf();
    result.fold(
      (erorr) => emit(DosenFailure(message: erorr)),
      (succes) => emit(DosenGetPdf(url: succes)),
    );
  }
}
