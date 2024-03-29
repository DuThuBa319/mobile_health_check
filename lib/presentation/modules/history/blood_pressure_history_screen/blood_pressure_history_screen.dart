import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/utils/size_config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../classes/language.dart';
import '../../../common_widget/common.dart';
import '../../../theme/app_text_theme.dart';
import '../../../theme/theme_color.dart';
import '../history_bloc/history_bloc.dart';
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
          SizedBox(height: SizeConfig.screenHeight * 0.005),
          Container(
            margin: EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.025,
                ),
                Text(
                  translation(context).selectTime,
                  style: TextStyle(
                      fontSize: SizeConfig.screenDiagonal * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                lineDecor(
                  spaceTop: SizeConfig.screenHeight * 0.0025,
                  spaceBottom: SizeConfig.screenHeight * 0.025,
                ),
              ],
            ),
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
                        border: Border.all(
                            width: SizeConfig.screenDiagonal < 1350 ? 2 : 5,
                            color: AppColor.color43C8F5),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            SizeConfig.screenWidth * 0.015)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: AppColor.color43C8F5,
                          size: SizeConfig.screenHeight * 0.046,
                        ),
                        emptySpace(SizeConfig.screenWidth * 0.01),
                        Text(strTimeFrom,
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
                        border: Border.all(
                            width: SizeConfig.screenDiagonal < 1350 ? 2 : 5,
                            color: AppColor.color43C8F5),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            SizeConfig.screenWidth * 0.015)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: AppColor.color43C8F5,
                          size: SizeConfig.screenHeight * 0.046,
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
          SizedBox(
            height: SizeConfig.screenHeight * 0.015,
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
                  onGetBloodPressureData();
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: SizeConfig.screenWidth * 0.4,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 0.015),
                  color: const Color.fromARGB(255, 71, 200, 255),
                ),
                child: Text(
                  translation(context).search,
                  style: AppTextTheme.title3.copyWith(
                    color: Colors.white,
                    fontSize: SizeConfig.screenDiagonal * 0.022,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.025),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              header: const WaterDropHeader(),
              child: BlocConsumer<HistoryBloc, HistoryState>(
                listener: blocListener,
                builder: (context, state) {
                  //? Init
                  if (state is HistoryInitialState) {
                    return Center(
                        child: Text(translation(context).selectTime,
                            style: AppTextTheme.body2.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: SizeConfig.screenDiagonal * 0.025)));
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
                    if (state.viewModel.listBloodPressure!.isEmpty) {
                      return Center(
                          child: Text(translation(context).noData,
                              style: AppTextTheme.body2.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize:
                                      SizeConfig.screenDiagonal * 0.025)));
                    }
                    if (state.viewModel.listBloodPressure!.isEmpty) {
                      return Center(
                          child: Text(translation(context).error,
                              style: AppTextTheme.body2.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize:
                                      SizeConfig.screenDiagonal * 0.025)));
                    } else {
                      return ListView.builder(
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
