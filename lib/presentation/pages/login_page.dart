import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simor/cubit/check_days_cubit/check_days_cubit.dart';
import 'package:simor/cubit/pembimbing_cubit/pembimbing_cubit.dart';
import 'package:simor/shared/themes.dart';

import '../../cubit/auth_cubit/auth_cubit.dart';
import '../../cubit/loading_button_cubit.dart';
import '../../cubit/obscure_text_cubit.dart';
import '../widgets/form_input_with_title.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> key1 = GlobalKey<FormState>();
  final GlobalKey<FormState> key2 = GlobalKey<FormState>();

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCUbit = context.read<AuthCubit>();
    final pembimbingCubit = context.read<PembimbingCubit>();
    final loadingCubit = context.read<LodingButtonCubit>();
    final checkDays = context.read<CheckDaysCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<CheckDaysCubit, CheckDaysState>(
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
              loadingCubit.toggleInit();
              Navigator.pushReplacementNamed(
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
              loadingCubit.toggleInit();
              Navigator.pushReplacementNamed(context, '/home-dosen');
            }
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/backgorund.png",
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
                SafeArea(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          SizedBox(height: 16.h),
                          Image.asset(
                            "assets/images/logo.png",
                            height: 40.h,
                            width: 180.w,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 56.h),
                          Text(
                            'MONITORING',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 46.sp,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            'PRAKTEK PENGENALAN LAPANGAN',
                            style: whiteTextStyle.copyWith(
                              fontSize: 16.sp,
                              fontWeight: light,
                            ),
                            textScaleFactor: 1,
                          ),
                          SizedBox(height: 48.h),
                          TextfieldMaker(
                            title: 'Username',
                            showIcon: false,
                            controller: usernameController,
                            form: key1,
                          ),
                          SizedBox(height: 16.h),
                          BlocBuilder<ObscureTextCubit, bool>(
                            builder: (context, state) {
                              return TextfieldMaker(
                                title: 'Password',
                                obscure: state,
                                showIcon: true,
                                controller: passwordController,
                                form: key2,
                                icon: state
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              );
                            },
                          ),
                          SizedBox(height: 28.h),
                          Container(
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(8.w),
                            ),
                            child: Material(
                              color: kTransparantColor,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8.w),
                                onTap: () async {
                                  final formOne = key1.currentState!.validate();
                                  final formTwo = key2.currentState!.validate();
                                  if (formOne && formTwo) {
                                    loadingCubit.toggleLoading();
                                    await authCUbit.login(
                                      usernameController.text,
                                      passwordController.text,
                                    );
                                    final role = await authCUbit.getRole();
                                    if (role == 'mahasiswa') {
                                      authCUbit.getDataMahasiswa();
                                      checkDays.checkDaysMahasiswa();
                                    }
                                    if (role == 'pembimbing_lapangan') {
                                      authCUbit.getDataPembimbing();
                                      checkDays.checkDaysPembimbing();
                                    }
                                    if (role == 'dosen_pembimbing') {
                                      authCUbit.getDataDosen();
                                      checkDays.checkDaysDosen();
                                    }
                                    if (role == '') {
                                      // ignore: use_build_context_synchronously
                                      context.read<AuthCubit>().initial();
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Akun Tidak Ditemukan'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: SizedBox(
                                  height: 40.h,
                                  width: double.infinity,
                                  child: BlocBuilder<AuthCubit, AuthState>(
                                    builder: (_, state) {
                                      if (state is AuthLoading) {
                                        return Center(
                                          child: SizedBox(
                                            height: 14.r,
                                            width: 14.r,
                                            child: CircularProgressIndicator(
                                              color: kPrimaryColor,
                                              strokeWidth: 2.5.r,
                                            ),
                                          ),
                                        );
                                      }
                                      return Center(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                          ),
                                          textScaleFactor: 1,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
