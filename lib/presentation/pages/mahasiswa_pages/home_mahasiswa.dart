import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simor/cubit/auth_cubit/auth_cubit.dart';
import 'package:simor/cubit/come_out_cubit/come_out_cubit.dart';
import 'package:simor/cubit/mahasiswa_cubit/mahasiswa_cubit.dart';
import 'package:simor/cubit/texfield_cubit.dart';
import 'package:simor/cubit/time_cubit.dart';
import 'package:simor/shared/themes.dart';
import 'package:simor/presentation/widgets/costume_button.dart';

import '../../widgets/costume_card.dart';

class Homemahasiswa extends StatefulWidget {
  const Homemahasiswa({super.key});

  @override
  State<Homemahasiswa> createState() => _HomemahasiswaState();
}

class _HomemahasiswaState extends State<Homemahasiswa>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1250),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final timeCubit = context.read<TimeCubit>();
    final mhsCubit = context.read<MahasiswaCubit>();
    final authCubit = context.read<AuthCubit>();
    return Scaffold(
      body: NotificationListener(
        onNotification: (notification) {
          if (notification is OverscrollIndicatorNotification) {
            notification.disallowIndicator();
          }
          return false;
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: 780.h,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/backgorund.png",
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
                Positioned.fill(
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 634.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.w),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            SizedBox(height: 80.h),
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                if (state is AuthMahsiswa) {
                                  final data = state.mahasiswaModel;
                                  return Column(
                                    children: [
                                      SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(-1, 0),
                                          end: const Offset(0, 0),
                                        ).animate(_animation),
                                        child: Infoprofile(
                                          title: 'Nama Mahasiswa:',
                                          value: data.nama,
                                        ),
                                      ),
                                      SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(-2, 0),
                                          end: const Offset(0, 0),
                                        ).animate(_animation),
                                        child: Infoprofile(
                                          title: 'Nim:',
                                          value: data.nim,
                                        ),
                                      ),
                                      SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(-3, 0),
                                          end: const Offset(0, 0),
                                        ).animate(_animation),
                                        child: Infoprofile(
                                          title: 'Tempat PPL:',
                                          value: data.lokasi,
                                        ),
                                      ),
                                      SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(-4, 0),
                                          end: const Offset(0, 0),
                                        ).animate(_animation),
                                        child: Infoprofile(
                                          title: 'Dosen Pembimbing:',
                                          value: data.pembimbingLapangan,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return Container();
                              },
                            ),
                            SizedBox(height: 14.h),
                            BlocBuilder<ComeOutCubit, ComeOutState>(
                              builder: (context, state) {
                                if (state is ComeOutDatang) {
                                  final data = state.datangModel.keterangan;
                                  final set = data == 'null';
                                  return Column(
                                    children: [
                                      set
                                          ? Costumebutton(
                                              title: 'Datang',
                                              ontap: () => Navigator.pushNamed(
                                                context,
                                                '/take-picture',
                                                arguments: {
                                                  'type': true,
                                                  'inOut': true
                                                },
                                              ),
                                            )
                                          : Costumebutton(
                                              title: 'Datang',
                                              colorButton: kDisableColor,
                                              ontap: () {},
                                            ),
                                      SizedBox(height: 10.h),
                                      !set
                                          ? Costumebutton(
                                              title: 'Kegiatan',
                                              ontap: () {
                                                timeCubit.initial();
                                                mhsCubit.getKegiatan(
                                                  authCubit.mhsId,
                                                );
                                                Navigator.pushNamed(
                                                  context,
                                                  '/kegiatan-mahasiswa',
                                                );
                                              },
                                            )
                                          : Costumebutton(
                                              title: 'Kegiatan',
                                              colorButton: kDisableColor,
                                              ontap: () {},
                                            ),
                                      SizedBox(height: 10.h),
                                      !set
                                          ? Costumebutton(
                                              title: 'Kendala',
                                              ontap: () {
                                                context
                                                    .read<TextfieldCubit>()
                                                    .initial();
                                                Navigator.pushNamed(
                                                  context,
                                                  '/kendala-mahasiswa',
                                                );
                                              },
                                            )
                                          : Costumebutton(
                                              title: 'Kendala',
                                              colorButton: kDisableColor,
                                              ontap: () {},
                                            ),
                                      SizedBox(height: 10.h),
                                      !set
                                          ? Costumebutton(
                                              title: 'Pulang',
                                              ontap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  '/take-picture',
                                                  arguments: {'inOut': false},
                                                );
                                              },
                                            )
                                          : Costumebutton(
                                              title: 'Pulang',
                                              colorButton: kDisableColor,
                                              ontap: () {},
                                            ),
                                    ],
                                  );
                                }
                                return Container();
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 80.h,
                  left: 110.w,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthMahsiswa) {
                        final data = state.mahasiswaModel;
                        return Container(
                          width: 139.r,
                          height: 139.r,
                          padding: EdgeInsets.all(5.r),
                          decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(139.r / 2),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(139.r / 2),
                            child: Image.network(data.gambar),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
