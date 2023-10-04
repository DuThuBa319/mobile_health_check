import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../di/di.dart';
import '../../../domain/entities/blood_pressure_entity.dart';
import '../../../domain/entities/blood_sugar_entity.dart';
import '../../../domain/entities/notificaion_onesignal_entity.dart';
import '../../../domain/entities/spo2_entity.dart';
import '../../../domain/entities/temperature_entity.dart';
import '../../../presentation/modules/notification_onesignal/bloc/notification_bloc.dart';
import '../../../presentation/route/route_list.dart';
import '../navigation/navigation_service.dart';

@Singleton()
class OneSignalNotificationService {
  OneSignalNotificationService._();

  // final _inAppNotificationController =
  //     StreamController<NotificationModel>.broadcast();

  // Stream<NotificationModel> get onReceivedNotification =>
  //     _inAppNotificationController.stream;

  @factoryMethod
  static Future<OneSignalNotificationService> create() async {
    final instance = OneSignalNotificationService._();
    await instance._init();
    return instance;
  }

  Future<void> _init() async {
    if (kDebugMode) {
      await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    }
    await OneSignal.shared.setAppId("eb1e614e-54fe-4824-9c1a-aad236ec92d3");

//Hàm Phía Dưới triển khai khi có thông báo mới từ OneSignal gửi đến

    //Hàm phía dưới triển khai khi nhấn vào POP-UP

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
      if (changes.to.status != OSNotificationPermission.authorized) {
        OneSignal.shared.promptUserForPushNotificationPermission(
          fallbackToSettings: true,
        );
      }
    });

    await OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});
    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
      // setState(() {});
      event.complete(event.notification);
    });
    OneSignal.shared.setNotificationOpenedHandler((openedResult) async {
      await Future.delayed(
          Duration(milliseconds: notificationData.delayTime ?? 1500));
      notificationData.saveDelayTime(0);

      notificationAction(openedResult);
    });
  }

  static Future<void> setUserId(String userId) async {
    if (kIsWeb) {
      return;
    }
    await OneSignal.shared.setExternalUserId(userId);
  }

  static Future<void> setLanguage(String languageCode) async {
    if (kIsWeb) {
      return;
    }
    await OneSignal.shared.setLanguage(languageCode);
  }

  static Future<void> removeUserId() async {
    if (kIsWeb) {
      return;
    }
    await OneSignal.shared.removeExternalUserId();
  }

  static Future<Map<String, dynamic>> setTags(Map<String, dynamic> tags) {
    return OneSignal.shared.sendTags(tags);
  }

  static Future<Map<String, dynamic>> deleteTags(List<String> keys) {
    return OneSignal.shared.deleteTags(keys);
  }

  static void subscribeNotification({required String userId}) {
    // if (user.id == null) {
    //   return;
    // }

    OneSignal.shared.setExternalUserId(userId);
    
if(userDataData.getUser()!.role! == 'doctor'){
  OneSignal.shared.sendTag("role", "doctor");
    OneSignal.shared.sendTag("doctorId", userId);
}
  else if(userDataData.getUser()!.role! == 'relative'){
  OneSignal.shared.sendTag("role", "relative");
    OneSignal.shared.sendTag("relativeId", userId);
}
  }

  static void unsubscribeFromNotifications({required String doctorId}) {
    // Clear any tags and external user ID
    if(userDataData.getUser()!.role! == 'doctor'){
  OneSignal.shared.deleteTags(["role", "doctorId"]);
    OneSignal.shared.removeExternalUserId();
}
   else if(userDataData.getUser()!.role! == 'relative'){
  OneSignal.shared.deleteTags(["role", "relativeId"]);
    OneSignal.shared.removeExternalUserId();
}

    // Unsubscribe the user from notifications
  }
}

// @Singleton()
// class OneSignalNotificationService {
//   OneSignalNotificationService._();

//   @factoryMethod
//   static Future<OneSignalNotificationService> create() async {
//     final instance = OneSignalNotificationService._();
//     await instance._init();
//     return instance;
//   }

//   Future<void> _init() async {
//     if (kDebugMode) {
//       await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

//     }
//     OneSignal.initialize("eb1e614e-54fe-4824-9c1a-aad236ec92d3");

//     OneSignal.Notifications.requestPermission(
//         true); //!Hàm này yêu cầu người dùng cho phép ứng dụng gửi thông báo đẩy.
//     OneSignal.Notifications.addForegroundWillDisplayListener((event) {
//       //setState(() {});
//       event.preventDefault();
//       event.notification.display();
//     });
//     OneSignal.Notifications.addClickListener((openedResult) async {
//       await Future.delayed(
//           Duration(milliseconds: notificationData.delayTime ?? 1500));
//       notificationData.saveDelayTime(0);

//       notificationAction(openedResult);
//     });
//   }

//   static Future<void> setUserId(String userId) async {
//     if (kIsWeb) {
//       return;
//     }
//     await OneSignal.User.addAlias('doctor', userId);
//   }

//   static Future<void> setLanguage(String languageCode) async {
//     if (kIsWeb) {
//       return;
//     }
//     await OneSignal.User.setLanguage(languageCode);
//   }

