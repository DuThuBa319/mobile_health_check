part of 'history_screen.dart';

extension HistoryScreenAction on HistoryScreenState {
  void blocListener(BuildContext context, HistoryState state) {
    // logger.d('change state', state);
    // _refreshController
    //   ..refreshCompleted()
    //   ..loadComplete();

    if (state is GetHistoryDataState &&
        state.status == BlocStatusState.loading) {
      showToast('Đang tải dữ liệu');
      //   );
    }
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
        setState(() {});
      } else {
        dateTo = datePicker;
        strDateTo = DateFormat('dd/MM/yyyy').format(datePicker);
        setState(() {});
      }
    }
  }

  Future<void> onGetHistoryData() async {
    historyBloc.add(GetHistoryDataEvent(endDate: dateTo, startDate: dateFrom));
  }

  Future<void> _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    await onGetHistoryData();
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
