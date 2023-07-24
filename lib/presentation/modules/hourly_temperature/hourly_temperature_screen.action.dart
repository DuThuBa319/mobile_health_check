part of 'hourly_temperature_screen.dart';

// HẠN CHẾ SETSTATE NHẤT CÓ THỂ, PHẢI THỂ HIỆN ĐƯỢC CÁI STRING
extension HourlyTemperatureScreenAction on _HourlyTemperatureScreenState {
  void _blocListener(BuildContext context, HourlyTemperatureState state) {
    // logger.d('change state', state);
    // _refreshController
    //   ..refreshCompleted()
    //   ..loadComplete();
    if (state is GetHourlyTemperatureState &&
        state.status == BlocStatusState.success) {
      showToast('Đã tải dữ liệu thành công');
    }
  }

  Future<void> onGetWeatherAndTemperature() async {
    final startDate = DateFormat('yyyy-MM-dd').format(dateFrom);
    final endDate = DateFormat('yyyy-MM-dd').format(dateFrom);
    bloc.add(
      GetHourlyTemperatureEvent(
        startDate: startDate,
        endDate: endDate,
        latitude: latitude.text,
        longitude: longitude.text,
      ),
    );
  }

  selectedDate({bool isSelectedDateFrom = true}) async {
    final datePicker = await showDatePicker(
      context: context,
      initialDate: isSelectedDateFrom ? dateFrom : dateTo,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (datePicker != null) {
      setState(() {
        if (isSelectedDateFrom) {
          dateFrom = datePicker;
          strDateFrom = DateFormat('dd/MM').format(datePicker);
        }
      });
    }
  }
}
