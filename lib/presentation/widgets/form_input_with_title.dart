import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simor/shared/themes.dart';

import '../../cubit/obscure_text_cubit.dart';

class TextfieldMaker extends StatelessWidget {
  const TextfieldMaker({
    super.key,
    required this.title,
    this.obscure = false,
    this.icon = Icons.visibility,
    this.showIcon = false,
    required this.controller,
    required this.form,
  });

  final String title;
  final bool obscure, showIcon;
  final IconData icon;
  final TextEditingController controller;
  final GlobalKey<FormState> form;

  @override
  Widget build(BuildContext context) {
    final obscureCubit = context.read<ObscureTextCubit>();
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            textScaleFactor: 1,
            style: TextStyle(
              color: kWhiteColor,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),
        Form(
          key: form,
          child: TextFormField(
            controller: controller,
            cursorColor: kWhiteColor,
            style: TextStyle(color: kWhiteColor, fontSize: 14.sp),
            obscureText: obscure,
            decoration: InputDecoration(
              hintText: 'Masukkan $title',
              hintStyle: TextStyle(
                color: kWhiteColor,
                fontWeight: FontWeight.w300,
                fontSize: 12.sp,
              ),
              errorStyle: const TextStyle(color: kWhiteColor),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kWhiteColor),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kWhiteColor),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kWhiteColor),
              ),
              suffixIcon: showIcon
                  ? GestureDetector(
                      onTap: () => obscureCubit.toggleObscure(),
                      child: Icon(icon, color: kWhiteColor),
                    )
                  : const SizedBox(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field tidak boleh kosong';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
