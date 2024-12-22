import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simor/cubit/mahasiswa_cubit/mahasiswa_cubit.dart';
import 'package:simor/cubit/texfield_cubit.dart';
import 'package:simor/shared/themes.dart';

import '../../widgets/costume_dialog.dart';

class KendalaMahasiswa extends StatefulWidget {
  const KendalaMahasiswa({super.key});

  @override
  State<KendalaMahasiswa> createState() => _KendalaMahasiswaState();
}

class _KendalaMahasiswaState extends State<KendalaMahasiswa> {
  @override
  void initState() {
    super.initState();
    context.read<MahasiswaCubit>().cekKendala();
  }

  @override
  Widget build(BuildContext context) {
    final kendalaCubit = context.read<MahasiswaCubit>();
    final textFieldcCubit = context.read<TextfieldCubit>();
    TextEditingController kendalaC = TextEditingController();
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.h),
        child: Container(
          height: 130.h,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/images/backgorund.png"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.w)),
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home-mahasiswa',
                      (route) => false,
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.white,
                  ),
                ),
                Image.asset(
                  "assets/images/logo.png",
                  height: 40.h,
                  width: 180.w,
                  fit: BoxFit.cover,
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kendala:',
                  style: blackTextStyle.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: kTextInfoColor,
                  ),
                  textScaleFactor: 1,
                ),
                BlocBuilder<MahasiswaCubit, MahasiswaState>(
                  builder: (context, state) {
                    if (state is MahasiswaGetKendala) {
                      final data = state.kendala;
                      final isAccepted = data.status != 0;
                      return Container(
                        height: 24.h,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          color: isAccepted ? kGreenColor : kSecondColor,
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/clock.svg",
                              height: 10.r,
                              width: 10.r,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              isAccepted ? 'Diterima' : 'Belum diterima',
                              style: whiteTextStyle.copyWith(fontSize: 10.sp),
                              textScaleFactor: 1,
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
            BlocConsumer<MahasiswaCubit, MahasiswaState>(
              listener: (context, state) {
                if (state is MahasiswaGetKendala) {
                  kendalaC.text = state.kendala.deskripsi;
                }
              },
              builder: (context, state) {
                if (state is MahasiswaGetKendala) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: TextFormField(
                      controller: kendalaC,
                      maxLines: 7,
                      cursorColor: kBlackColor,
                      readOnly: true,
                      style: TextStyle(color: kGreyColor.withOpacity(0.6)),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide(
                            color: kGreyColor.withOpacity(0.6),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide(
                            color: kGreyColor.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: TextFormField(
                        controller: kendalaC,
                        cursorColor: kBlackColor,
                        style: const TextStyle(color: kBlackColor),
                        keyboardType: TextInputType.multiline,
                        maxLines: 8,
                        decoration: InputDecoration(
                          hintText: 'Deskripsikan Rencana Kegiatanmu Hari Ini',
                          hintStyle: TextStyle(
                            color: kGreyColor.withOpacity(0.4),
                            fontStyle: FontStyle.italic,
                            fontSize: 12.sp,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide: const BorderSide(
                              color: kTextInfoColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide: const BorderSide(
                              color: kTextInfoColor,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide: const BorderSide(color: kRedColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide: const BorderSide(color: kRedColor),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 6.h,
                        bottom: 10.h,
                        left: 10.w,
                      ),
                      child: BlocBuilder<TextfieldCubit, bool>(
                        builder: (context, state) {
                          return Text(
                            state ? '' : 'Masukkan Kendala',
                            style: whiteTextStyle.copyWith(color: kRedColor),
                          );
                        },
                      ),
                    )
                  ],
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                BlocBuilder<MahasiswaCubit, MahasiswaState>(
                  builder: (context, state) {
                    if (state is MahasiswaGetKendala) {
                      return Container();
                    }
                    return Container(
                      height: 40.h,
                      width: (MediaQuery.of(context).size.width / 2.6),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: kPrimaryColor),
                      ),
                      child: Material(
                        color: kTransparantColor,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8.w),
                          onTap: () {
                            textFieldcCubit.checkTextfield(kendalaC.text);
                            if (textFieldcCubit.state) {
                              kendalaCubit.kirimKendala(kendalaC.text);
                              kendalaCubit.cekKendala();
                              showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return const Dialoginfo(
                                    height: 320,
                                    title:
                                        'Kendala kegiatan\nberhasil di simpan',
                                  );
                                },
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Kirim',
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                ),
                                textScaleFactor: 1,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
