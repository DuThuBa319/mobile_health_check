part of 'spo2_history_screen.dart';

extension Spo2HistoryScreenAction on Spo2HistoryScreenState {
  void blocListener(BuildContext context, HistoryState state) {
    //? Loading
    if (state.status == BlocStatusState.loading) {}
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
    final timePicker = await showRoundedDatePicker(
      styleDatePicker: MaterialRoundedDatePickerStyle(
          backgroundHeader: AppColor.appBarColor,
          decorationDateSelected: BoxDecoration(
              color: AppColor.topGradient, shape: BoxShape.circle),
          backgroundPicker: AppColor.white,
          backgroundActionBar: AppColor.white,
          backgroundHeaderMonth: AppColor.white,
          colorArrowNext: Colors.black,
          colorArrowPrevious: Colors.black,
          textStyleDayOnCalendarDisabled:
              TextStyle(fontSize: SizeConfig.screenWidth * 0.035),
          textStyleYearButton:
              TextStyle(fontSize: SizeConfig.screenWidth * 0.035),
          textStyleButtonNegative:
              TextStyle(fontSize: SizeConfig.screenWidth * 0.03),
          textStyleButtonPositive:
              TextStyle(fontSize: SizeConfig.screenWidth * 0.03),
          textStyleDayOnCalendarSelected:
              TextStyle(fontSize: SizeConfig.screenWidth * 0.04),
          textStyleMonthYearHeader:
              TextStyle(fontSize: SizeConfig.screenWidth * 0.04),
          textStyleCurrentDayOnCalendar:
              TextStyle(fontSize: SizeConfig.screenWidth * 0.035),
          textStyleDayButton:
              TextStyle(fontSize: SizeConfig.screenWidth * 0.035),
          textStyleDayHeader:
              TextStyle(fontSize: SizeConfig.screenWidth * 0.038),
          textStyleButtonAction:
              TextStyle(fontSize: SizeConfig.screenWidth * 0.03),
          textStyleDayOnCalendar: TextStyle(
            fontSize: SizeConfig.screenWidth * 0.035,
          )),
      height: SizeConfig.screenHeight * 0.45,
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
