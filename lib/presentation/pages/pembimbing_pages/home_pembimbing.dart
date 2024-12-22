import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simor/cubit/auth_cubit/auth_cubit.dart';
import 'package:simor/cubit/pembimbing_cubit/pembimbing_cubit.dart';
import 'package:simor/shared/themes.dart';
import 'package:simor/presentation/utils/date_formatter.dart';
import 'package:simor/presentation/widgets/costume_button.dart';

import '../../../cubit/loading_button_cubit.dart';

class Homepembimbing extends StatefulWidget {
  const Homepembimbing({super.key});

  @override
  State<Homepembimbing> createState() => _HomepembimbingState();
}

class _HomepembimbingState extends State<Homepembimbing>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    context.read<LodingButtonCubit>().toggleInit();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 40.h,
                  width: 180.w,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(18.r),
        child: Column(
          children: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthPembimbing) {
                  final data = state.pembimbing;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 64.h,
                            height: 64.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(64.h),
                              border: Border.all(
                                color: kPrimaryColor,
                                width: 2.w,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(data.lokasi.gambar),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 22.h),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.lokasi.nama,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                textScaleFactor: 1.0,
                              ),
                              SizedBox(height: 8.h),
                              SizedBox(
                                width: 220.w,
                                child: Text(
                                  data.lokasi.alamat,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textScaleFactor: 1.0,
                                  maxLines: 4,
                                ),
                              ),
                              Container(
                                height: 0.4.h,
                                width: 180.w,
                                margin: EdgeInsets.only(top: 10.h),
                                decoration: BoxDecoration(
                                  color: kBlackColor.withOpacity(0.1),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 22.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MajorMaker(
                            title: 'Dosen Pembimbing',
                            value: data.namaDosenPembimbing,
                          ),
                          Container(
                            height: 24.h,
                            width: 0.4.w,
                            decoration: BoxDecoration(
                              color: kBlackColor.withOpacity(0.1),
                            ),
                          ),
                          MajorMaker(
                            title: 'Pembimbing Lapangan',
                            value: data.namaPembimbingLapangan,
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
            Container(
              height: 40.h,
              width: double.infinity,
              margin: EdgeInsets.only(top: 26.h),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  dateFromat(),
                  style: whiteTextStyle.copyWith(
                    fontSize: 13.sp,
                    fontWeight: medium,
                  ),
                  textScaleFactor: 1,
                ),
              ),
            ),
            BlocBuilder<PembimbingCubit, PembimbingState>(
              builder: (context, state) {
                if (state is PembimbingLoaded) {
                  return Expanded(
                    child: NotificationListener(
                      onNotification: (notification) {
                        if (notification is OverscrollIndicatorNotification) {
                          notification.disallowIndicator();
                        }
                        return false;
                      },
                      child: ListView.separated(
                        padding: EdgeInsets.only(top: 6.h),
                        itemBuilder: (context, index) {
                          final data = state.pembimbing[index];
                          return FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(0, (index.toDouble() + 1)),
                                end: const Offset(0, 0),
                              ).animate(_animation),
                              child: CardMahasiswa(
                                nama: data.nama,
                                nim: data.nim,
                                datang: data.keteranganDatang,
                                pulang: data.keteranganPulang,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, index) => const SizedBox(),
                        itemCount: state.pembimbing.length,
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
      bottomNavigationBar: Container(
        width: 320.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(
              color: kGreyColor.withOpacity(0.5),
              blurRadius: 2,
              blurStyle: BlurStyle.normal,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.h)),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: Costumebutton(
              title: 'Scan Kartu NFC Mahasiswa',
              ontap: () => Navigator.pushNamed(context, '/choice-scan'),
            ),
          ),
        ),
      ),
    );
  }
}

class CardMahasiswa extends StatelessWidget {
  const CardMahasiswa({
    super.key,
    required this.nama,
    required this.nim,
    required this.datang,
    required this.pulang,
  });

  final String nama, nim;
  final String datang, pulang;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 6.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200.w,
                    child: Text(
                      nama,
                      style: TextStyle(
                        fontWeight: medium,
                        fontSize: 14.sp,
                      ),
                      textScaleFactor: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    nim,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: light,
                      fontStyle: FontStyle.italic,
                    ),
                    textScaleFactor: 1,
                  ),
                ],
              ),
              const Spacer(),
              datang == 'hadir'
                  ? SvgPicture.asset(
                      "assets/icons/check_box_on.svg",
                      width: 28.r,
                      height: 28.r,
                      fit: BoxFit.fill,
                    )
                  : SvgPicture.asset(
                      "assets/icons/check_box_off.svg",
                      width: 28.r,
                      height: 28.r,
                      fit: BoxFit.fill,
                    ),
              SizedBox(width: 6.h),
              pulang == 'hadir'
                  ? SvgPicture.asset(
                      "assets/icons/check_box_on.svg",
                      width: 28.r,
                      height: 28.r,
                      fit: BoxFit.fill,
                    )
                  : SvgPicture.asset(
                      "assets/icons/check_box_off.svg",
                      width: 28.r,
                      height: 28.r,
                      fit: BoxFit.fill,
                    ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            height: 1.h,
            width: double.infinity,
            color: kBlackColor.withOpacity(0.1),
          )
        ],
      ),
    );
  }
}

class MajorMaker extends StatelessWidget {
  const MajorMaker({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: blackTextStyle.copyWith(fontSize: 8.sp),
          overflow: TextOverflow.ellipsis,
          textScaleFactor: 1.0,
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: blackTextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
          textScaleFactor: 1.0,
        ),
      ],
    );
  }
}
