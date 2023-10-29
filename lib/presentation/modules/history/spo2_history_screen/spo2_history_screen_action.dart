part of 'spo2_history_screen.dart';

extension Spo2HistoryScreenAction on Spo2HistoryScreenState {
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
      showNoticeDialog(
          context: context,
          message: translation(context).wifiDisconnect,
          title: translation(context).notification,
          titleBtn: translation(context).exit);
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

  Future<void> onGetSpo2Data() async {
    historyBloc.add(GetSpo2HistoryDataEvent(
        endTime: timeTo, startTime: timeFrom, id: widget.id));
  }

  // Future<void> onGetSpo2InitData() async {
  //   historyBloc.add(GetSpo2HistoryInitDataEvent(
  //       endTime: timeTo, startTime: timeFrom, id: widget.id));
  // }

  Future<void> _onSpo2Refresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    await onGetSpo2Data();
  }
}