//   static Future<void> removeUserId() async {
//     if (kIsWeb) {
//       return;
//     }
//   }

//   static void subscribeNotification({required String userId}) {
//     // if (user.id == null) {
//     //   return;
//     // }

//     OneSignal.User.addAlias('doctor', userId);
//     // OneSignal.shared.sendTag('email', user.email);
//     // OneSignal.shared.sendTag('userId', user.id);
//     // OneSignal.shared.setExternalUserId("240914");

//     OneSignal.User.addTags({"role": "doctor", "doctorId": userId});
//     OneSignal.User.pushSubscription.optIn();
//   }

//   static Future<void> unsubscribeFromNotifications(
//       {required String doctorId}) async {
//     // Clear any tags and external user ID
//     await OneSignal.User.removeTags(["role", "doctorId"]);
//     await OneSignal.User.removeAlias('doctor');
//     OneSignal.User.pushSubscription.optOut();
//     // Unsubscribe the user from notifications
//   }
// }

void notificationAction(OSNotificationOpenedResult openedResult) {
  NotificationBloc notificationBloc = getIt<NotificationBloc>();
  NavigationService navigationService = injector<NavigationService>();
  //!---------Blood Pressure------------------//
  if (openedResult.notification.additionalData?["Indicator"] ==
      "BloodPressure") {
    String? patientId = openedResult.notification.additionalData?["patientId"];

    String? patientName =
        openedResult.notification.additionalData?["PatientName"];
    int? sys = int.parse(openedResult.notification.additionalData?["Systolic"]);
    int? pulse =
        int.parse(openedResult.notification.additionalData?["PulseRate"]);
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
    final NotificationEntity notificationEntity = NotificationEntity(
        bloodPressureEntity: bloodPressureEntity,
        patientName: patientName,
        patientId: patientId,
        sendDate: updatedDate);

    navigationService
        .navigateTo(RouteList.bloodPressuerNotificationReading, argument: {
      "notificationEntity": notificationEntity,
      "navigateFromCell": false,
    });
  }
  //!---------Body Temperature------------------//

  if (openedResult.notification.additionalData?["Indicator"] ==
      "BodyTemperature") {
    String? patientId = openedResult.notification.additionalData?["patientId"];
    String? patientName =
        openedResult.notification.additionalData?["PatientName"];
    String dateString =
        openedResult.notification.additionalData?["UpdatedDate"];
    DateTime updatedDate = DateFormat('M/d/yyyy h:mm:ss a').parse(dateString);
    double? value = double.parse(
        openedResult.notification.additionalData?["BodyTemperature"]);
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
    final NotificationEntity notificationEntity = NotificationEntity(
        bodyTemperatureEntity: temperatureEntity,
        patientName: patientName,
        patientId: patientId,
        sendDate: updatedDate);
    // showToast(translation(context).waitForSeconds);

    navigationService.navigateTo(RouteList.bodyTemperatureNotificationReading,
        argument: {
          "notificationEntity": notificationEntity,
          "navigateFromCell": false
        });
  }
  //!---------Blood Sugar------------------//

  if (openedResult.notification.additionalData?["Indicator"] == "BloodSugar") {
    String? patientId = openedResult.notification.additionalData?["patientId"];
    String? patientName =
        openedResult.notification.additionalData?["PatientName"];
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
    final BloodSugarEntity bloodSugarEntity = BloodSugarEntity(
      imageLink: openedResult.notification.additionalData?["ImageLink"],
      bloodSugar: value,
      updatedDate: updatedDate,
    );
    final NotificationEntity notificationEntity = NotificationEntity(
        bloodSugarEntity: bloodSugarEntity,
        patientName: patientName,
        patientId: patientId,
        sendDate: updatedDate);
    navigationService.navigateTo(RouteList.bloodSugarNotificationReading,
        argument: {
          "notificationEntity": notificationEntity,
          "navigateFromCell": false
        });
  }
  //!---------Spo2------------------//

  if (openedResult.notification.additionalData?["Indicator"] == "SpO2") {
    String? patientId = openedResult.notification.additionalData?["patientId"];
    String? patientName =
        openedResult.notification.additionalData?["PatientName"];
    String dateString =
        openedResult.notification.additionalData?["UpdatedDate"];
    DateTime updatedDate = DateFormat('M/d/yyyy h:mm:ss a').parse(dateString);
    int? value = int.parse(openedResult.notification.additionalData?["SpO2"]);
    notificationBloc.add(
      SetReadedNotificationEvent(
        notificationId: openedResult.notification.notificationId,
      ),
    );
    final Spo2Entity spo2Entity = Spo2Entity(
      imageLink: openedResult.notification.additionalData?["ImageLink"],
      spo2: value,
      updatedDate: updatedDate,
    );

    final NotificationEntity notificationEntity = NotificationEntity(
        spo2Entity: spo2Entity,
        patientName: patientName,
        patientId: patientId,
        sendDate: updatedDate);
    navigationService.navigateTo(RouteList.spo2NotificationReading, argument: {
      "notificationEntity": notificationEntity,
      "navigateFromCell": false
    });
  }
}
