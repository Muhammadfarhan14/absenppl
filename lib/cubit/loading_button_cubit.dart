import 'package:bloc/bloc.dart';

class LodingButtonCubit extends Cubit<bool> {
  LodingButtonCubit() : super(false);

  void toggleLoading() => emit(!state);

  void toggleInit() => emit(false);
}
