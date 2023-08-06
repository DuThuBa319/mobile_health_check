import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:common_project/presentation/modules/history/widget/blood_pressure_cell.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/enum_common.dart';
import '../../common_widget/loading_widget.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/theme_color.dart';
import 'bloc/history_bloc.dart';
part 'history_screen.action.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  final _refreshController = RefreshController(initialRefresh: false);
  DateTime dateFrom = DateTime.now().add(const Duration(days: -1));
  DateTime dateTo = DateTime.now();
  String strDateFrom = DateFormat('dd/MM/yyyy')
      .format(DateTime.now().add(const Duration(days: -1)));
  String strDateTo = DateFormat('dd/MM/yyyy').format(DateTime.now());
  HistoryBloc get historyBloc => BlocProvider.of(context);
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return CustomScreenForm(
      title: 'History',
      isShowAppBar: true,
      isShowBottomNayvigationBar: true,
      isShowLeadingButton: true,
      appBarColor: AppColor.appBarColor,
      backgroundColor: AppColor.backgroundColor,
      leadingButton: const Icon(Icons.menu),
      selectedIndex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          Text('Date Range Picker',
              style: AppTextTheme.body2.copyWith(fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  selectedDate(isSelectedDateFrom: true);
                },
                child: Container(
                    width: screenWidth * 0.37,
                    height: screenHeight * 0.055,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 71, 200, 255),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.calendar_month,
                            color: Colors.white, size: 30),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(strDateFrom,
                              style: AppTextTheme.body4
                                  .copyWith(color: Colors.white)),
                        )
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
                    width: screenWidth * 0.37,
                    height: screenHeight * 0.055,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 71, 200, 255),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.calendar_month,
                            color: Colors.white, size: 30),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(strDateTo,
                              style: AppTextTheme.body4
                                  .copyWith(color: Colors.white)),
                        )
                      ],
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              if (dateFrom.isAfter(dateTo)) {
                showAlertDialog(context);
              } else {
                onGetHistoryData();
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: screenWidth * 0.37,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(255, 71, 200, 255),
              ),
              child: Text(
                'Search',
                style: AppTextTheme.title3.copyWith(color: Colors.white),
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
                    //onGetHistoryData();
                    return Center(
                        child: Text('Vui lòng chọn thông tin',
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
                      return Container(
                        margin: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: state.viewModel.listBloodPressure!.length,
                          itemBuilder: (context, index) {
                            return BloodPressureCellWidget(
                              historyBloc: historyBloc,
                              response:
                                  state.viewModel.listBloodPressure![index],
                            );
                          },
                        ),
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
