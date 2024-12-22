import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simor/shared/themes.dart';

class Infoprofile extends StatelessWidget {
  const Infoprofile({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Container(
        height: 65.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: kGreyColor.withOpacity(0.19),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
              ),
              textScaleFactor: 1,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: kTextInfoColor,
              ),
              textScaleFactor: 1,
            ),
          ],
        ),
      ),
    );
  }
}
