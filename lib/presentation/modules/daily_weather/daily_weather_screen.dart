import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:common_project/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/daily_weather_bloc/daily_weather_bloc.dart';
import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/enum_common.dart';
import '../../common_widget/loading_widget.dart';
import '../../theme/app_text_theme.dart';
import 'widget/daily_weather_cell.dart';
part 'daily_weather_screen.action.dart';

class DailyWeatherScreen extends StatefulWidget {
  const DailyWeatherScreen({Key? key}) : super(key: key);

  @override
  State<DailyWeatherScreen> createState() => _DailyWeatherScreenState();
}

class _DailyWeatherScreenState extends State<DailyWeatherScreen> {
  TextEditingController longtitude = TextEditingController();
  TextEditingController latitude = TextEditingController();
  DateTime dateFrom = DateTime.now();
  DateTime dateTo = DateTime.now().add(const Duration(days: 1));
  String strDateFrom = DateFormat('dd/MM').format(DateTime.now());
  String strDateTo =
      DateFormat('dd/MM').format(DateTime.now().add(const Duration(days: 1)));

  @override
  DailyWeatherBloc get bloc => BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DailyWeatherBloc, DailyWeatherState>(
      listener: _blocListener,
      builder: (context, state) {
        final theme = Theme.of(context);
        return CustomScreenForm(
          appBarColor: AppColor.appBarColor,
          backgroundColor: Colors.white,
          isShowAppBar: true,
          isShowLeadingButton: true,
          selectedIndex: 3,
          isShowBottomNayvigationBar: true,
          title: 'Daily Weather API Screen',
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child:
                      // Text(
                      //   'Thời tiết từ ngày 01/01 đến 08/02',
                      //   style: theme.textTheme.headlineSmall,
                      // ),
                      Column(
                    children: [
                      DefaultTextStyle(
                        style: AppTextTheme.body2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Thời tiết từ ngày '),
                            InkWell(
                              onTap: selectedDate,
                              child: Text('$strDateFrom '),
                            ),
                            const Text('đến ngày '),
                            InkWell(
                              onTap: () {
                                selectedDate(isSelectedDateFrom: false);
                              },
                              child: Text(strDateTo),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: latitude,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontSize: 14,
                                  ),
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Nhập vĩ độ',
                                hintText: '16.125',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: longtitude,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontSize: 14,
                                  ),
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Nhập kinh độ',
                                hintText: '108.125',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: onGetWeather,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.blue03A1E4,
                    ),
                    child: Text(
                      'Lấy dữ liệu',
                      style: AppTextTheme.title4.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (state is GetDailyWeatherState &&
                        state.status == BlocStatusState.loading) {
                      return const Expanded(
                        child: Center(
                          child: Loading(
                            brightness: Brightness.light,
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount:
                              state.viewModel.dailyWeatherEntity?.length ?? 0,
                          itemBuilder: (context, index) {
                            return DailyWeatherCell(
                              weatherEntity:
                                  state.viewModel.dailyWeatherEntity?[index],
                            );
                          },
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
