part of 'dosen_cubit.dart';

abstract class DosenState extends Equatable {
  const DosenState();

  @override
  List<Object> get props => [];
}

class DosenInitial extends DosenState {}

class DosenLoading extends DosenState {}

class DosenLoaded extends DosenState {
  final List<LokasiModel> lokasi;
  const DosenLoaded({required this.lokasi});

  @override
  List<Object> get props => [lokasi];
}

class DosenGetPdf extends DosenState {
  final String url;
  const DosenGetPdf({required this.url});

  @override
  List<Object> get props => [url];
}

class DosenFailure extends DosenState {
  final String message;
  const DosenFailure({required this.message});

  @override
  List<Object> get props => [message];
}
