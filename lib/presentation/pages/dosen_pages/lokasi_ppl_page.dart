import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simor/cubit/auth_cubit/auth_cubit.dart';
import 'package:simor/cubit/date_picker_cubit.dart';
import 'package:simor/cubit/dosen_cubit/dosen_cubit.dart';
import 'package:simor/cubit/lokasi_cubit/lokasi_cubit.dart';
import 'package:simor/cubit/month_index_cubit.dart';
import 'package:simor/models/lokasimhs_model.dart';
import 'package:simor/presentation/utils/date_formatter.dart';

import '../../../cubit/date_index_cubit.dart';
import '../../../shared/themes.dart';
import '../../widgets/costume_card_mhs.dart';
import '../../widgets/date_picker.dart';

class LokasiPplPage extends StatelessWidget {
  const LokasiPplPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SvgPicture.asset(
                'assets/images/img_appbar_dosen.svg',
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                top: 55.h,
                left: 18.w,
                right: 18.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_outlined,
                        color: kWhiteColor,
                      ),
                    ),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthDosen) {
                          return Container(
                            height: 44.r,
                            width: 44.r,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              image: DecorationImage(
                                image: NetworkImage(
                                  state.dosenModel.gambar,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 54.h,
                width: 130.w,
                child: DropdownSearch<String>(
                  popupProps: const PopupProps.menu(showSelectedItems: true),
                  items: const [
                    "Januari",
                    "Februari",
                    "Maret",
                    "April",
                    "Mei",
                    "Juni",
                    "Juli",
                    "Agustus",
                    "September",
                    "Oktober",
                    "November",
                    "Desember",
                  ],
                  dropdownBuilder: (context, selectedItem) {
                    return Text(
                      selectedItem!,
                      style: blackTextStyle.copyWith(fontSize: 14.sp),
                      textScaleFactor: 1,
                    );
                  },
                  dropdownButtonProps: const DropdownButtonProps(
                    icon: Icon(Icons.arrow_drop_down_outlined),
                    iconSize: 18,
                  ),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 18.h,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    final lokasi = context.read<LokasiCubit>();
                    final month = context.read<MonthCubit>();
                    final date = context.read<DateFilterCubit>();
                    if (value == 'Januari') {
                      month.setMonth('01');
                      lokasi.getMahasiswaByLokasi(
                          '2023-01-${date.state + 1}', data['id']);
                    } else if (value == 'Februari') {
                      month.setMonth('02');
                      lokasi.getMahasiswaByLokasi(
                          '2023-02-${date.state + 1}', data['id']);
                    } else if (value == 'Maret') {
                      month.setMonth('03');
                      lokasi.getMahasiswaByLokasi(
                          '2023-03-${date.state + 1}', data['id']);
                    } else if (value == 'April') {
                      month.setMonth('04');
                      lokasi.getMahasiswaByLokasi(
                          '2023-04-${date.state + 1}', data['id']);
                    } else if (value == 'Mei') {
                      month.setMonth('05');
                      lokasi.getMahasiswaByLokasi(
                          '2023-05-${date.state + 1}', data['id']);
                    } else if (value == 'Juni') {
                      month.setMonth('06');
                      lokasi.getMahasiswaByLokasi(
                          '2023-06-${date.state + 1}', data['id']);
                    } else if (value == 'Juli') {
                      month.setMonth('07');
                      lokasi.getMahasiswaByLokasi(
                          '2023-07-${date.state + 1}', data['id']);
                    } else if (value == 'Agustus') {
                      month.setMonth('08');
                      lokasi.getMahasiswaByLokasi(
                          '2023-08-${date.state + 1}', data['id']);
                    } else if (value == 'September') {
                      month.setMonth('09');
                      lokasi.getMahasiswaByLokasi(
                          '2023-09-${date.state + 1}', data['id']);
                    } else if (value == 'Oktober') {
                      month.setMonth('10');
                      lokasi.getMahasiswaByLokasi(
                          '2023-10-${date.state + 1}', data['id']);
                    } else if (value == 'November') {
                      month.setMonth('11');
                      lokasi.getMahasiswaByLokasi(
                          '2023-11-${date.state + 1}', data['id']);
                    } else if (value == 'Desember') {
                      month.setMonth('12');
                      lokasi.getMahasiswaByLokasi(
                          '2023-12-${date.state + 1}', data['id']);
                    }
                    context.read<DatePickerCubit>().setDate(
                          int.parse(
                            context.read<MonthCubit>().state,
                          ),
                        );
                  },
                  selectedItem: getFormattedMonth(),
                ),
              ),
              SizedBox(width: 21.w),
            ],
          ),
          DatePicker(scrollController: scrollController, id: data['id']),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 24.h,
              bottom: 12.h,
            ),
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(20.r),
              image: const DecorationImage(
                image: AssetImage('assets/images/backgorund.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BlocBuilder<DosenCubit, DosenState>(
              builder: (context, state) {
                if (state is DosenLoaded) {
                  final item = state.lokasi[data['data']];
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 54.r,
                            width: 54.r,
                            margin: EdgeInsets.only(right: 20.w),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: kPrimaryColor, width: 2),
                              borderRadius: BorderRadius.circular(54.h / 2),
                              image: DecorationImage(
                                image: NetworkImage(item.gambar),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.nama,
                                style: whiteTextStyle.copyWith(
                                  fontWeight: semiBold,
                                  fontSize: 12.sp,
                                ),
                                textScaleFactor: 1,
                              ),
                              Container(
                                width: 220.w,
                                margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
                                child: Text(
                                  item.alamat,
                                  style: whiteTextStyle.copyWith(
                                    fontWeight: light,
                                    fontSize: 10.sp,
                                  ),
                                  textScaleFactor: 1,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 21.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          cardName(
                            'Dosen Pembimbing',
                            item.dosenPembimbing,
                            true,
                            116,
                          ),
                          cardName(
                            'Pembimbing Lapangan',
                            item.pembimbingLapangan,
                            true,
                            116,
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          NotificationListener(
            onNotification: (notification) {
              if (notification is OverscrollIndicatorNotification) {
                notification.disallowIndicator();
              }
              return false;
            },
            child: BlocBuilder<LokasiCubit, LokasiState>(
              builder: (context, state) {
                if (state is LokasiLoading) {
                  return Container(
                    height: 68.h,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
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
                if (state is LokasiLoaded) {
                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final data = state.dosenMahasiswaModel[index];
                        return GestureDetector(
                          onTap: () => showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                contentPadding: EdgeInsets.zero,
                                insetPadding: EdgeInsets.zero,
                                content: dialogMahasiswa(context, data),
                              );
                            },
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: CostumeCardMhs(
                              nama: data.nama,
                              nim: data.nim,
                              datang: data.datang.isEmpty
                                  ? '-'
                                  : data.datang[0].keterangan,
                              pulang: data.pulang.isEmpty
                                  ? '-'
                                  : data.pulang[0].keterangan,
                              imgUrl: data.gambar,
                            ),
                          ),
                        );
                      },
                      padding: EdgeInsets.symmetric(
                        vertical: 4.h,
                        horizontal: 16.w,
                      ),
                      separatorBuilder: (_, index) => SizedBox(height: 12.h),
                      itemCount: state.dosenMahasiswaModel.length,
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }

  Container dialogMahasiswa(
    BuildContext context,
    DosenMahasiswaModel data,
  ) {
    return Container(
      height: 485.h - 5,
      width: 330.w,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.datang.isEmpty
                      ? ''
                      : formatDate(data.datang[0].tanggal.toString()),
                  style: blackTextStyle,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: kBlackColor,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 164.r,
            width: 164.r,
            margin: EdgeInsets.symmetric(vertical: 14.h),
            padding: EdgeInsets.all(2.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(164.r / 2),
              border: Border.all(width: 4.r, color: kPrimaryColor),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(164.r / 2),
              child: Image.network(
                data.gambar,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => data.datang.isNotEmpty
                    ? showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            contentPadding: EdgeInsets.zero,
                            insetPadding: EdgeInsets.zero,
                            content: Container(
                              height: 320.h,
                              width: 330.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                image: DecorationImage(
                                  image: NetworkImage(data.datang[0].gambar),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : null,
                child: cardName(
                  'Jam Datang',
                  data.datang.isEmpty ? '-' : data.datang[0].jamDatang,
                  false,
                  90,
                ),
              ),
              GestureDetector(
                onTap: () => data.pulang.isNotEmpty
                    ? showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            contentPadding: EdgeInsets.zero,
                            insetPadding: EdgeInsets.zero,
                            content: Container(
                              height: 320.r,
                              width: 330.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                image: DecorationImage(
                                  image: NetworkImage(data.pulang[0].gambar),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : null,
                child: cardName(
                  'Jam Pulang',
                  data.pulang.isEmpty ? '-' : data.pulang[0].jamPulang,
                  false,
                  90,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 190.h,
            width: double.infinity,
            child: NotificationListener(
              onNotification: (notification) {
                if (notification is OverscrollIndicatorNotification) {
                  notification.disallowIndicator();
                }
                return false;
              },
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 16.w,
                              bottom: 12.h,
                              top: 22.h,
                            ),
                            child: Text(
                              'Deskripsi Kegiatan: ',
                              textScaleFactor: 1,
                              style: blackTextStyle.copyWith(
                                fontWeight: regular,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(6.r),
                            margin: EdgeInsets.only(right: 16.w),
                            decoration: BoxDecoration(
                              color: kSecondColor,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/clock.svg',
                                  ),
                                  SizedBox(width: 4.h),
                                  Text(
                                    data.kegiatan.isEmpty
                                        ? 'Belum diisi'
                                        : formatTime(
                                            data.kegiatan[index].jamMulai,
                                          ),
                                    style: whiteTextStyle.copyWith(
                                        fontSize: 10.sp),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 120.h,
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: kBlackColor),
                        ),
                        child: Text(
                          data.kegiatan.isEmpty
                              ? ''
                              : data.kegiatan[index].deskripsi,
                          textScaleFactor: 1,
                          style: blackTextStyle.copyWith(
                            fontWeight: regular,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(height: 6.0),
                itemCount: data.kegiatan.isEmpty ? 1 : data.kegiatan.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container cardName(
      String title, String subtitle, bool bgColor, double width) {
    return Container(
      height: 38.h,
      width: width.w,
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
        color: bgColor ? kWhiteColor.withOpacity(0.2) : kPrimaryColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: whiteTextStyle.copyWith(
              fontWeight: light,
              fontSize: 8.sp,
            ),
            textScaleFactor: 1,
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: whiteTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 12.sp,
            ),
            textScaleFactor: 1,
          ),
        ],
      ),
    );
  }
}
