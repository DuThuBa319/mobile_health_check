import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../classes/language_constant.dart';
import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/enum_common.dart';
import '../../common_widget/line_decor.dart';
import '../../common_widget/loading_widget.dart';
import '../../common_widget/screen_form/custom_screen_form.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/theme_color.dart';
import 'bloc/history_bloc.dart';
import 'widget/blood_pressure_cell.dart';
part 'blood_pressure_history_screen_action.dart';

class BloodPressureHistoryScreen extends StatefulWidget {
  final String? id;
  // final HistoryBloc historyBloc;

  const BloodPressureHistoryScreen({
    Key? key,
    required this.id,
    // required this.historyBloc,
  }) : super(key: key);

  @override
  State<BloodPressureHistoryScreen> createState() =>
      BloodPressureHistoryScreenState();
}

class BloodPressureHistoryScreenState
    extends State<BloodPressureHistoryScreen> {
  final _refreshController = RefreshController(initialRefresh: false);
  DateTime timeFrom =
      DateTime.now().add(const Duration(days: -1, hours: 00, minutes: 00));
  DateTime timeTo = DateTime.now().add(const Duration(hours: 23, minutes: 59));
  String strTimeFrom = DateFormat('dd/MM/yyyy').format(
      DateTime.now().add(const Duration(days: -1, hours: 00, minutes: 00)));
  String strTimeTo = DateFormat('dd/MM/yyyy')
      .format(DateTime.now().add(const Duration(hours: 23, minutes: 59)));
  HistoryBloc get historyBloc => BlocProvider.of(context);
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return CustomScreenForm(
      title: translation(context).history,
      isShowAppBar: true,
      isShowBottomNayvigationBar: true,
      isShowLeadingButton: true,
      appBarColor: AppColor.appBarColor,
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(
                  translation(context).selectTime,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 5),
                lineDecor(),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  selectedDate(isSelectedDateFrom: true);
                },
                child: Container(
                    width: screenWidth * 0.40,
                    height: screenHeight * 0.055,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: AppColor.color43C8F5),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_month,
                            color: AppColor.color43C8F5, size: 30),
                        Text(strTimeFrom,
                            style: AppTextTheme.body4.copyWith(
                                color: AppColor.color43C8F5, fontSize: 20))
                      ],
                    )),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  selectedDate(isSelectedDateFrom: false);
                },
                child: Container(
                    width: screenWidth * 0.41,
                    height: screenHeight * 0.055,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: AppColor.color43C8F5),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_month,
                            color: AppColor.color43C8F5, size: 30),
                        Text(strTimeTo,
                            style: AppTextTheme.body4.copyWith(
                                color: AppColor.color43C8F5, fontSize: 20))
                      ],
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: InkWell(
              onTap: () {
                if (timeFrom.isAfter(timeTo)) {
                  showAlertDialog(context);
                } else {
                  onGetBloodPressureData();
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: screenWidth * 0.4,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 71, 200, 255),
                ),
                child: Text(
                  translation(context).search,
                  style: AppTextTheme.title3.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              header: const WaterDropHeader(),
              child: BlocConsumer<HistoryBloc, HistoryState>(
                listener: blocListener,
                builder: (context, state) {
                  if (state is HistoryInitialState) {
                    onGetBloodPressureInitData();
                    //onGetHistoryData();
                    // return Center(
                    //     child: Text('Vui lòng chọn thông tin',
                    //         style: AppTextTheme.body2
                    //             .copyWith(color: Colors.red)));
                  }
                  if (state.status == BlocStatusState.loading) {
                    return const Center(
                      child: Loading(
                        brightness: Brightness.light,
                      ),
                    );
                  }
                  if ((state.viewModel.listBloodPressure == null &&
                          state is GetHistoryDataState &&
                          state.status == BlocStatusState.success) ||
                      state.status == BlocStatusState.failure) {
                    return Center(
                        child: Text('Đã xảy ra lỗi',
                            style: AppTextTheme.body2
                                .copyWith(color: Colors.red)));
                  }
                  if (state.status == BlocStatusState.success &&
                      state is GetHistoryDataState) {
                    if (state.viewModel.listBloodPressure!.isEmpty) {
                      return Center(
                          child: Text('Không có dữ liệu',
                              style: AppTextTheme.body2
                                  .copyWith(color: Colors.red)));
                    } else {
                      return ListView.builder(
                        reverse: true,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: state.viewModel.listBloodPressure?.length,
                        itemBuilder: (context, index) {
                          return BloodPressureCellWidget(
                            historyBloc: historyBloc,
                            response: state.viewModel.listBloodPressure?[index],
                          );
                        },
                      );
                    }
                  }
                  return Container();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
