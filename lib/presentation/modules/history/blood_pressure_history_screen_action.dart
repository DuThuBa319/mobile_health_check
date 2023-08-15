part of 'blood_pressure_history_screen.dart';

extension BloodPressureHistoryScreenAction on BloodPressureHistoryScreenState {
 

  void blocListener(BuildContext context, HistoryState state) {
    // logger.d('change state', state);
    // _refreshController
    //   ..refreshCompleted()
    //   ..loadComplete();

  
    if (state is GetHistoryDataState &&
        state.status == BlocStatusState.success) {
      showToast('Đã tải dữ liệu thành công');
      // Navigator.of(context, rootNavigator: true).pop();
    }
    if (state is GetHistoryDataState &&
        state.status == BlocStatusState.failure) {
      showToast('Tải dữ liệu không thành công');
      // Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void selectedDate({bool isSelectedDateFrom = true}) async {
    final datePicker = await showDatePicker(
      context: context,
      initialDate: isSelectedDateFrom ? dateFrom : dateTo,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (datePicker != null) {
      if (isSelectedDateFrom) {
        dateFrom = datePicker;
        strDateFrom = DateFormat('dd/MM/yyyy').format(datePicker);
        // ignore: invalid_use_of_protected_member
        setState(() {});
      } else {
        dateTo = datePicker;
        strDateTo = DateFormat('dd/MM/yyyy').format(datePicker);
        // ignore: invalid_use_of_protected_member
        setState(() {});
      }
    }
  }

  Future<void> onGetBloodPressureData() async {
    historyBloc.add(
        GetBloodPressureHistoryDataEvent(endDate: dateTo, startDate: dateFrom));
  }

  Future<void> onGetBloodPressureInitData() async {
    historyBloc.add(GetBloodPressureHistoryInitDataEvent());
  }
  // Future<void> onGetBloodSugarData() async {
  //   historyBloc.add(
  //       GetBloodSugarHistoryDataEvent(endDate: dateTo, startDate: dateFrom));
  // }

  // Future<void> onGetTemperatureData() async {
  //   historyBloc.add(
  //       GetTemperatureHistoryDataEvent(endDate: dateTo, startDate: dateFrom));
  // }

  Future<void> _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    await onGetBloodPressureData();
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Attention!!!'),
          content: const Text('Start Date must be before End Date'),
          actions: [
            TextButton(
              onPressed: () {
                dateFrom = dateTo;
                strDateFrom = DateFormat('dd/MM/yyyy').format(dateFrom);
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
