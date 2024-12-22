import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simor/shared/themes.dart';

class ChoiceScan extends StatelessWidget {
  const ChoiceScan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                      height: 54.h,
                      width: 197.w,
                      fit: BoxFit.fill,
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
                    SizedBox(height: 34.h),
                    const ButtonChoice(
                      title: 'Datang',
                      bg: 'bg_scan_2.svg',
                      card: 'bg_presensi_in.svg',
                    ),
                    SizedBox(height: 16.h),
                    const ButtonChoice(
                      title: 'Pulang',
                      bg: 'bg_scan_2.svg',
                      card: 'bg_presensi_out.svg',
                      status: 'Pulang',
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_outlined,
                        color: kWhiteColor,
                        size: 32.r,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonChoice extends StatelessWidget {
  const ButtonChoice({
    super.key,
    required this.title,
    required this.bg,
    required this.card,
    this.status = 'Datang',
  });

  final String title;
  final String bg, card;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 85.w),
      child: Container(
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              '/scan-pembimbing',
              arguments: {
                'bg': bg,
                'card': card,
                'status': status,
                'height': 44.h,
                'typePage': false,
                'title': title,
              },
            ),
            borderRadius: BorderRadius.circular(8.w),
            child: SizedBox(
              height: 50.h,
              width: double.infinity,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: bold,
                    fontSize: 12.sp,
                  ),
                  textScaleFactor: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
