import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../classes/language_constant.dart';
import '../../common_widget/screen_form/custom_screen_form.dart';

//Class Home
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _PatientListState();
}

class _PatientListState extends State<NotificationScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return CustomScreenForm(
        isShowAppBar: true,
        isShowLeadingButton: false,
        isShowBottomNayvigationBar: true,
        isShowRightButon: false,
        backgroundColor: AppColor.backgroundColor,
        appBarColor: AppColor.topGradient,

        // rightButton: IconButton(
        //   onPressed: gotoRegistPatientScreen,
        //   icon: const Icon(Icons.add),
        title: translation(context).patientList,
        // ),
        selectedIndex: 0,
        child: Container());
  }
}
