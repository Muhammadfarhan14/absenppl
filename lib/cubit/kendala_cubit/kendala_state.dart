part of 'kendala_cubit.dart';

abstract class KendalaState extends Equatable {
  const KendalaState();

  @override
  List<Object> get props => [];
}

class KendalaInitial extends KendalaState {}

class KendalaLoading extends KendalaState {}

class KendalaLoaded extends KendalaState {
  final List<Kendala2Model> kendala;
  const KendalaLoaded({required this.kendala});

  @override
  List<Object> get props => [kendala];
}

class KendalaFailure extends KendalaState {
  final String message;
  const KendalaFailure({required this.message});

  @override
  List<Object> get props => [message];
}
