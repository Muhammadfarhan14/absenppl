import 'package:bloc/bloc.dart';
import 'package:simor/models/penilaian_model.dart';

class PickMhs extends Cubit<PenilaianModel> {
  PickMhs()
      : super(PenilaianModel(
          id: -1,
          nama: 'Mahasiswa',
          nim: "*******",
          gambar:
              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
          status: 0,
          lokasi: Lokasi(
            id: -1,
            gambar: '',
            nama: '',
            alamat: '',
          ),
        ));

  void pickMhs(PenilaianModel model) => emit(model);

  void initial() => emit(PenilaianModel(
        id: -1,
        nama: 'Mahasiswa',
        nim: "*******",
        gambar:
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        status: 0,
        lokasi: Lokasi(
          id: -1,
          gambar: '',
          nama: '',
          alamat: '',
        ),
      ));
}
