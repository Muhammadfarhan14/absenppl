import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:simor/cubit/time_cubit.dart';

import '../../shared/themes.dart';

class FormInputKegiatan extends StatefulWidget {
  const FormInputKegiatan({
    Key? key,
    required this.title,
    required this.controller,
    required this.index,
    required this.formKey,
  }) : super(key: key);

  final int index;
  final String title;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

  @override
  State<FormInputKegiatan> createState() => _FormInputKegiatanState();
}

class _FormInputKegiatanState extends State<FormInputKegiatan> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: kTextInfoColor,
                ),
                textScaleFactor: 1,
              ),
              GestureDetector(
                onTap: () => _showTimePicker(context),
                child: Container(
                  height: 24.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: kSecondColor,
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/clock.svg",
                        height: 14.r,
                        width: 14.r,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 8.w),
                      BlocBuilder<TimeCubit, List<String>>(
                        builder: (context, state) {
                          return Text(
                            state[widget.index] == ''
                                ? "Pilih Waktu"
                                : state[widget.index],
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 12.sp,
                            ),
                            textScaleFactor: 1,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16.h),
          Form(
            key: widget.formKey,
            child: TextFormField(
              controller: widget.controller,
              maxLines: MediaQuery.of(context).size.height > 690 ? 9 : 6,
              cursorColor: kBlackColor,
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
                  borderSide: const BorderSide(color: kTextInfoColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(color: kTextInfoColor),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Deskripsikan Rencana Kegiatanmu Hari Ini';
                }
                if (context.read<TimeCubit>().state[widget.index] == '') {
                  return 'Masukkan Jam Kegiatan';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showTimePicker(BuildContext context) async {
    final timeCubit = context.read<TimeCubit>();
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Pilih Waktu',
    );

    if (pickedTime != null) {
      final String formattedTime = DateFormat.Hm().format(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
            pickedTime.hour, pickedTime.minute),
      );
      timeCubit.addTime(formattedTime, widget.index);
    }
  }
}
