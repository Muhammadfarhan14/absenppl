import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:simor/cubit/pembimbing_cubit/pembimbing_cubit.dart';
import 'package:simor/presentation/widgets/dialog_absen_widget.dart';

import '../../../shared/themes.dart';
import '../../utils/date_formatter.dart';

class ScanPembimbing extends StatefulWidget {
  const ScanPembimbing({super.key});

  @override
  State<ScanPembimbing> createState() => _ScanPembimbingState();
}

class _ScanPembimbingState extends State<ScanPembimbing> {
  @override
  void initState() {
    super.initState();
    _listenLnLinks();
  }

  @override
  void dispose() {
    super.dispose();
    _stopNFCSession();
  }

  _listenLnLinks() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (isAvailable && Platform.isAndroid) {
      _startNFCSession();
    }
  }

  _startNFCSession() async {
    await NfcManager.instance.stopSession();
    final stopwatch = Stopwatch();
    stopwatch.start();
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        var ndef = Ndef.from(tag);
        if (ndef != null) {
          stopwatch.stop();
          final duration = stopwatch.elapsedMilliseconds;
          debugPrint('$duration Miliseconds For Read Card');
          for (var rec in ndef.cachedMessage!.records) {
            String payload = String.fromCharCodes(rec.payload);
            String idPpl = payload.substring(3);
            context.read<PembimbingCubit>().cekMahasiswa(idPpl);
          }
        }
      },
    );
  }

  void _stopNFCSession() {
    NfcManager.instance.stopSession();
  }

  @override
  Widget build(BuildContext context) {
    final pembimbingCubit = context.read<PembimbingCubit>();
    final Map<String, dynamic> item =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<PembimbingCubit, PembimbingState>(
        listener: (context, state) {
          if (state is PembimbingCekMhs) {
            dialogAbsen(
              context,
              item['title'] == 'Datang' ? 'Datang' : 'Pulang',
              state.mhs.gambar,
              state.mhs.nama,
              state.mhs.nim,
              state.mhs.idPpl,
            );
          }
          if (state is PembimbingFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Kamu Tidak Terdaftar di Pembimbing ini'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: WillPopScope(
          onWillPop: () async {
            pembimbingCubit.getMahasiswa();
            return true;
          },
          child: Stack(
            children: [
              SvgPicture.asset(
                "assets/images/${item['bg']}",
                height: 202.h,
                fit: BoxFit.fill,
              ),
              SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: 40.h,
                        width: 180.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    Stack(
                      children: [
                        SvgPicture.asset(
                          'assets/images/${item['card']}',
                          width: 320.w,
                          fit: BoxFit.fill,
                        ),
                        Positioned(
                          top: 25.h,
                          left: 30.w,
                          child: Text(
                            dateFromat(),
                            style: whiteTextStyle.copyWith(
                              fontSize: 12.sp,
                              fontWeight: light,
                            ),
                            textScaleFactor: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 45.h),
                    Text(
                      'Scan Kartu Anda!',
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                      ),
                      textScaleFactor: 1,
                    ),
                    const Spacer(),
                    Image.asset(
                      "assets/images/vector_scan.png",
                      width: 120.r,
                      height: 120.r,
                      fit: BoxFit.fill,
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 60.h,
                        left: 16.w,
                        right: 16.w,
                      ),
                      child: Text(
                        'Silahkan Scan Kartu Anda Pada Perangkat Pembimbing Lapangan ',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                      ),
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
