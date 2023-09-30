// ignore_for_file: invalid_use_of_protected_member

part of 'temperature_history_screen.dart';

extension TemperatureHistoryScreenAction on TemperatureHistoryScreenState {
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
        setState(() {});
      } else {
        dateTo = datePicker;
        strDateTo = DateFormat('dd/MM/yyyy').format(datePicker);
        setState(() {});
      }
    }
  }

  Future<void> onGetTemperatureData() async {
    historyBloc.add(GetTemperatureHistoryDataEvent(
        endTime: dateTo, startTime: dateFrom, id: widget.id));
  }

  Future<void> onGetTemperatureInitData() async {
    historyBloc.add(GetTemperatureHistoryInitDataEvent(
        endTime: dateTo, startTime: dateFrom, id: widget.id));
  }

  Future<void> _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    await onGetTemperatureData();
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
