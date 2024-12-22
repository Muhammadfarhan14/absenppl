part of 'check_days_cubit.dart';

abstract class CheckDaysState extends Equatable {
  const CheckDaysState();

  @override
  List<Object> get props => [];
}

class CheckDaysInitial extends CheckDaysState {}

class CheckDaysLoading extends CheckDaysState {}

class CheckDayPembimbing extends CheckDaysState {
  final bool days;
  const CheckDayPembimbing({required this.days});

  @override
  List<Object> get props => [days];
}

class CheckDayMahasiswa extends CheckDaysState {
  final bool days;
  const CheckDayMahasiswa({required this.days});

  @override
  List<Object> get props => [days];
}

class CheckDayDosen extends CheckDaysState {
  final bool days;
  const CheckDayDosen({required this.days});

  @override
  List<Object> get props => [days];
}

class CheckDaysFailure extends CheckDaysState {
  final String message;
  const CheckDaysFailure({required this.message});

  @override
  List<Object> get props => [message];
}
