import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simor/cubit/auth_cubit/auth_cubit.dart';
import 'package:simor/cubit/mahasiswa_cubit/mahasiswa_cubit.dart';
import 'package:simor/cubit/time_cubit.dart';
import 'package:simor/models/kegiatan_model.dart';
import 'package:simor/shared/themes.dart';
import 'package:simor/presentation/widgets/costume_dialog.dart';

import '../../widgets/form_input_kegiatan.dart';

class Kegiatanmahasiswa extends StatefulWidget {
  const Kegiatanmahasiswa({super.key});

  @override
  State<Kegiatanmahasiswa> createState() => _KegiatanmahasiswaState();
}

class _KegiatanmahasiswaState extends State<Kegiatanmahasiswa> {
  final List<TextEditingController> _controllers = [];
  final List<GlobalKey<FormState>> _widgetKeys = [];

  @override
  void initState() {
    super.initState();
    _addKeys();
    _addTextField();
    context.read<MahasiswaCubit>().getKegiatan(context.read<AuthCubit>().mhsId);
    context.read<TimeCubit>().addnew();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addTextField() {
    _controllers.add(TextEditingController());
    setState(() {});
  }

  void _addKeys() {
    _widgetKeys.add(GlobalKey<FormState>());
    setState(() {});
  }

  bool isKeyboardActive() {
    final currentFocus = FocusScope.of(context);
    return currentFocus.hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    final timeCubit = context.read<TimeCubit>();
    final authCubit = context.read<AuthCubit>();
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
                  onTap: () async {
                    await Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home-mahasiswa',
                      (route) => false,
                    );
                    timeCubit.initial();
                  },
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    color: kWhiteColor,
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
      body: BlocListener<MahasiswaCubit, MahasiswaState>(
        listener: (context, state) {
          if (state is MahasiswaGetkegiatan) {
            if (state.kegiatan.isNotEmpty) {
              _controllers.clear();
              _widgetKeys.clear();
              for (var i = 0; i < state.kegiatan.length; i++) {
                final data = state.kegiatan[i];
                _controllers.add(TextEditingController(text: data.deskripsi));
                _widgetKeys.add(GlobalKey<FormState>());
                timeCubit.addTime(data.jam, i);
              }
            }
          }
        },
        child: NotificationListener(
          onNotification: (notification) {
            if (notification is OverscrollIndicatorNotification) {
              notification.disallowIndicator();
            }
            return false;
          },
          child: ListView(
            children: [
              BlocBuilder<MahasiswaCubit, MahasiswaState>(
                builder: (context, state) {
                  if (state is MahasiswaGetkegiatan) {
                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height > 690
                              ? _widgetKeys.length * 195.h
                              : _widgetKeys.length * 210.h,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 12.h),
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return FormInputKegiatan(
                                controller: _controllers[index],
                                formKey: _widgetKeys[index],
                                title: 'Deskripsi Kegiatan:',
                                index: index,
                              );
                            },
                            separatorBuilder: (_, index) => SizedBox(
                              height: 16.h,
                            ),
                            itemCount: _controllers.length,
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 20.w,
                  left: 20.w,
                  bottom: 10.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonWithIcon(
                      title: 'Tambah',
                      icon: "assets/icons/add.svg",
                      color: kTransparantColor,
                      colorBorder: kSecondColor,
                      ontap: () {
                        _addTextField();
                        _addKeys();
                        timeCubit.addnew();
                      },
                    ),
                    SizedBox(width: 16.h),
                    ButtonWithIcon(
                      title: "Simpan",
                      icon: "assets/icons/memory.svg",
                      colorBorder: kWhiteColor,
                      ontap: () {
                        bool isValid = true;
                        for (var key in _widgetKeys) {
                          if (!key.currentState!.validate()) {
                            isValid = false;
                            continue;
                          }
                        }
                        if (isValid) {
                          _controllers.asMap().forEach((index, controller) {
                            context.read<MahasiswaCubit>().saveKegiatan(
                                  KegiatanModel(
                                    id: index.toString(),
                                    jam: timeCubit.state[index],
                                    deskripsi: controller.text,
                                  ),
                                  authCubit.mhsId,
                                );
                          });
                          showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return const Dialoginfo(
                                height: 320,
                                title: 'Rencana kegiatan\nberhasil disimpan',
                              );
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({
    super.key,
    required this.title,
    required this.icon,
    this.color = kPrimaryColor,
    this.colorBorder = kTransparantColor,
    required this.ontap,
  });

  final String icon, title;
  final Color color, colorBorder;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 42.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: colorBorder),
        ),
        child: Material(
          color: kTransparantColor,
          child: InkWell(
            onTap: ontap,
            borderRadius: BorderRadius.circular(8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icon,
                  width: 12.r,
                  height: 12.r,
                  fit: BoxFit.fill,
                ),
                SizedBox(width: 18.w),
                Text(
                  title,
                  style: whiteTextStyle.copyWith(
                    color: colorBorder,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                  textScaleFactor: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
