part of 'patients_list_screen.dart';

extension UserListScreenAction on _UserListState {
  void _blocListener(BuildContext context, GetUserState state) {
    // logger.d('change state', state);
    // _refreshController
    //   ..refreshCompleted()
    //   ..loadComplete();
    if (state is GetListUserState && state.status == BlocStatusState.loading) {
      showToast('Loading');
    }
    if (state is GetListUserState && state.status == BlocStatusState.success) {
      showToast('Loaded');
    }
    if (state is RegistUserState && state.status == BlocStatusState.success) {
      showToast('Regist User successfully');
      userBloc.add(GetListUserEvent());
      Navigator.pop(context);
    }
  }

//   void gotoRegistUserScreen() {
//     Navigator.pushNamed(context, RouteList.registUser, arguments: userBloc);
//   }

//   void initOneSignal() {
//     //Remove this method to stop OneSignal Debugging
//     OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
//     OneSignal.initialize("eb1e614e-54fe-4824-9c1a-aad236ec92d3");
// // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
//     // final status = await Permission.notification.request();
//     // if (status.isDenied) {
//     //   await Permission.notification.request();
//     //   showToast("Bạn chưa bật cho phép thông báo");
//     //   //SHOW DIALOG with 2 button => setting and cancel, if user press "setting" =>  final status = await OneSignal.Notifications.requestPermission(true);
//     //   // We didn't ask for permission yet or the permission has been denied before but not permanently.
//     //   //  await openAppSettings(); ==> nằm trong Dialog làm phía trên
//     // }

//     OneSignal.User.pushSubscription.addObserver((state) {
//       print(state.current.jsonRepresentation());
//     });

//     OneSignal.Notifications.addPermissionObserver((state) {
//       print("Has permission $state");
//     });
//     OneSignal.Notifications.addClickListener((event) {
//       print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
//       // Navigator.pushNamed(, routeName)
//     });

//     OneSignal.Notifications.addForegroundWillDisplayListener((event) {
//       /// preventDefault to not display the notification
//       event.preventDefault();

//       /// Do async work
//       // debugPrint("^^${event.notification.body}");

//       /// notification.display() to display after preventing default
//       event.notification.display();
//     });
//   }
}
