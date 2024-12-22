import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../shared/themes.dart';

class CostumeCardMhs extends StatelessWidget {
  const CostumeCardMhs({
    super.key,
    required this.nama,
    required this.nim,
    required this.datang,
    required this.pulang,
    required this.imgUrl,
  });

  final String nama, nim;
  final String datang, pulang, imgUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 48.r,
          width: 48.r,
          margin: EdgeInsets.only(right: 20.w),
          decoration: BoxDecoration(
            border: Border.all(color: kPrimaryColor, width: 2),
            borderRadius: BorderRadius.circular(54.h / 2),
            image: DecorationImage(
              image: NetworkImage(
                imgUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 150.w,
              child: Text(
                nama,
                style: TextStyle(
                  fontWeight: medium,
                  fontSize: 14.sp,
                ),
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1,
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
    );
  }
}
