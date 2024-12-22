part of 'lokasi_cubit.dart';

abstract class LokasiState extends Equatable {
  const LokasiState();

  @override
  List<Object> get props => [];
}

class LokasiInitial extends LokasiState {}

class LokasiLoading extends LokasiState {}

class LokasiLoaded extends LokasiState {
  final List<DosenMahasiswaModel> dosenMahasiswaModel;
  const LokasiLoaded(this.dosenMahasiswaModel);

  @override
  List<Object> get props => [dosenMahasiswaModel];
}

class LokasiFailure extends LokasiState {
  final String message;
  const LokasiFailure(this.message);

  @override
  List<Object> get props => [message];
}
