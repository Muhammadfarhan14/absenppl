import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simor/shared/themes.dart';

import '../../cubit/auth_cubit/auth_cubit.dart';
import '../../cubit/check_days_cubit/check_days_cubit.dart';
import '../../cubit/pembimbing_cubit/pembimbing_cubit.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    navigateToLoginPage();
  }

  Future<void> navigateToLoginPage() async {
    final authCubit = context.read<AuthCubit>();
    final checkDays = context.read<CheckDaysCubit>();

    final role = await authCubit.getRole();
    Future.delayed(const Duration(seconds: 2), () {
      if (role == 'mahasiswa') {
        authCubit.getDataMahasiswa();
        checkDays.checkDaysMahasiswa();
      } else if (role == 'pembimbing_lapangan') {
        authCubit.getDataPembimbing();
        checkDays.checkDaysPembimbing();
      } else if (role == 'dosen_pembimbing') {
        authCubit.getDataDosen();
        checkDays.checkDaysDosen();
      } else {
        // ignore: use_build_context_synchronously
        context.read<AuthCubit>().initial();
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pembimbingCubit = context.read<PembimbingCubit>();
    return Scaffold(
      body: BlocListener<CheckDaysCubit, CheckDaysState>(
        listener: (context, state) {
          if (state is CheckDayPembimbing) {
            if (state.days == true) {
              pembimbingCubit.getMahasiswaPenilaian();
              Navigator.pushReplacementNamed(context, '/penilaian-Pembimbing');
            } else {
              pembimbingCubit.getMahasiswa();
              Navigator.pushReplacementNamed(context, '/home-pembimbing');
            }
          }
          if (state is CheckDayMahasiswa) {
            if (state.days == true) {
              Navigator.pushReplacementNamed(context, '/lampiran-kegiatan');
            } else {
              Navigator.pushNamed(
                context,
                '/info-scan',
                arguments: {
                  'title': 'Datang',
                  'bg': 'bg_scan_1.svg',
                  'card': 'bg_scan_In.svg',
                  'type': true,
                },
              );
            }
          }
          if (state is CheckDayDosen) {
            if (state.days == true) {
              Navigator.pushReplacementNamed(context, '/akhir-ppl');
            } else {
              Navigator.pushReplacementNamed(context, '/home-dosen');
            }
          }
        },
        child: Stack(
          children: [
            Image.asset(
              "assets/images/backgorund.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SiMor',
                      style: TextStyle(
                        fontSize: 65.sp,
                        fontWeight: FontWeight.w600,
                        color: kWhiteColor,
                      ),
                      textScaleFactor: 1.0,
                    ),
                    Text(
                      'Sistem Informasi Monitoring',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                        color: kWhiteColor,
                      ),
                      textScaleFactor: 1.0,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
