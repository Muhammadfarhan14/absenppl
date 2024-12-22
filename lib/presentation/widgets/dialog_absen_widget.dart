import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simor/cubit/pembimbing_cubit/pembimbing_cubit.dart';
import 'package:simor/shared/themes.dart';

Future<void> dialogAbsen(
  BuildContext context,
  String status,
  String gambar,
  String nama,
  String nim,
  String idPpl,
) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      final pembimbingCubit = context.read<PembimbingCubit>();
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        content: Container(
          height: MediaQuery.of(context).size.height * 0.62,
          width: 320.w,
          padding: EdgeInsets.all(20.r),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Verifikasi Data',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: semiBold,
                      ),
                      textScaleFactor: 1.0,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        "assets/icons/back.svg",
                        width: 12.w,
                        height: 12.h,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    const Icon(
                      Icons.error,
                      color: kRedColor,
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      'Pastikan Foto Pada Kartu Sesuai Dengan\nWajah Asli Mahasiswa',
                      style: TextStyle(
                        color: kRedColor,
                        fontSize: 11.sp,
                        height: 1.6,
                      ),
                      textScaleFactor: 1.0,
                    ),
                  ],
                ),
                Container(
                  height: 146.r,
                  width: 146.r,
                  padding: EdgeInsets.all(2.r),
                  margin: EdgeInsets.only(top: 24.h, bottom: 8.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor, width: 5.w),
                    borderRadius: BorderRadius.circular(146.h / 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(146.w / 2),
                    child: Image.network(gambar),
                  ),
                ),
                Text(
                  nama,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.0,
                ),
                SizedBox(height: 2.h),
                Text(
                  nim,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: kPrimaryColor,
                    fontStyle: FontStyle.italic,
                  ),
                  textScaleFactor: 1.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  margin: EdgeInsets.only(top: 18.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          status == 'Datang'
                              ? {
                                  pembimbingCubit.konfirmasiDatang(idPpl),
                                  Navigator.pop(context),
                                }
                              : {
                                  pembimbingCubit.konfirmasiPulang(idPpl),
                                  Navigator.pop(context),
                                };
                        },
                        borderRadius: BorderRadius.circular(8.w),
                        child: SizedBox(
                          height: 40.h,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              status == 'Datang'
                                  ? 'Konfirmasi Kehadiran'
                                  : 'Logout Mahasiswa',
                              style: whiteTextStyle.copyWith(
                                fontWeight: semiBold,
                                fontSize: 12.sp,
                              ),
                              textScaleFactor: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(8.w),
                        child: SizedBox(
                          height: 40.h,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Batal',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                              textScaleFactor: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
