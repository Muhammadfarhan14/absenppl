import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simor/models/kegiatan_model.dart';
import 'package:simor/services/mahasiswa_repository.dart';

import '../../models/kendala_model.dart';

part 'mahasiswa_state.dart';

class MahasiswaCubit extends Cubit<MahasiswaState> {
  final MahasiswaRepository mahasiswaRepository;
  MahasiswaCubit(this.mahasiswaRepository) : super(MahasiswaInitial());

  Future<void> datang(String imagePath) async {
    emit(MahasiswaLoading());
    final result = await mahasiswaRepository.datang(imagePath);

    result.fold((error) => emit(MahasiswaFailure(error)), (success) => null);
  }

  Future<void> saveKegiatan(KegiatanModel newKegiatan, String userId) async {
    await mahasiswaRepository.saveKegiatan(newKegiatan, userId);
  }

  Future<void> getKegiatan(String userId) async {
    final result = await mahasiswaRepository.getKegiatan(userId);
    emit(MahasiswaGetkegiatan(result));
  }

  Future<void> kirimKendala(String kendala) async {
    final result = await mahasiswaRepository.postKendala(kendala);
    result.fold((erorr) => emit(MahasiswaFailure(erorr)), (r) => null);
  }

  Future<void> cekKendala() async {
    final result = await mahasiswaRepository.getKendala();
    result.fold(
      (erorr) => emit(MahasiswaFailure(erorr)),
      (success) => emit(MahasiswaGetKendala(success)),
    );
  }

  Future<void> upFotoKegiatan(String imagePath, String userId) async {
    await mahasiswaRepository.upFoto(imagePath);
    await mahasiswaRepository.upKegiatan(userId);
  }

  Future<void> getPdf() async {
    emit(MahasiswaLoading());
    final result = await mahasiswaRepository.getPdf();
    result.fold(
      (erorr) => emit(MahasiswaFailure(erorr)),
      (success) => emit(MahasiswaGetPdf(success)),
    );
  }

  Future<void> logoutMahasiswa() async {
    await mahasiswaRepository.removeUserToken();
  }
}
