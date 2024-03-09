// ignore_for_file: invalid_use_of_protected_member

part of 'temperature_history_screen.dart';

extension TemperatureHistoryScreenAction on TemperatureHistoryScreenState {
  void blocListener(BuildContext context, HistoryState state) {
    //? Loading
    if (state.status == BlocStatusState.loading) {
   
    }
    //? Success
    if (state.status == BlocStatusState.success) {
      if (state is GetHistoryDataState) {
        showToast(
            context: context,
            status: ToastStatus.success,
            toastString: translation(context).dataLoaded);
        // Navigator.of(context, rootNavigator: true).pop();
      }
    }
    //? Failure
    if (state.status == BlocStatusState.failure) {
      showToast(
          context: context,
          status: ToastStatus.error,
          toastString: state.viewModel.errorMessage);
      // Navigator.of(context, rootNavigator: true).pop();

      // showExceptionDialog(
      //     context: context,
      //     message: state.viewModel.errorMessage!,
      //     titleBtn: translation(context).exit);
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
        setState(() {});
      } else {
        timeTo = timePicker.add(const Duration(hours: 23, minutes: 59));
        strTimeTo = DateFormat('dd/MM/yyyy')
            .format(timePicker.add(const Duration(hours: 23, minutes: 59)));

        setState(() {});
      }
    }
  }

  Future<void> onGetTemperatureData() async {
    historyBloc.add(GetTemperatureHistoryDataEvent(
        endTime: timeTo, startTime: timeFrom, id: widget.id));
  }

  // Future<void> onGetTemperatureInitData() async {
  //   historyBloc.add(GetTemperatureHistoryInitDataEvent(
  //       endTime: timeTo, startTime: timeFrom, id: widget.id));
  // }

  Future<void> _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    await onGetTemperatureData();
  }
}
