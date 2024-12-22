import 'package:bloc/bloc.dart';

class ObscureTextCubit extends Cubit<bool> {
  ObscureTextCubit() : super(true);

  void toggleObscure() => emit(!state);
}
