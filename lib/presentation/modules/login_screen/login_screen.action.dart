part of 'login_screen.dart';

extension LoginAction on _LoginState {
  Future<void> _blocListener(BuildContext context, LoginState state) async {
    if (state is LoginInitialState && state.status == BlocStatusState.loading) {
      showToast('Đang tải dữ liệu');
    }

    if (state is LoginSuccessState) {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const HomeScreen(),
      //     ));
      Navigator.pushNamed(context, RouteList.patientInfor);
    } else if (state is LoginFailState) {
      final message = state.viewModel.errorMessage ?? '--';

      showNoticeDialog(context: context, message: message);
    }
  }

  Future<void> login() async {
    final userName = _usernameController.text;
    final password = _passwordController.text;
    bloc.add(
      LoginUserEvent(
        username: userName,
        password: password,
      ),
    );
  }

//   Future<void> initOneSignal(BuildContext context) async {
//     //Remove this method to stop OneSignal Debugging
//     OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
//     OneSignal.initialize("eb1e614e-54fe-4824-9c1a-aad236ec92d3");
// // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
//     final status = await Permission.notification.request();
//     if (status.isDenied) {
//       await Permission.notification.request();
//       showToast("Bạn chưa bật cho phép thông báo");
//       //SHOW DIALOG with 2 button => setting and cancel, if user press "setting" =>  final status = await OneSignal.Notifications.requestPermission(true);
//       // We didn't ask for permission yet or the permission has been denied before but not permanently.
//       //  await openAppSettings(); ==> nằm trong Dialog làm phía trên
//     }
//     OneSignal.User.pushSubscription.addObserver((stateChanges) { })
//     String externalId =
//         '24501'; // You will supply the external user id to the OneSignal SDK
//     OneSignal.login(externalId);

//     OneSignal.User.pushSubscription.addObserver((state) {
//       print(state.current.jsonRepresentation());
//       OneSignal.User.addTags({"doctor": "24501"});
//     });

//     OneSignal.Notifications.addPermissionObserver((state) {
//       print("Has permission $state");
//     });
//     OneSignal.Notifications.addClickListener((event) {
//       print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');

//       Navigator.pushNamed(context, RouteList.selectEquip);
//     });

//     OneSignal.Notifications.addForegroundWillDisplayListener((event) {
//       /// preventDefault to not display the notification
//       event.preventDefault();

//       /// Do async work
//       // debugPrint("^^${event.notification.body}");

//       /// notification.display() to display after preventing default
//       event.notification.display();
//     });
//     // OneSignal.InAppMessages.addClickListener((event) {
//     //   print(
//     //       "In App Message Clicked: \n${event.result.jsonRepresentation().replaceAll("\\n", "\n")}");
//     // });
//     // OneSignal.InAppMessages.addWillDisplayListener((event) {
//     //   print("ON WILL DISPLAY IN APP MESSAGE ${event.message.messageId}");
//     // });
//     // OneSignal.InAppMessages.addDidDisplayListener((event) {
//     //   print("ON DID DISPLAY IN APP MESSAGE ${event.message.messageId}");
//     // });
//     // OneSignal.InAppMessages.addWillDismissListener((event) {
//     //   print("ON WILL DISMISS IN APP MESSAGE ${event.message.messageId}");
//     // });
//     // OneSignal.InAppMessages.addDidDismissListener((event) {
//     //   print("ON DID DISMISS IN APP MESSAGE ${event.message.messageId}");
//     // });
//   }
  Future<void> initOneSignal() async {
    await OneSignalNotificationService.create();
    OneSignalNotificationService.subscribeNotification();

    // await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    // await OneSignal.shared.setAppId('eb1e614e-54fe-4824-9c1a-aad236ec92d3');

    // // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    // await OneSignal.shared
    //     .promptUserForPushNotificationPermission()
    //     .then((accepted) {
    //   print('Accepted permission: $accepted');
    // });
    // // final status = await Permission.notification.request();
    // // if (status.isDenied) {
    // //   // We didn't ask for permission yet or the permission has been denied before but not permanently.
    // //   //  await openAppSettings();
    // // }

    // OneSignal.shared.setNotificationWillShowInForegroundHandler(
    //     (OSNotificationReceivedEvent event) {
    //   // Will be called whenever a notification is received in foreground
    //   // Display Notification, pass null param for not displaying the notification
    //   event.complete(event.notification);
    // });

    // OneSignal.shared
    //     .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    //   // Will be called whenever a notification is opened/button pressed.
    // });
    // await OneSignal.shared.postNotification(
    //   OSCreateNotification(playerIds: ['240914,'], content: 'Thong bao'),
    // );
    // OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    //   // Will be called whenever the permission changes
    //   // (ie. user taps Allow on the permission prompt in iOS)
    // });

    // OneSignal.shared
    //     .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    //   // Will be called whenever the subscription changes
    //   // (ie. user gets registered with OneSignal and gets a user ID)
    // });

    // OneSignal.shared.setEmailSubscriptionObserver(
    //     (OSEmailSubscriptionStateChanges emailChanges) {
    //   // Will be called whenever then user's email subscription changes
    //   // (ie. OneSignal.setEmail(email) is called and the user gets registered
    // });
  }
}
