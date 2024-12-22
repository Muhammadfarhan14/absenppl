import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simor/services/dosen_repository.dart';
import 'package:simor/services/mahasiswa_repository.dart';
import 'package:simor/services/pebimbing_repository.dart';

part 'check_days_state.dart';

class CheckDaysCubit extends Cubit<CheckDaysState> {
  final PembimbingRepository pembimbingRepository;
  final MahasiswaRepository mahasiswaRepository;
  final DosenRepository dosenrepository;
  CheckDaysCubit({
    required this.dosenrepository,
    required this.mahasiswaRepository,
    required this.pembimbingRepository,
  }) : super(CheckDaysInitial());

  Future<void> checkDaysPembimbing() async {
    emit(CheckDaysLoading());
    final result = await pembimbingRepository.checkDaysPembimbing();
    result.fold(
      (error) => emit(CheckDaysFailure(message: error)),
      (succes) => emit(CheckDayPembimbing(days: succes)),
    );
  }

  Future<void> checkDaysMahasiswa() async {
    emit(CheckDaysLoading());
    final result = await mahasiswaRepository.checkDaysMahasiswa();
    result.fold(
      (error) => emit(CheckDaysFailure(message: error)),
      (succes) => emit(CheckDayMahasiswa(days: succes)),
    );
  }

  Future<void> checkDaysDosen() async {
    emit(CheckDaysLoading());
    final result = await dosenrepository.checkDaysDosen();
    result.fold(
      (erorr) => emit(CheckDaysFailure(message: erorr)),
      (success) => emit(CheckDayDosen(days: success)),
    );
  }
}
