import 'package:bloc/bloc.dart';

class MonthCubit extends Cubit<String> {
  MonthCubit() : super('');

  void setMonth(String index) => emit(index);
}
