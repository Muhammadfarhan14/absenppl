part of 'mahasiswa_cubit.dart';

abstract class MahasiswaState extends Equatable {
  const MahasiswaState();

  @override
  List<Object> get props => [];
}

class MahasiswaInitial extends MahasiswaState {}

class MahasiswaLoading extends MahasiswaState {}

class MahasiswaFailure extends MahasiswaState {
  final String message;
  const MahasiswaFailure(this.message);
}

class MahasiswaGetkegiatan extends MahasiswaState {
  final List<KegiatanModel> kegiatan;
  const MahasiswaGetkegiatan(this.kegiatan);

  @override
  List<Object> get props => [kegiatan];
}

class MahasiswaGetKendala extends MahasiswaState {
  final KendalaModel kendala;
  const MahasiswaGetKendala(this.kendala);

  @override
  List<Object> get props => [kendala];
}

class MahasiswaGetPdf extends MahasiswaState {
  final String url;
  const MahasiswaGetPdf(this.url);

  @override
  List<Object> get props => [url];
}
