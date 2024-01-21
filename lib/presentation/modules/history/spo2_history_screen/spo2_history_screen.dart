import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/classes/language.dart';
import 'package:mobile_health_check/presentation/modules/history/spo2_history_screen/widget/spo2_cell.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../utils/size_config.dart';

import '../../../common_widget/common.dart';
import '../../../theme/app_text_theme.dart';
import '../../../theme/theme_color.dart';
import '../history_bloc/history_bloc.dart';

part 'spo2_history_screen_action.dart';

class Spo2HistoryScreen extends StatefulWidget {
  final String? id;

  const Spo2HistoryScreen({super.key, this.id});

  @override
  State<Spo2HistoryScreen> createState() => Spo2HistoryScreenState();
}

class Spo2HistoryScreenState extends State<Spo2HistoryScreen> {
  final _refreshController = RefreshController(initialRefresh: false);
  // ignore: sdk_version_since
  DateTime timeFrom = DateTime.now().copyWith(hour: 0, minute: 1);
  DateTime timeTo = DateTime.now()
      .add(const Duration(days: 1))
      // ignore: sdk_version_since
      .copyWith(hour: 24, minute: 59);
  // ignore: sdk_version_since
  String strTimeFrom = DateFormat('dd/MM/yyyy')
      // ignore: sdk_version_since
      .format(DateTime.now().copyWith(hour: 0, minute: 1));
  String strTimeTo = DateFormat('dd/MM/yyyy').format(DateTime.now()
      .add(const Duration(days: 1))
      // ignore: sdk_version_since
      .copyWith(hour: 24, minute: 59));
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
                      fontSize: SizeConfig.screenDiagonal * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 5),
                lineDecor(),
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
                        Icon(
                          Icons.calendar_month,
                          color: AppColor.color43C8F5,
                          size: SizeConfig.screenWidth * 0.092,
                        ),
                        emptySpace(SizeConfig.screenWidth * 0.01),
                        Text(strTimeTo,
                            style: AppTextTheme.body4.copyWith(
                              color: AppColor.color43C8F5,
                              fontSize: SizeConfig.screenWidth * 0.044,
                            ))
                      ],
                    )),
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.05,
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
                        Icon(
                          Icons.calendar_month,
                          color: AppColor.color43C8F5,
                          size: SizeConfig.screenWidth * 0.092,
                        ),
                        emptySpace(SizeConfig.screenWidth * 0.01),
                        Text(strTimeTo,
                            style: AppTextTheme.body4.copyWith(
                              color: AppColor.color43C8F5,
                              fontSize: SizeConfig.screenWidth * 0.044,
                            ))
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
                        setState(() {
                          timeFrom =
                              // ignore: sdk_version_since
                              DateTime.now().copyWith(hour: 0, minute: 1);
                          timeTo = timeFrom
                              .add(const Duration(days: 1))
                              // ignore: sdk_version_since
                              .copyWith(hour: 23, minute: 59);
                          strTimeFrom =
                              DateFormat('dd/MM/yyyy').format(timeFrom);
                          strTimeTo = DateFormat('dd/MM/yyyy').format(timeTo);
                        });
                      },
                      titleBtn: translation(context).exit);
                } else {
                  onGetSpo2Data();
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
          SizedBox(height: SizeConfig.screenHeight * 0.025),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: _onSpo2Refresh,
              header: const WaterDropHeader(),
              child: BlocConsumer<HistoryBloc, HistoryState>(
                listener: blocListener,
                builder: (context, state) {
                  //? Init
                  if (state is HistoryInitialState) {
                    return Center(
                        child: Text(translation(context).selectTime,
                            style: AppTextTheme.body2.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)));
                  }

                  //? Loading
                  if (state.status == BlocStatusState.loading) {
                    return const Center(
                      child: Loading(
                        brightness: Brightness.light,
                      ),
                    );
                  }
                  //? Success
                  if (state.status == BlocStatusState.success &&
                      state is GetHistoryDataState) {
                    if (state.viewModel.listSpo2!.isEmpty) {
                      return Center(
                          child: Text(translation(context).noData,
                              style: AppTextTheme.body2.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)));
                    }
                    if (state.viewModel.listSpo2 == null) {
                      return Center(
                          child: Text(translation(context).error,
                              style: AppTextTheme.body2.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)));
                    } else {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: state.viewModel.listSpo2?.length,
                        itemBuilder: (context, index) {
                          return Spo2CellWidget(
                            historyBloc: historyBloc,
                            response: state.viewModel.listSpo2?[index],
                          );
                        },
                      );
                    }
                  }
                  //? Failure
                  if (state.status == BlocStatusState.failure) {
                    return Center(
                      child: Text(
                        state.viewModel.errorMessage!,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: AppTextTheme.body2.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.screenWidth * 0.05),
                      ),
                    );
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
