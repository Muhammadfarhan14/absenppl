import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simor/models/dosen_model.dart';
import 'package:simor/models/mahasiswa_model.dart';
import 'package:simor/models/pembimbing_model.dart';
import 'package:simor/services/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  String mhsId = '';

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    final result = await authRepository.login(username, password);
    result.fold(
      (failed) => emit(AuthFailed(failed)),
      (success) => emit(AuthSuccess()),
    );
  }

  Future<String> getRole() async {
    emit(AuthLoading());
    final result = await authRepository.getRoleUser();
    return result;
  }

  Future<void> getDataMahasiswa() async {
    emit(AuthLoading());
    final result = await authRepository.getDataMahasiswa();
    result.fold(
      (failed) => emit(AuthFailed(failed)),
      (success) {
        mhsId = success.nim;
        emit(AuthMahsiswa(success));
      },
    );
  }

  Future<void> getDataPembimbing() async {
    emit(AuthLoading());
    final result = await authRepository.getDataPembimbing();
    result.fold(
      (failed) => emit(AuthFailed(failed)),
      (success) => emit(AuthPembimbing(success)),
    );
  }

  Future<void> getDataDosen() async {
    emit(AuthLoading());
    final result = await authRepository.getDataDosen();
    result.fold(
      (failed) => emit(AuthFailed(failed)),
      (success) => emit(AuthDosen(success)),
    );
  }

  void initial() => emit(AuthInitial());
}
