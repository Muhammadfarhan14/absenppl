import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../cubit/date_index_cubit.dart';
import '../../cubit/date_picker_cubit.dart';
import '../../cubit/lokasi_cubit/lokasi_cubit.dart';
import '../../cubit/month_index_cubit.dart';
import '../../shared/themes.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key, required this.scrollController, required this.id})
      : super(key: key);

  final ScrollController scrollController;
  final String id;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToIndex(context.read<DateFilterCubit>().state);
    });
  }

  void _scrollTo(double offset) {
    if (offset <= widget.scrollController.position.maxScrollExtent &&
        offset >= widget.scrollController.position.minScrollExtent) {
      widget.scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToIndex(int index) {
    if (widget.scrollController.hasClients) {
      final itemWidth = 51.r;
      final viewportWidth = widget.scrollController.position.viewportDimension;
      final scrollOffset = widget.scrollController.position.minScrollExtent +
          index * itemWidth -
          (viewportWidth - itemWidth) / 2;

      widget.scrollController.animateTo(
        scrollOffset.clamp(
          widget.scrollController.position.minScrollExtent,
          widget.scrollController.position.maxScrollExtent,
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lokasiCubit = context.read<LokasiCubit>();
    final monthCubit = context.read<MonthCubit>().state;
    final dateCubit = context.read<DateFilterCubit>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<DateFilterCubit, int>(
          builder: (context, state) {
            return Container(
              height: 45.h,
              width: 250.w,
              margin: EdgeInsets.symmetric(horizontal: 21.w),
              child: NotificationListener(
                onNotification: (notification) {
                  if (notification is OverscrollIndicatorNotification) {
                    notification.disallowIndicator();
                  }
                  return false;
                },
                child: BlocBuilder<DatePickerCubit, List<String>>(
                  builder: (context, hari) {
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      controller: widget.scrollController,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Future.delayed(
                              const Duration(milliseconds: 50),
                              () async {
                                dateCubit.setDate(index);
                                await lokasiCubit.getMahasiswaByLokasi(
                                  '2023-$monthCubit-${dateCubit.state + 1}',
                                  widget.id,
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 45.r,
                            width: 45.r,
                            decoration: BoxDecoration(
                              color: index == state ? kSecondColor : null,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  hari[index].substring(0, 3),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12.sp,
                                    color: index == state
                                        ? kWhiteColor
                                        : kBlackColor,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  (index >= hari.length
                                      ? '${index + 1}'
                                      : '${index + 1}'),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16.sp,
                                    color: index == state
                                        ? kWhiteColor
                                        : kBlackColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, index) => SizedBox(width: 6.w),
                      itemCount: hari.length,
                    );
                  },
                ),
              ),
            );
          },
        ),
        GestureDetector(
          onTap: () {
            final currentPosition = widget.scrollController.position.pixels;
            final viewportWidth =
                widget.scrollController.position.viewportDimension;
            final width = 52.r;
            final scrollOffset = currentPosition + viewportWidth - width;

            _scrollTo(scrollOffset);
          },
          child: Container(
            height: 45.r,
            width: 45.r,
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  'assets/icons/next_date.svg',
                  width: 40.r,
                  height: 20.r,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
