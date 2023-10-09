import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/classes/language.dart';
import 'package:mobile_health_check/presentation/modules/history/blood_sugar_history_screen/widget/blood_sugar_cell.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../common/singletons.dart';
import '../../../../function.dart';
import '../../../common_widget/dialog/dialog_one_button.dart';
import '../../../common_widget/dialog/show_toast.dart';
import '../../../common_widget/enum_common.dart';
import '../../../common_widget/line_decor.dart';
import '../../../common_widget/loading_widget.dart';
import '../../../common_widget/screen_form/custom_screen_form.dart';
import '../../../theme/app_text_theme.dart';
import '../../../theme/theme_color.dart';
import '../history_bloc/history_bloc.dart';

part 'blood_sugar_history_screen_action.dart';

class BloodSugarHistoryScreen extends StatefulWidget {
  final String? id;

  const BloodSugarHistoryScreen({super.key, this.id});

  @override
  State<BloodSugarHistoryScreen> createState() =>
      BloodSugarHistoryScreenState();
}

class BloodSugarHistoryScreenState extends State<BloodSugarHistoryScreen> {
  final _refreshController = RefreshController(initialRefresh: false);
  DateTime dateFrom = DateTime.now().add(const Duration(days: -1));
  DateTime dateTo = DateTime.now();
  String strDateFrom = DateFormat('dd/MM/yyyy')
      .format(DateTime.now().add(const Duration(days: -1)));
  String strDateTo = DateFormat('dd/MM/yyyy').format(DateTime.now());
  HistoryBloc get historyBloc => BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return CustomScreenForm(
      isRelativeApp:
          (userDataData.getUser()?.role == "relative") ? true : false,
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
                        const Icon(Icons.calendar_month,
                            color: AppColor.color43C8F5, size: 30),
                        Text(strDateFrom,
                            style: AppTextTheme.body4.copyWith(
                                color: AppColor.color43C8F5,
                                fontSize: SizeConfig.screenWidth * 0.05))
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
                        const Icon(Icons.calendar_month,
                            color: AppColor.color43C8F5, size: 30),
                        Text(strDateTo,
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
                if (dateFrom.isAfter(dateTo)) {
                  showNoticeDialog(
                      context: context,
                      message: translation(context).selectError,
                      onClose: () {
                        dateFrom = dateTo;
                        strDateFrom = DateFormat('dd/MM/yyyy').format(dateFrom);
                      },
                      title: translation(context).notification,
                      titleBtn: translation(context).exit);
                } else {
                  onGetBloodSugarData();
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
          SizedBox(height: SizeConfig.screenWidth * 0.05),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: _onBloodSugarRefresh,
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
                  if (state.status == BlocStatusState.loading) {
                    return const Center(
                      child: Loading(
                        brightness: Brightness.light,
                      ),
                    );
                  }
                  if ((state.viewModel.listBloodSugar == null &&
                          state is GetHistoryDataState &&
                          state.status == BlocStatusState.success) ||
                      state.status == BlocStatusState.failure) {
                    return Center(
                        child: Text(translation(context).error,
                            style: AppTextTheme.body2
                                .copyWith(color: Colors.red)));
                  }
                  if (state.status == BlocStatusState.success &&
                      state is GetHistoryDataState) {
                    if (state.viewModel.listBloodSugar!.isEmpty) {
                      //! dịch
                      return Center(
                          child: Text('Không có dữ liệu',
                              style: AppTextTheme.body2
                                  .copyWith(color: Colors.red)));
                    } else {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: state.viewModel.listBloodSugar?.length,
                        itemBuilder: (context, index) {
                          return BloodSugarCellWidget(
                            historyBloc: historyBloc,
                            response: state.viewModel.listBloodSugar?[index],
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
