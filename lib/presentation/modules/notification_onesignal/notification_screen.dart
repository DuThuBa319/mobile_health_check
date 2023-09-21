import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/domain/entities/blood_sugar_entity.dart';
import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';
import 'package:mobile_health_check/presentation/modules/notification_onesignal/widget/notification_cell.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../classes/language.dart';
import '../../../domain/entities/blood_pressure_entity.dart';
import '../../../domain/entities/spo2_entity.dart';
import '../../../domain/entities/temperature_entity.dart';
import '../../../presentation/common_widget/screen_form/custom_screen_form.dart';
import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/enum_common.dart';
import '../../common_widget/loading_widget.dart';
import '../../route/route_list.dart';
import '../../theme/app_text_theme.dart';
import 'bloc/notification_bloc.dart';
part 'notification_screen_action.dart';

//Class Home
class NotificationScreen extends StatefulWidget {
  final String? id;

  const NotificationScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationScreen> {
  final expandingController = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  // final controller = ScrollController();
  NotificationBloc get notificationBloc => BlocProvider.of(context);
  int lastIndex = -1;
  int startIndex = -50;
  int quantity = 50;
  @override
  void initState() {
    super.initState();
    expandingController.addListener(() {
      if (expandingController.position.maxScrollExtent ==
          expandingController.offset) {
        lastIndex += quantity;
        startIndex += quantity;
        notificationBloc.add(GetNotificationListEvent(
            doctorId: userDataData.getUser()!.id,
            startIndex: startIndex,
            lastIndex: lastIndex));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      event.preventDefault();
      event.notification.display();
      // notificationBloc.add(GetNotificationListEvent(doctorId: widget.id));
    });

    OneSignal.Notifications.addClickListener((openedResult) {
      notificationAction(openedResult, context);

      //!PUT GIẢM SỐ UNREAD COUNT SAU KHI NHẤN VÀO POPUP (lọc theo notificationId)
      // ignore: use_build_context_synchronously

      // ignore: use_build_context_synchronously
    });
    SizeConfig.init(context);
    return CustomScreenForm(
        isShowAppBar: true,
        isShowLeadingButton: true,
        isShowBottomNayvigationBar: true,
        isShowRightButon: false,
        isScrollable: false,
        backgroundColor: AppColor.white,
        appBarColor: AppColor.topGradient,
        title: translation(context).notification,
        selectedIndex: 1,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<NotificationBloc, NotificationState>(
              listener: _blocListener,
              builder: (context, state) {
                if (state is NotificationInitialState
                    //! tạo refreshEvent => refresh notification screen()
                    ) {
                  lastIndex = 49;
                  startIndex = 0;
                  notificationBloc.add(GetNotificationListEvent(
                      doctorId: userDataData.getUser()!.id,
                      startIndex: startIndex,
                      lastIndex: lastIndex));
                }
                if ((state is SetReadedNotificationState &&
                        state.status == BlocStatusState.success) ||
                    (state is DeleteNotificationState &&
                        state.status == BlocStatusState.success)) {
                  notificationBloc.add(GetNotificationListEvent(
                      doctorId: widget.id ?? widget.id!,
                      startIndex: startIndex,
                      lastIndex: lastIndex));
                }
                if ((state is GetNotificationListState &&
                        state.status == BlocStatusState.loading &&
                        state.viewModel.notificationEntity == null) ||
                    (state is DeleteNotificationState &&
                        state.status == BlocStatusState.loading)) {
                  return const Expanded(
                    child: Center(
                      child: Loading(brightness: Brightness.light),
                    ),
                  );
                }

                if ((state is GetNotificationListState &&
                        state.status == BlocStatusState.loading &&
                        state.viewModel.notificationEntity != null) ||
                    (state is GetNotificationListState &&
                        state.status == BlocStatusState.success)) {
                  if (state.viewModel.notificationEntity!.isEmpty) {
                    return Center(
                        child: Text(translation(context).selectTime,
                            style: AppTextTheme.body2
                                .copyWith(color: Colors.red)));
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              TextSpan(
                                text:
                                    "${translation(context).unreadNotifications}:",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.screenWidth * 0.06),
                              ),
                              TextSpan(
                                  text: " ${state.viewModel.unreadCount}",
                                  style: AppTextTheme.body1.copyWith(
                                      color: AppColor.redFB4B53,
                                      fontSize: SizeConfig.screenWidth * 0.08,
                                      fontWeight: FontWeight.w500)),
                            ])),
                        const SizedBox(
                          height: 2,
                        ),
                        lineDecor(),
                        Expanded(
                          child: SmartRefresher(
                              controller: _refreshController,
                              header: const WaterDropHeader(),
                              onRefresh: () async {
                                await Future.delayed(
                                    const Duration(milliseconds: 1000));
                                _refreshController.refreshCompleted();
                                notificationBloc.add(GetNotificationListEvent(
                                    doctorId: widget.id ?? widget.id!,
                                    startIndex: startIndex,
                                    lastIndex: lastIndex));
                              },
                              child: ListView.builder(
                                  controller: expandingController,
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: state.viewModel.notificationEntity!
                                          .length +
                                      1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index <
                                        state.viewModel.notificationEntity!
                                            .length) {
                                      return NotificationCell(
                                        notificationEntity: state.viewModel
                                            .notificationEntity![index],
                                        notificationBloc: notificationBloc,
                                      );
                                    } else {
                                      return const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 32),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                  })),
                        ),
                      ],
                    );
                  }
                }

                return Container();
              }),
        ));
  }
}
