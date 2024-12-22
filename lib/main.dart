import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simor/cubit/auth_cubit/auth_cubit.dart';
import 'package:simor/cubit/camera_cubit/camera_cubit.dart';
import 'package:simor/cubit/check_days_cubit/check_days_cubit.dart';
import 'package:simor/cubit/come_out_cubit/come_out_cubit.dart';
import 'package:simor/cubit/date_index_cubit.dart';
import 'package:simor/cubit/date_picker_cubit.dart';
import 'package:simor/cubit/dosen_cubit/dosen_cubit.dart';
import 'package:simor/cubit/kendala_cubit/kendala_cubit.dart';
import 'package:simor/cubit/lokasi_cubit/lokasi_cubit.dart';
import 'package:simor/cubit/mahasiswa_cubit/mahasiswa_cubit.dart';
import 'package:simor/cubit/mhs_pick_cubit.dart';
import 'package:simor/cubit/month_index_cubit.dart';
import 'package:simor/cubit/nilai_cubit.dart';
import 'package:simor/cubit/obscure_text_cubit.dart';
import 'package:simor/cubit/pembimbing_cubit/pembimbing_cubit.dart';
import 'package:simor/cubit/texfield_cubit.dart';
import 'package:simor/cubit/time_cubit.dart';
import 'package:simor/services/auth_repository.dart';
import 'package:simor/services/dosen_repository.dart';
import 'package:simor/services/mahasiswa_repository.dart';
import 'package:simor/services/pebimbing_repository.dart';
import 'package:simor/services/status_repository.dart';
import 'package:simor/presentation/pages/dosen_pages/akhir_ppl_page.dart';
import 'package:simor/presentation/pages/dosen_pages/home_dosen_page.dart';
import 'package:simor/presentation/pages/dosen_pages/lokasi_ppl_page.dart';
import 'package:simor/presentation/pages/login_page.dart';
import 'package:simor/presentation/pages/mahasiswa_pages/home_mahasiswa.dart';
import 'package:simor/presentation/pages/mahasiswa_pages/info_scan_card_page.dart';
import 'package:simor/presentation/pages/mahasiswa_pages/kegiatan_page.dart';
import 'package:simor/presentation/pages/mahasiswa_pages/kendala_page.dart';
import 'package:simor/presentation/pages/mahasiswa_pages/lampiran_kegiatan.dart';
import 'package:simor/presentation/pages/mahasiswa_pages/take_picture_page.dart';
import 'package:simor/presentation/pages/pembimbing_pages/choice_scan.dart';
import 'package:simor/presentation/pages/pembimbing_pages/home_pembimbing.dart';
import 'package:simor/presentation/pages/pembimbing_pages/penilaian_mahasiswa.dart';
import 'package:simor/presentation/pages/pembimbing_pages/scan_pembimbing.dart';
import 'package:simor/presentation/pages/splash_screen.dart';

import 'cubit/loading_button_cubit.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initializeDateFormatting();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LodingButtonCubit()),
          BlocProvider(create: (context) => ObscureTextCubit()),
          BlocProvider(create: (context) => CameraCubit()),
          BlocProvider(create: (context) => TimeCubit()),
          BlocProvider(create: (context) => DateFilterCubit()),
          BlocProvider(create: (context) => TextfieldCubit()),
          BlocProvider(create: (context) => MonthCubit()),
          BlocProvider(create: (context) => PickMhs()),
          BlocProvider(create: (context) => NilaiCubit()),
          BlocProvider(create: (context) => DatePickerCubit()),
          BlocProvider(
            create: (context) => AuthCubit(
              AuthRepository(
                client: http.Client(),
                sharedPreferences: prefs,
              ),
            ),
          ),
          BlocProvider(
            create: (context) => ComeOutCubit(
              StatusRepository(
                client: http.Client(),
                sharedPreferences: prefs,
              ),
            ),
          ),
          BlocProvider(
            create: (context) => MahasiswaCubit(
              MahasiswaRepository(
                client: http.Client(),
                sharedPreferences: prefs,
              ),
            ),
          ),
          BlocProvider(
            create: (context) => PembimbingCubit(
              PembimbingRepository(
                client: http.Client(),
                sharedPreferences: prefs,
              ),
            ),
          ),
          BlocProvider(
            create: (context) => KendalaCubit(
              dosenRepository: DosenRepository(
                client: http.Client(),
                sharedPreferences: prefs,
              ),
            ),
          ),
          BlocProvider(
            create: (context) => DosenCubit(
              dosenRepository: DosenRepository(
                client: http.Client(),
                sharedPreferences: prefs,
              ),
            ),
          ),
          BlocProvider(
            create: (context) => LokasiCubit(
              dosenRepository: DosenRepository(
                client: http.Client(),
                sharedPreferences: prefs,
              ),
            ),
          ),
          BlocProvider(
            create: (context) => CheckDaysCubit(
              pembimbingRepository: PembimbingRepository(
                client: http.Client(),
                sharedPreferences: prefs,
              ),
              mahasiswaRepository: MahasiswaRepository(
                client: http.Client(),
                sharedPreferences: prefs,
              ),
              dosenrepository: DosenRepository(
                client: http.Client(),
                sharedPreferences: prefs,
              ),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'SiMonitoring',
          theme: ThemeData(fontFamily: 'Montserrat'),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const Splashscreen(),
            '/login': (context) => const Loginpage(),
            '/home-mahasiswa': (context) => const Homemahasiswa(),
            '/info-scan': (context) => const InfoScan(),
            '/take-picture': (context) => const CameraPage(),
            '/kegiatan-mahasiswa': (context) => const Kegiatanmahasiswa(),
            '/kendala-mahasiswa': (context) => const KendalaMahasiswa(),
            '/lampiran-kegiatan': (context) => const LampiranKegiatan(),
            '/home-pembimbing': (context) => const Homepembimbing(),
            '/choice-scan': (context) => const ChoiceScan(),
            '/scan-pembimbing': (context) => const ScanPembimbing(),
            '/penilaian-Pembimbing': (context) => const PenilaianMahasiswa(),
            '/home-dosen': (context) => const HomeDosenPage(),
            '/lokasi-ppl': (context) => const LokasiPplPage(),
            '/akhir-ppl': (context) => const AkhirPplPage(),
          },
        ),
      ),
    );
  }
}