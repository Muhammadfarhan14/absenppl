import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simor/cubit/auth_cubit/auth_cubit.dart';
import 'package:simor/cubit/date_picker_cubit.dart';
import 'package:simor/cubit/dosen_cubit/dosen_cubit.dart';
import 'package:simor/cubit/kendala_cubit/kendala_cubit.dart';
import 'package:simor/cubit/lokasi_cubit/lokasi_cubit.dart';
import 'package:simor/cubit/month_index_cubit.dart';
import 'package:simor/shared/themes.dart';
import 'package:simor/presentation/utils/date_formatter.dart';
import 'package:simor/presentation/widgets/costume_button.dart';

import '../../../cubit/date_index_cubit.dart';

class HomeDosenPage extends StatefulWidget {
  const HomeDosenPage({super.key});

  @override
  State<HomeDosenPage> createState() => _HomeDosenPageState();
}

class _HomeDosenPageState extends State<HomeDosenPage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    context.read<KendalaCubit>().getKendala();
    context.read<DosenCubit>().getLokasi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SvgPicture.asset(
                'assets/images/img_appbar_dosen.svg',
                width: MediaQuery.of(context).size.width,
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthDosen) {
                    return Positioned(
                      top: 55.h,
                      left: 18.w,
                      right: 18.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: light,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                state.dosenModel.nama,
                                style: whiteTextStyle.copyWith(
                                  fontWeight: semiBold,
                                  fontSize: 16.sp,
                                ),
                                textScaleFactor: 1,
                              ),
                            ],
                          ),
                          Container(
                            height: 44.r,
                            width: 44.r,
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(10.r),
                              image: DecorationImage(
                                image: NetworkImage(state.dosenModel.gambar),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
          BlocBuilder<KendalaCubit, KendalaState>(
            builder: (context, state) {
              if (state is KendalaLoading) {
                return Container(
                  height: 65.h,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                );
              }
              if (state is KendalaLoaded) {
                return Container(
                  height: state.kendala.isEmpty
                      ? 0
                      : state.kendala.length == 1
                          ? 65.h
                          : 130.h,
                  margin: EdgeInsets.only(top: 14.h, bottom: 6.h),
                  width: double.infinity,
                  child: NotificationListener(
                    onNotification: (notification) {
                      if (notification is OverscrollIndicatorNotification) {
                        notification.disallowIndicator();
                      }
                      return false;
                    },
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final data = state.kendala[index];
                        if (data.kendala.status == 0) {
                          return GestureDetector(
                            onTap: () => dialogKendala(
                              context,
                              data.alamat,
                              data.kendala.deskripsi,
                              '${data.kendala.id}',
                            ),
                            child: CardKendala(
                              fade: false,
                              alamat: data.alamat,
                            ),
                          );
                        }
                        return Container();
                      },
                      padding: EdgeInsets.zero,
                      separatorBuilder: (_, index) => SizedBox(height: 12.h),
                      itemCount: state.kendala.length,
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
          Container(
            margin: EdgeInsets.only(left: 16.w, bottom: 12.h),
            child: Text(
              'Lokasi PPL',
              textScaleFactor: 1,
              style: blackTextStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: medium,
              ),
            ),
          ),
          BlocBuilder<DosenCubit, DosenState>(
            builder: (context, state) {
              if (state is DosenLoaded) {
                return Expanded(
                  child: NotificationListener(
                    onNotification: (notification) {
                      if (notification is OverscrollIndicatorNotification) {
                        notification.disallowIndicator();
                      }
                      return false;
                    },
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final data = state.lokasi[index];
                        return cardPpl(
                          context,
                          data.nama,
                          data.alamat,
                          data.gambar,
                          data.pesentasiKehadiran,
                          index,
                          '${data.id}',
                        );
                      },
                      separatorBuilder: (_, index) => SizedBox(height: 12.h),
                      padding: EdgeInsets.only(
                        right: 16.w,
                        left: 16.w,
                        bottom: 16.h,
                        top: 4.h,
                      ),
                      itemCount: state.lokasi.length,
                    ),
                  ),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }

  Future<void> dialogKendala(
    BuildContext context,
    final String alamat,
    final String kendala,
    final String id,
  ) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          contentPadding: EdgeInsets.only(top: 16.h),
          insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
          content: Container(
            height: 340.h,
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardKendala(fade: true, alamat: alamat),
                const SizedBox(height: 12.0),
                Container(
                  margin: EdgeInsets.only(left: 16.w, bottom: 12.h),
                  child: Text(
                    'Kendala:',
                    textScaleFactor: 1,
                    style: blackTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: regular,
                    ),
                  ),
                ),
                Container(
                  height: 100.h,
                  width: double.infinity,
                  padding: EdgeInsets.all(16.r),
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: kBlackColor),
                  ),
                  child: Text(
                    kendala,
                    textScaleFactor: 1,
                    maxLines: 2,
                    style: blackTextStyle.copyWith(
                      fontSize: 12.sp,
                      fontWeight: regular,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 76.w),
                  child: Costumebutton(
                    title: 'Terima',
                    ontap: () {
                      context.read<KendalaCubit>().accKendala(id);
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }

  GestureDetector cardPpl(
    BuildContext context,
    String nama,
    String alamat,
    String imgUrl,
    double presentase,
    int index,
    String id,
  ) {
    return GestureDetector(
      onTap: () {
        context
            .read<LokasiCubit>()
            .getMahasiswaByLokasi(getFormattedDateNow(), id);
        context.read<DateFilterCubit>().setDate(getCurrentDate() - 1);
        context.read<MonthCubit>().setMonth(getMonthNow());
        context
            .read<DatePickerCubit>()
            .setDate(int.parse(context.read<MonthCubit>().state));
        Navigator.pushNamed(
          context,
          '/lokasi-ppl',
          arguments: {'data': index, 'id': id},
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 3,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 64.r,
              width: 64.r,
              margin: EdgeInsets.only(right: 20.w),
              decoration: BoxDecoration(
                border: Border.all(color: kPrimaryColor, width: 2),
                borderRadius: BorderRadius.circular(64.h / 2),
                image: DecorationImage(
                  image: NetworkImage(imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 12.sp,
                  ),
                  textScaleFactor: 1,
                ),
                Container(
                  width: 200.w,
                  margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
                  child: Text(
                    alamat,
                    overflow: TextOverflow.fade,
                    textScaleFactor: 1,
                    style: blackTextStyle.copyWith(
                      fontWeight: light,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
                Container(
                  height: 0.5,
                  width: 200.w,
                  margin: EdgeInsets.only(bottom: 8.h),
                  color: kBlackColor.withOpacity(0.2),
                ),
                Row(
                  children: [
                    Text(
                      'Presentase Kehadiran:',
                      style: blackTextStyle.copyWith(fontSize: 12.sp),
                      textScaleFactor: 1,
                    ),
                    Container(
                      height: 16.h,
                      width: 32.w,
                      margin: EdgeInsets.only(left: 9.w),
                      padding: EdgeInsets.all(1.r),
                      decoration: BoxDecoration(
                        color: kSecondColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Center(
                        child: Text(
                          '${presentase.toInt()}%',
                          style: orangeTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CardKendala extends StatelessWidget {
  const CardKendala({
    super.key,
    required this.fade,
    required this.alamat,
  });

  final bool fade;
  final String alamat;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: kYellowColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kRedColor),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/error.svg',
            width: 24.r,
            height: 24.r,
            color: kRedColor,
          ),
          SizedBox(width: 14.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Info Kendala',
                style: redTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 12.sp,
                ),
                textScaleFactor: 1,
              ),
              SizedBox(height: 6.h),
              SizedBox(
                width: 220.w,
                child: Text(
                  alamat,
                  style: redTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 12.sp,
                  ),
                  textScaleFactor: 1,
                  overflow: fade ? null : TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
