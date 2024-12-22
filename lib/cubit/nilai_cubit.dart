import 'package:bloc/bloc.dart';

class NilaiCubit extends Cubit<List<int>> {
  NilaiCubit() : super([4, 4, 4, 4, 4, 4]);

  void klikNilai(int nilai, int index) {
    emit(List.from(state)..[index] = nilai);
  }

  void initial() {
    emit([4, 4, 4, 4, 4, 4]);
  }
}
