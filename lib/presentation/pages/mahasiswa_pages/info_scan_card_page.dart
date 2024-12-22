import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:simor/cubit/come_out_cubit/come_out_cubit.dart';
import 'package:simor/cubit/mahasiswa_cubit/mahasiswa_cubit.dart';
import 'package:simor/shared/themes.dart';
import 'package:simor/presentation/widgets/costume_dialog.dart';

class InfoScan extends StatelessWidget {
  const InfoScan({super.key});

  @override
  Widget build(BuildContext context) {
    final comeOutCubit = context.read<ComeOutCubit>();
    final Map<String, dynamic> item =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<ComeOutCubit, ComeOutState>(
        listener: (context, state) {
          if (state is ComeOutDatang) {
            Navigator.pushNamed(context, '/home-mahasiswa');
          }
          if (state is ComeOutPulang) {
            context.read<MahasiswaCubit>().logoutMahasiswa();
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                Future.delayed(const Duration(milliseconds: 2500), () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                });
                return const Dialoginfo(
                  type: false,
                  height: 390,
                  title:
                      '''Rencana Kegiatan,\ndan Absensi Anda Telah Terkirim.\n\nAnda Akan Logout Otomatis\nSelamat Istirahat!''',
                );
              },
            );
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return LiquidPullToRefresh(
              springAnimationDurationInMilliseconds: 450,
              showChildOpacityTransition: false,
              backgroundColor: kWhiteColor,
              color: kPrimaryColor,
              height: 90.h,
              onRefresh: () => item['type'] == true
                  ? comeOutCubit.checkDatang()
                  : comeOutCubit.checkPulang(),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          "assets/images/${item['bg']}",
                          height: 202.h,
                          fit: BoxFit.fill,
                        ),
                        SafeArea(
                          child: Column(
                            children: [
                              SizedBox(height: 16.h),
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/images/logo.png",
                                  height: 40.h,
                                  width: 180.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 70.h),
                              SvgPicture.asset(
                                'assets/images/${item['card']}',
                                width: 300.w,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(height: 45.h),
                              Text(
                                'Scan Kartu Anda!',
                                style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp,
                                ),
                                textScaleFactor: 1,
                              ),
                              const Spacer(),
                              Image.asset(
                                "assets/images/vector_scan.png",
                                width: 120.r,
                                height: 120.r,
                                fit: BoxFit.fill,
                              ),
                              const Spacer(),
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 60.h,
                                  left: 16.w,
                                  right: 16.w,
                                ),
                                child: Text(
                                  'Silahkan Scan Kartu Anda Pada Perangkat Pembimbing Lapangan ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
