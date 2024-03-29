// ignore_for_file: invalid_use_of_protected_member

part of 'temperature_history_screen.dart';

extension TemperatureHistoryScreenAction on TemperatureHistoryScreenState {
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
      textNegativeButton: translation(context).back,
      textPositiveButton: translation(context).accept,
      styleYearPicker: MaterialRoundedYearPickerStyle(
        textStyleYear: TextStyle(
            fontSize: SizeConfig.screenWidth * 0.05, color: Colors.grey),
        textStyleYearSelected: TextStyle(
            fontSize: SizeConfig.screenWidth * 0.06,
            color: const Color.fromARGB(255, 66, 187, 248),
            fontWeight: FontWeight.bold),
        heightYearRow: SizeConfig.screenHeight * 0.06,
        backgroundPicker: Colors.white,
      ),
      styleDatePicker: MaterialRoundedDatePickerStyle(
          sizeArrow: SizeConfig.screenHeight * 0.04,
          backgroundHeader: const Color.fromARGB(255, 66, 187, 248),
          decorationDateSelected: const BoxDecoration(
              color: Color.fromARGB(255, 66, 187, 248), shape: BoxShape.circle),
          backgroundPicker: AppColor.white,
          backgroundActionBar: AppColor.white,
          backgroundHeaderMonth: AppColor.white,
          colorArrowNext: Colors.black,
          colorArrowPrevious: Colors.black,
          textStyleDayOnCalendarDisabled: TextStyle(
            fontSize: SizeConfig.screenWidth * 0.04,
          ),
          textStyleYearButton: TextStyle(
              color: AppColor.white,
              fontSize: SizeConfig.screenWidth * 0.04,
              fontWeight: FontWeight.bold),
          paddingActionBar:
              EdgeInsets.only(right: SizeConfig.screenWidth * 0.01),
          textStyleButtonNegative: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: SizeConfig.screenWidth * 0.05,
            color: AppColor.gray767676,
          ),
          textStyleButtonPositive: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.screenWidth * 0.05,
              color: Color.fromARGB(255, 8, 154, 227)),
          textStyleDayOnCalendarSelected: TextStyle(
              fontSize: SizeConfig.screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              color: AppColor.white),
          textStyleMonthYearHeader: TextStyle(
              fontSize: SizeConfig.screenWidth * 0.025,
              fontWeight: FontWeight.bold),
          textStyleCurrentDayOnCalendar: TextStyle(
              fontSize: SizeConfig.screenWidth * 0.032,
              fontWeight: FontWeight.bold),
          textStyleDayButton: TextStyle(
              color: AppColor.white,
              fontSize: SizeConfig.screenWidth * 0.04,
              fontWeight: FontWeight.bold),
          textStyleDayHeader: TextStyle(
              fontSize: SizeConfig.screenWidth * 0.035,
              fontWeight: FontWeight.bold),
          textStyleDayOnCalendar: TextStyle(
            fontSize: SizeConfig.screenWidth * 0.03,
          )),
      height: SizeConfig.screenHeight * 0.55,
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
