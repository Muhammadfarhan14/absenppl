import 'package:bloc/bloc.dart';

class TextfieldCubit extends Cubit<bool> {
  TextfieldCubit() : super(false);

  void checkTextfield(String value) {
    if (value == '') {
      emit(false);
    } else {
      emit(true);
    }
  }

  void initial() => emit(true);
}
