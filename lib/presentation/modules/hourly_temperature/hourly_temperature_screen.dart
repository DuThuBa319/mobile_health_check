import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:common_project/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/hourly_temperarute_bloc/hourly_temperature_bloc.dart';
import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/enum_common.dart';
import '../../common_widget/loading_widget.dart';
import '../../theme/app_text_theme.dart';
import 'widget/hourly_temperature_cell.dart';
part 'hourly_temperature_screen.action.dart';

class HourlyTemperatureScreen extends StatefulWidget {
  const HourlyTemperatureScreen({Key? key}) : super(key: key);

  @override
  State<HourlyTemperatureScreen> createState() =>
      _HourlyTemperatureScreenState();
}

class _HourlyTemperatureScreenState extends State<HourlyTemperatureScreen> {
  TextEditingController longitude = TextEditingController();
  TextEditingController latitude = TextEditingController();
  DateTime dateFrom = DateTime.now();
  DateTime dateTo = DateTime.now().add(const Duration(days: 1));
  TextEditingController dateSet = TextEditingController();
  String strDateFrom = DateFormat('dd/MM').format(DateTime.now());

  String strDateTo =
      DateFormat('dd/MM').format(DateTime.now().add(const Duration(days: 1)));

  @override
  HourlyTemperatureBloc get bloc => BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HourlyTemperatureBloc, HourlyTemperatureState>(
      listener: _blocListener,
      builder: (context, state) {
        return CustomScreenForm(
          appBarColor: AppColor.appBarColor,
          backgroundColor: Colors.white,
          isShowAppBar: true,
          isShowLeadingButton: true,
          title: 'Hourly Temperature API Screen',
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                DefaultTextStyle(
                  style: AppTextTheme.body2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: selectedDate,
                          icon: const Icon(Icons.calendar_month_outlined)),
                      Text(strDateFrom)
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
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                        controller: longitude,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                InkWell(
                  onTap: onGetWeatherAndTemperature,
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
                    if (state is GetHourlyTemperatureState &&
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
                              state.viewModel.hourlyTemperatureEntity?.length ??
                                  0,
                          itemBuilder: (context, index) {
                            return HourlyTemperatureCell(
                              temperatureEntity: state
                                  .viewModel.hourlyTemperatureEntity?[index],
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
