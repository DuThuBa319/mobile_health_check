part of 'blood_pressure_history_screen.dart';

extension BloodPressureHistoryScreenAction on BloodPressureHistoryScreenState {
  void blocListener(BuildContext context, HistoryState state) {
    // logger.d('change state', state);
    // _refreshController
    //   ..refreshCompleted()
    //   ..loadComplete();
    if (state is GetHistoryDataState &&
        state.status == BlocStatusState.loading) {
      showToast(translation(context).loadingData);
      //   );
    }
    if (state is GetHistoryDataState &&
        state.status == BlocStatusState.success) {
      showToast(translation(context).dataLoaded);
      // Navigator.of(context, rootNavigator: true).pop();
    }
    if (state is GetHistoryDataState &&
        state.status == BlocStatusState.failure) {
      showToast(translation(context).loadingError);
      // Navigator.of(context, rootNavigator: true).pop();
    }
    if (state is WifiDisconnectState &&
        state.status == BlocStatusState.success) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                translation(context).notification,
                style: TextStyle(
                    color: AppColor.lineDecor,
                    fontSize: SizeConfig.screenWidth * 0.08,
                    fontWeight: FontWeight.bold),
              ),
              content: Text(
                translation(context).wifiDisconnect,
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: SizeConfig.screenWidth * 0.05,
                    fontWeight: FontWeight.w400),
              ),
              actions: [
                TextButton(
                  child: Text(translation(context).accept),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }
  }

  void selectedDate({bool isSelectedDateFrom = true}) async {
    final timePicker = await showDatePicker(
      context: context,
      initialDate: isSelectedDateFrom ? timeFrom : timeTo,
      firstDate: DateTime(2000),
      lastDate: DateTime(2200),
    );
    if (timePicker != null) {
      if (isSelectedDateFrom) {
        timeFrom = timePicker.add(const Duration(hours: 00, minutes: 00));
        strTimeFrom = DateFormat('dd/MM/yyyy')
            .format(timePicker.add(const Duration(hours: 00, minutes: 00)));
        // ignore: invalid_use_of_protected_member
        setState(() {});
      } else {
        timeTo = timePicker.add(const Duration(hours: 23, minutes: 59));
        strTimeTo = DateFormat('dd/MM/yyyy')
            .format(timePicker.add(const Duration(hours: 23, minutes: 59)));

        // ignore: invalid_use_of_protected_member
        setState(() {});
      }
    }
  }

  Future<void> onGetBloodPressureData() async {
    historyBloc.add(GetBloodPressureHistoryDataEvent(
        endTime: timeTo, id: widget.id, startTime: timeFrom));
  }

  Future<void> onGetBloodPressureInitData() async {
    historyBloc.add(GetBloodPressureHistoryInitDataEvent(
        endTime: timeTo, id: widget.id, startTime: timeFrom));
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
                timeFrom = timeTo;
                strTimeFrom = DateFormat('dd/MM/yyyy').format(timeFrom);
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
