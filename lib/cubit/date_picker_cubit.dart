import 'package:bloc/bloc.dart';

import '../presentation/utils/date_formatter.dart';

class DatePickerCubit extends Cubit<List<String>> {
  DatePickerCubit() : super(getDaysOfMonth(DateTime.now().month));

  void setDate(int month) => emit(getDaysOfMonth(month));
}
