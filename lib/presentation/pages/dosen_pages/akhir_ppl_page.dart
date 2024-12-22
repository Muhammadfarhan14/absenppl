// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simor/cubit/auth_cubit/auth_cubit.dart';
import 'package:simor/cubit/dosen_cubit/dosen_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/themes.dart';

class AkhirPplPage extends StatelessWidget {
  const AkhirPplPage({super.key});

  @override
  Widget build(BuildContext context) {
    void openUrl(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        debugPrint('Could not launch $url');
      }
    }

    return Scaffold(
      body: BlocListener<DosenCubit, DosenState>(
        listener: (context, state) {
          if (state is DosenGetPdf) {
            var url = state.url;
            openUrl(url);
          }
          if (state is DosenFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Penilaian Belum Lengkap'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Column(
          children: [
            Stack(
              children: [
                SvgPicture.asset(
                  'assets/images/img_appbar_dosen.svg',
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                  top: 50.h,
                  left: 14.w,
                  right: 14.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is AuthDosen) {
                            return Container(
                              height: 45.r,
                              width: 45.r,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(10.r),
                                image: DecorationImage(
                                  image: NetworkImage(state.dosenModel.gambar),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 72.h),
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  width: 1.0,
                  color: kGreyColor.withOpacity(0.2),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    child: SvgPicture.asset(
                      'assets/icons/succes_orange.svg',
                      width: 140.r,
                      height: 140.r,
                    ),
                  ),
                  Text(
                    'PPL telah berakhir!',
                    style: blackTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: semiBold,
                    ),
                    textScaleFactor: 1,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Silahkan download rekapitulasi kegiatan!',
                    textAlign: TextAlign.center,
                    style: blackTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: light,
                    ),
                    textScaleFactor: 1,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(8.w),
                      border: Border.all(color: kSecondColor),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          context.read<DosenCubit>().getPdf();
                        },
                        borderRadius: BorderRadius.circular(8.w),
                        child: SizedBox(
                          height: 44.h,
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/cloud_download.svg',
                                  color: kSecondColor,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Unduh Lampiran Kegiatan',
                                  style: TextStyle(
                                    color: kSecondColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.sp,
                                  ),
                                  textScaleFactor: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
