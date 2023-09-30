part of 'blood_sugar_history_screen.dart';

extension BloodSugarHistoryScreenAction on BloodSugarHistoryScreenState {
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
    }  if (state is WifiDisconnectState &&
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

  Future<void> onGetBloodSugarData() async {
    historyBloc.add(GetBloodSugarHistoryDataEvent(
        endTime: dateTo, startTime: dateFrom, id: widget.id));
  }

  Future<void> onGetBloodSugarInitData() async {
    historyBloc.add(GetBloodSugarHistoryInitDataEvent(
        endTime: dateTo, startTime: dateFrom, id: widget.id));
  }

  Future<void> _onBloodSugarRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    await onGetBloodSugarData();
  }

  
}
