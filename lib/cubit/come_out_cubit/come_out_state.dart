part of 'come_out_cubit.dart';

abstract class ComeOutState extends Equatable {
  const ComeOutState();

  @override
  List<Object> get props => [];
}

class ComeOutInitial extends ComeOutState {}

class ComeOutLoading extends ComeOutState {}

class ComeOutFailure extends ComeOutState {}

class ComeOutDatang extends ComeOutState {
  final DatangModel datangModel;

  const ComeOutDatang({required this.datangModel});
}

class ComeOutPulang extends ComeOutState {
  final String status;
  const ComeOutPulang({required this.status});

  @override
  List<Object> get props => [status];
}
