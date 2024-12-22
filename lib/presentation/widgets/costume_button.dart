import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simor/shared/themes.dart';

class Costumebutton extends StatelessWidget {
  const Costumebutton({
    super.key,
    required this.title,
    this.colorTitle = kWhiteColor,
    this.colorButton = kPrimaryColor,
    this.progres = true,
    required this.ontap,
  });

  final String title;
  final Color colorTitle, colorButton;
  final bool progres;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorButton,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: ontap,
          borderRadius: BorderRadius.circular(8.w),
          child: SizedBox(
            height: 44.h,
            width: double.infinity,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: colorTitle,
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                ),
                textScaleFactor: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
