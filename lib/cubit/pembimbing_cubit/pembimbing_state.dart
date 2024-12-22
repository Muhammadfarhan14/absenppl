part of 'pembimbing_cubit.dart';

abstract class PembimbingState extends Equatable {
  const PembimbingState();

  @override
  List<Object> get props => [];
}

class PembimbingInitial extends PembimbingState {}

class PembimbingLoading extends PembimbingState {}

class PembimbingLoaded extends PembimbingState {
  final List<CekMhs> pembimbing;
  const PembimbingLoaded(this.pembimbing);

  @override
  List<Object> get props => [pembimbing];
}

class PembimbingFailure extends PembimbingState {
  final String message;
  const PembimbingFailure(this.message);

  @override
  List<Object> get props => [message];
}

class PembimbingCekMhs extends PembimbingState {
  final CekMhs mhs;
  const PembimbingCekMhs(this.mhs);

  @override
  List<Object> get props => [mhs];
}

class PembimbingPenilaian extends PembimbingState {
  final List<PenilaianModel> mhs;
  const PembimbingPenilaian(this.mhs);

  @override
  List<Object> get props => [mhs];
}
