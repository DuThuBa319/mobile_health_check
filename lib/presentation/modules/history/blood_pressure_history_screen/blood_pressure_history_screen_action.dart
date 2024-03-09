part of 'blood_pressure_history_screen.dart';

extension BloodPressureHistoryScreenAction on BloodPressureHistoryScreenState {
  void blocListener(BuildContext context, HistoryState state) {
    //? Loading
    if (state.status == BlocStatusState.loading) {
    }
    //? Success
    if (state.status == BlocStatusState.success) {
      if (state is GetHistoryDataState) {
        showToast( context: context,
                            status: ToastStatus.success,
                            toastString:translation(context).dataLoaded);
        
      }
    }
    //? Failure
    if (state.status == BlocStatusState.failure) {
      showToast( context: context,
                            status: ToastStatus.error,
                            toastString:state.viewModel.errorMessage);
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

  // Future<void> onGetBloodPressureInitData() async {
  //   historyBloc.add(GetBloodPressureHistoryInitDataEvent(
  //       endTime: timeTo, id: widget.id, startTime: timeFrom));
  // }

  Future<void> _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    await onGetBloodPressureData();
  }
}
