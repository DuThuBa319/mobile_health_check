import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/presentation/modules/history/temperature_history_screen/widget/temperature_cell.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../classes/language.dart';
import '../../../../utils/size_config.dart';

import '../../../common_widget/common.dart';
import '../../../theme/app_text_theme.dart';
import '../../../theme/theme_color.dart';
import '../history_bloc/history_bloc.dart';

part 'temperature_history_screen_action.dart';

class TemperatureHistoryScreen extends StatefulWidget {
  const TemperatureHistoryScreen({super.key, this.id});
  final String? id;

  @override
  State<TemperatureHistoryScreen> createState() =>
      TemperatureHistoryScreenState();
}

class TemperatureHistoryScreenState extends State<TemperatureHistoryScreen> {
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
    SizeConfig.init(context);

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
                  style: TextStyle(
                      fontSize: SizeConfig.screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 5),
                lineDecor(),
                // lineDecor(),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  selectedDate(isSelectedDateFrom: true);
                },
                child: Container(
                    width: SizeConfig.screenWidth * 0.40,
                    height: SizeConfig.screenHeight * 0.055,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: AppColor.color43C8F5),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month,
                            color: AppColor.color43C8F5,
                            size: SizeConfig.screenWidth * 0.08),
                        Text(strTimeFrom,
                            style: AppTextTheme.body4.copyWith(
                                color: AppColor.color43C8F5,
                                fontSize: SizeConfig.screenWidth * 0.05))
                      ],
                    )),
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.08,
              ),
              InkWell(
                onTap: () {
                  selectedDate(isSelectedDateFrom: false);
                },
                child: Container(
                    width: SizeConfig.screenWidth * 0.40,
                    height: SizeConfig.screenHeight * 0.055,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: AppColor.color43C8F5),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month,
                            color: AppColor.color43C8F5,
                            size: SizeConfig.screenWidth * 0.08),
                        Text(strTimeTo,
                            style: AppTextTheme.body4.copyWith(
                                color: AppColor.color43C8F5,
                                fontSize: SizeConfig.screenWidth * 0.05))
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
                  showExceptionDialog(
                      context: context,
                      message: translation(context).selectError,
                      onClose: () {
                        timeFrom = timeTo;
                        strTimeFrom = DateFormat('dd/MM/yyyy').format(timeFrom);
                      },
                      titleBtn: translation(context).exit);
                } else {
                  onGetTemperatureData();
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: SizeConfig.screenWidth * 0.4,
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
          SizedBox(height: SizeConfig.screenWidth * 0.08),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              header: const WaterDropHeader(),
              child: BlocConsumer<HistoryBloc, HistoryState>(
                listener: blocListener,
                builder: (context, state) {
                  if (state is HistoryInitialState) {
                    return Center(
                        child: Text(translation(context).selectTime,
                            style: AppTextTheme.body2
                                .copyWith(color: Colors.red)));
                  }
                  if (state.status == BlocStatusState.failure &&
                      state.viewModel.errorMessage ==
                          translation(context).wifiDisconnect) {
                    return Center(
                        child: Text(translation(context).error,
                            style: AppTextTheme.body2.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)));
                  }
                  if (state.status == BlocStatusState.loading) {
                    return const Center(
                      child: Loading(
                        brightness: Brightness.light,
                      ),
                    );
                  }
                  if ((state.viewModel.listTemperature == null &&
                          state is GetHistoryDataState &&
                          state.status == BlocStatusState.success) ||
                      state.status == BlocStatusState.failure) {
                    return Center(
                        child: Text(translation(context).error,
                            style: AppTextTheme.body2.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)));
                  }
                  if (state.status == BlocStatusState.success &&
                      state is GetHistoryDataState) {
                    if (state.viewModel.listTemperature!.isEmpty) {
                      return Center(
                          child: Text(translation(context).noData,
                              style: AppTextTheme.body2
                                  .copyWith(color: Colors.red)));
                    } else {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: state.viewModel.listTemperature?.length,
                        itemBuilder: (context, index) {
                          return TemperatureCellWidget(
                            historyBloc: historyBloc,
                            response: state.viewModel.listTemperature?[index],
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
