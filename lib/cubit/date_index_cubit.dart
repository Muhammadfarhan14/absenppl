import 'package:bloc/bloc.dart';

class DateFilterCubit extends Cubit<int> {
  DateFilterCubit() : super(0);

  void setDate(int index) => emit(index);
}
