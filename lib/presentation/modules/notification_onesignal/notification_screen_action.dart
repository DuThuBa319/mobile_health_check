part of 'notification_screen.dart';

// ignore: library_private_types_in_public_api
extension NotificationScreenAction on _NotificationListState {
  void _blocListener(BuildContext context, NotificationState state) {
    // logger.d('change state', state);
    // _refreshController
    //   ..refreshCompleted()
    //   ..loadComplete();
    if (state is GetNotificationListState &&
        state.status == BlocStatusState.loading) {
      showToast(translation(context).loadingData);
    }
    if (state is GetNotificationListState &&
        state.status == BlocStatusState.success) {
      showToast(translation(context).dataLoaded);
    }
  }

  void notificationAction(
      OSNotificationClickEvent openedResult, BuildContext context) {
    if (openedResult.notification.additionalData?["Indicator"] ==
        "BloodPressure") {
      int? sys =
          int.parse(openedResult.notification.additionalData?["Systolic"]);
      int? pulse =
          int.parse(openedResult.notification.additionalData?["PlusRate"]);
      String dateString =
          openedResult.notification.additionalData?["UpdatedDate"];
      DateTime updatedDate = DateFormat('M/d/yyyy h:mm:ss a').parse(dateString);
      notificationBloc.add(
        SetReadedNotificationEvent(
          notificationId: openedResult.notification.notificationId,
        ),
      );
      final BloodPressureEntity bloodPressureEntity = BloodPressureEntity(
        imageLink: openedResult.notification.additionalData?["ImageLink"],
        updatedDate: updatedDate,
        sys: sys,
        pulse: pulse,
      );
      showToast(translation(context).waitForSeconds);
      Navigator.pushNamed(context, RouteList.bloodPressuerDetail,
          arguments: bloodPressureEntity);
    }
    if (openedResult.notification.additionalData?["Indicator"] ==
        "BodyTemperature") {
      String dateString =
          openedResult.notification.additionalData?["UpdatedDate"];
      DateTime updatedDate = DateFormat('M/d/yyyy h:mm:ss a').parse(dateString);
      double? value = double.parse(
          openedResult.notification.additionalData?["BodyTemperature"]);
      debugPrint("$value");
      notificationBloc.add(
        SetReadedNotificationEvent(
          notificationId: openedResult.notification.notificationId,
        ),
      );

      final TemperatureEntity temperatureEntity = TemperatureEntity(
        imageLink: openedResult.notification.additionalData?["ImageLink"],
        temperature: value,
        updatedDate: updatedDate,
      );
      showToast(translation(context).waitForSeconds);

      Navigator.pushNamed(context, RouteList.bodyTemperatureDetail,
          arguments: temperatureEntity);
    }
    if (openedResult.notification.additionalData?["Indicator"] ==
        "BloodSugar") {
      String dateString =
          openedResult.notification.additionalData?["UpdatedDate"];
      DateTime updatedDate = DateFormat('M/d/yyyy h:mm:ss a').parse(dateString);
      notificationBloc.add(
        SetReadedNotificationEvent(
          notificationId: openedResult.notification.notificationId,
        ),
      );
      double? value =
          double.parse(openedResult.notification.additionalData?["BloodSugar"]);
      debugPrint("$value");
      final BloodSugarEntity bloodSugarEntity = BloodSugarEntity(
        imageLink: openedResult.notification.additionalData?["ImageLink"],
        bloodSugar: value,
        updatedDate: updatedDate,
      );
      showToast(translation(context).waitForSeconds);
      Navigator.pushNamed(context, RouteList.bloodSugarDetail,
          arguments: bloodSugarEntity);
    }
    if (openedResult.notification.additionalData?["Indicator"] == "SpO2") {
      String dateString =
          openedResult.notification.additionalData?["UpdatedDate"];
      DateTime updatedDate = DateFormat('M/d/yyyy h:mm:ss a').parse(dateString);
      int? value = int.parse(openedResult.notification.additionalData?["SpO2"]);
      notificationBloc.add(
        SetReadedNotificationEvent(
          notificationId: openedResult.notification.notificationId,
        ),
      );
      debugPrint("$value");
      final Spo2Entity spo2Entity = Spo2Entity(
        imageLink: openedResult.notification.additionalData?["ImageLink"],
        spo2: value,
        updatedDate: updatedDate,
      );
      showToast(translation(context).waitForSeconds);
      Navigator.pushNamed(context, RouteList.spo2Detail, arguments: spo2Entity);
    }
  }
}
