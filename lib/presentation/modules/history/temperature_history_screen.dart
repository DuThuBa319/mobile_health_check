import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/presentation/modules/history/widget/temperature_cell.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/enum_common.dart';
import '../../common_widget/loading_widget.dart';
import '../../common_widget/screen_form/custom_screen_form.dart';
import '../../route/route_list.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/theme_color.dart';
import 'bloc/history_bloc.dart';
part 'temperature_history_screen_action.dart';

class TemperatureScreen extends StatefulWidget {
  const TemperatureScreen({super.key});

  @override
  State<TemperatureScreen> createState() => TemperatureScreenState();
}

class TemperatureScreenState extends State<TemperatureScreen> {
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      leadingButton: IconButton(
          onPressed: () => Navigator.pushNamed(context, RouteList.home),
          icon: const Icon(Icons.arrow_back)),
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
                const Text(
                  'Chọn các mốc thời gian',
                  style: TextStyle(
                      fontSize: 24,
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
                    width: screenWidth * 0.40,
                    height: screenHeight * 0.055,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: AppColor.color43C8F5),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.calendar_month,
                            color: AppColor.color43C8F5, size: 30),
                        const SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(strDateFrom,
                              style: AppTextTheme.body4.copyWith(
                                  color: AppColor.color43C8F5, fontSize: 20)),
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
                    width: screenWidth * 0.40,
                    height: screenHeight * 0.055,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: AppColor.color43C8F5),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.calendar_month,
                            color: AppColor.color43C8F5, size: 30),
                        const SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(strDateTo,
                              style: AppTextTheme.body4.copyWith(
                                  color: AppColor.color43C8F5, fontSize: 20)),
                        )
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
                  showAlertDialog(context);
                } else {
                  onGetTemperatureData();
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
                  'tìm kiếm',
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
                    onGetTemperatureInitData();
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
                  if ((state.viewModel.listTemperature == null &&
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
                    if (state.viewModel.listTemperature!.isEmpty) {
                      return Center(
                          child: Text('Không có dữ liệu',
                              style: AppTextTheme.body2
                                  .copyWith(color: Colors.red)));
                    } else {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: ListView.builder(
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
