import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simor/cubit/auth_cubit/auth_cubit.dart';
import 'package:simor/cubit/mhs_pick_cubit.dart';
import 'package:simor/cubit/nilai_cubit.dart';
import 'package:simor/cubit/pembimbing_cubit/pembimbing_cubit.dart';
import 'package:simor/models/penilaian_model.dart';
import 'package:simor/presentation/widgets/costume_button.dart';

import '../../../shared/themes.dart';

class PenilaianMahasiswa extends StatelessWidget {
  const PenilaianMahasiswa({super.key});

  @override
  Widget build(BuildContext context) {
    final pickMhs = context.read<PickMhs>();
    final nialiCubit = context.read<NilaiCubit>();
    final pembimbingCubit = context.read<PembimbingCubit>();
    return Scaffold(
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
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthPembimbing) {
                return SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 54.h,
                        height: 54.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(64.h),
                          border: Border.all(
                            color: kSecondColor,
                            width: 1.5.w,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              state.pembimbing.lokasi.gambar,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 22.h),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.pembimbing.lokasi.nama,
                            style: whiteTextStyle.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textScaleFactor: 1.0,
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            width: 220.w,
                            child: Text(
                              state.pembimbing.lokasi.alamat,
                              style: whiteTextStyle.copyWith(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w300,
                              ),
                              textScaleFactor: 1,
                              maxLines: 4,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
              child: Stack(
                children: [
                  BlocBuilder<PickMhs, PenilaianModel>(
                    builder: (context, state) {
                      return Container(
                        height: 62.h,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 1,
                              blurStyle: BlurStyle.solid,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 42.r,
                              width: 42.r,
                              margin: EdgeInsets.only(right: 14.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                image: DecorationImage(
                                  image: NetworkImage(state.gambar),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.nama,
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: medium,
                                  ),
                                  textScaleFactor: 1,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  state.nim,
                                  style: blackTextStyle.copyWith(
                                    fontWeight: light,
                                    fontSize: 12.sp,
                                  ),
                                  textScaleFactor: 1,
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_drop_down_outlined),
                            SizedBox(width: 12.w),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 60,
                    child: DropdownSearch(
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      dropdownButtonProps: const DropdownButtonProps(
                        padding: EdgeInsets.zero,
                        iconSize: 0,
                        isVisible: false,
                      ),
                      popupProps: PopupProps.menu(
                        menuProps: const MenuProps(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        containerBuilder: (ctx, popupWidget) {
                          return BlocBuilder<PembimbingCubit, PembimbingState>(
                            builder: (context, state) {
                              if (state is PembimbingPenilaian) {
                                return NotificationListener(
                                  onNotification: (notification) {
                                    if (notification
                                        is OverscrollIndicatorNotification) {
                                      notification.disallowIndicator();
                                    }
                                    return false;
                                  },
                                  child: ListView.builder(
                                    itemCount: state.mhs.length,
                                    itemBuilder: (ctx, index) {
                                      final data = state.mhs[index];
                                      return GestureDetector(
                                        onTap: data.status != 1
                                            ? () {
                                                context
                                                    .read<NilaiCubit>()
                                                    .initial();
                                                Navigator.pop(context);
                                                pickMhs
                                                    .pickMhs(state.mhs[index]);
                                              }
                                            : () {},
                                        child: Column(
                                          children: [
                                            CardMahasiswa(
                                              name: data.nama,
                                              nim: data.nim,
                                              status: data.status,
                                              gambar: data.gambar,
                                              index: index,
                                              last: state.mhs.length,
                                            ),
                                            index != state.mhs.length - 1
                                                ? Container(
                                                    height: 1,
                                                    width: double.infinity,
                                                    color: kBlackColor
                                                        .withOpacity(0.01),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                              return Container();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.h, bottom: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Kriteria Penilaian',
                    style: blackTextStyle.copyWith(
                      fontSize: 18.sp,
                      fontWeight: semiBold,
                    ),
                    textScaleFactor: 1,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    '(1/5)',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                ],
              ),
            ),
            categoriValue(nialiCubit, 0, 'Inovasi'),
            categoriValue(nialiCubit, 1, 'Kerja Sama'),
            categoriValue(nialiCubit, 2, 'Disiplin'),
            categoriValue(nialiCubit, 3, 'Inisiatif'),
            categoriValue(nialiCubit, 4, 'Kerajinan'),
            categoriValue(nialiCubit, 5, 'Sikap'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Text(
                '* Kisaran Penilaian : 100 ≥ A ≥ 80 , 80 > B ≥ 60 , C < 60',
                style: orangeTextStyle.copyWith(
                  fontSize: 12.sp,
                  fontWeight: medium,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            BlocBuilder<PickMhs, PenilaianModel>(
              builder: (context, state) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  padding: EdgeInsets.only(left: 200.w, right: 20.w),
                  child: Costumebutton(
                    title: 'Kirim',
                    ontap: state.id != -1
                        ? () async {
                            context.read<PickMhs>().initial();
                            await context.read<PembimbingCubit>().sendNilai(
                                  context.read<NilaiCubit>().state,
                                  state.id.toString(),
                                );
                            await pembimbingCubit.getMahasiswaPenilaian();
                          }
                        : () {},
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Padding categoriValue(NilaiCubit nialiCubit, int index, String category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: blackTextStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: medium,
            ),
            textScaleFactor: 1,
          ),
          BlocBuilder<NilaiCubit, List<int>>(
            builder: (context, state) {
              return Row(
                children: [
                  buttonValue(
                    'A',
                    state[index] == 4
                        ? kSecondColor
                        : kSecondColor.withOpacity(0.4),
                    () => nialiCubit.klikNilai(4, index),
                  ),
                  buttonValue(
                    'B',
                    state[index] == 3
                        ? kSecondColor
                        : kSecondColor.withOpacity(0.4),
                    () => nialiCubit.klikNilai(3, index),
                  ),
                  buttonValue(
                    'C',
                    state[index] == 2
                        ? kSecondColor
                        : kSecondColor.withOpacity(0.4),
                    () => nialiCubit.klikNilai(2, index),
                  ),
                  buttonValue(
                    'D',
                    state[index] == 1
                        ? kSecondColor
                        : kSecondColor.withOpacity(0.4),
                    () => nialiCubit.klikNilai(1, index),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  GestureDetector buttonValue(String value, Color color, Function() ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 24.h,
        width: 38.w,
        margin: EdgeInsets.only(right: 18.w, top: 12.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Center(
          child: Text(
            value,
            style: whiteTextStyle,
          ),
        ),
      ),
    );
  }
}

class CardMahasiswa extends StatelessWidget {
  const CardMahasiswa({
    super.key,
    required this.name,
    required this.nim,
    required this.status,
    required this.gambar,
    required this.index,
    required this.last,
  });

  final String name, nim, gambar;
  final int status, index, last;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: index == 0
            ? const BorderRadius.vertical(top: Radius.circular(10))
            : index == last - 1
                ? const BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  )
                : BorderRadius.circular(0),
      ),
      child: Row(
        children: [
          Container(
            height: 42.r,
            width: 42.r,
            margin: EdgeInsets.only(right: 14.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: NetworkImage(gambar),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: blackTextStyle.copyWith(
                  fontSize: 12.sp,
                  fontWeight: medium,
                ),
                textScaleFactor: 1,
              ),
              SizedBox(height: 4.h),
              Text(
                nim,
                style: blackTextStyle.copyWith(
                  fontWeight: light,
                  fontSize: 12.sp,
                ),
                textScaleFactor: 1,
              ),
            ],
          ),
          const Spacer(),
          status == 0
              ? Container()
              : SvgPicture.asset('assets/icons/checklis.svg'),
          SizedBox(width: 12.w),
        ],
      ),
    );
  }
}
