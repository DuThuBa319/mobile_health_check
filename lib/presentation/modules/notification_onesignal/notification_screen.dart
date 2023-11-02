import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/modules/admin_screen/bloc/get_doctor_bloc.dart';
import 'package:mobile_health_check/presentation/modules/notification_onesignal/widget/notification_cell.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../classes/language.dart';
import '../../../presentation/common_widget/screen_form/custom_screen_form.dart';
import '../../common_widget/rectangle_button.dart';
import '../../common_widget/dialog/dialog_one_button.dart';
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
  int startIndex = -15;
  int quantity = 15;
  bool loadMore = true;
  String? doctorId = userDataData.getUser()!.id;
  @override
  void initState() {
    super.initState();
    expandingController.addListener(() {
      if ((expandingController.position.maxScrollExtent ==
              expandingController.offset) &&
          (loadMore == true)) {
        lastIndex += quantity;
        startIndex += quantity;
        notificationBloc.add(GetNotificationListEvent(
            doctorId: doctorId, startIndex: startIndex, lastIndex: lastIndex));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return CustomScreenForm(
        isRelativeApp:
            (userDataData.getUser()?.role == UserRole.relative) ? true : false,
        isShowAppBar: true,
        isShowLeadingButton: true,
        isShowBottomNayvigationBar: true,
        isShowRightButon: false,
        backgroundColor: AppColor.white,
        appBarColor: AppColor.topGradient,
        title: translation(context).notification,
        leadingButton: IconButton(
            onPressed: () => Navigator.pushNamed(context, RouteList.patientList,
                arguments: doctorId!),
            icon: const Icon(Icons.arrow_back)),
        selectedIndex: 2,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<NotificationBloc, NotificationState>(
              listener: _blocListener,
              builder: (context, state) {
                if (state is NotificationInitialState) {
                  lastIndex = 14;
                  startIndex = 0;
                  notificationBloc.add(GetNotificationListEvent(
                      doctorId: doctorId,
                      startIndex: startIndex,
                      lastIndex: lastIndex));
                }

                if ((state is GetNotificationListState &&
                        state.status == BlocStatusState.loading &&
                        state.viewModel.notificationEntity == null) ||
                    (state is RefreshNotificationListState &&
                        state.status == BlocStatusState.loading)) {
                  return const Center(
                    child: Loading(brightness: Brightness.light),
                  );
                }

                if (((state is SetReadedNotificationFromCellState &&
                            state.status == BlocStatusState.loading) &&
                        state.viewModel.notificationEntity != null) ||
                    (state is GetNotificationListState &&
                        state.status == BlocStatusState.loading) ||
                    (state is DeleteNotificationState &&
                        state.status == BlocStatusState.loading) ||
                    (state is GetNotificationListState &&
                        state.status == BlocStatusState.success) ||
                    (state is RefreshNotificationListState &&
                        state.status == BlocStatusState.success) ||
                    (state is DeleteNotificationState &&
                        state.status == BlocStatusState.success) ||
                    (state is SetReadedNotificationFromCellState &&
                        state.status == BlocStatusState.success) ||
                    (state is SetReadedNotificationState &&
                        state.status == BlocStatusState.success)) {
                  if (state.viewModel.notificationEntity!.isEmpty) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          translation(context).noNotification,
                          style: AppTextTheme.body2.copyWith(color: Colors.red),
                        ),
                        const SizedBox(height: 10),
                        RectangleButton(
                          height: SizeConfig.screenHeight * 0.04,
                          width: SizeConfig.screenWidth * 0.25,
                          title: translation(context).loadAgain,
                          onTap: () {
                            notificationBloc.add(RefreshNotificationListEvent(
                                doctorId: doctorId));
                          },
                        )
                      ],
                    ));
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SmartRefresher(
                              controller: _refreshController,
                              header: const WaterDropHeader(),
                              onRefresh: () async {
                                await Future.delayed(
                                    const Duration(milliseconds: 1000));
                                _refreshController.refreshCompleted();
                                notificationBloc.add(
                                    RefreshNotificationListEvent(
                                        doctorId: doctorId));
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
                                    loadMore = state.viewModel
                                                .notificationEntity!.length <
                                            state.viewModel.totalCount!
                                        ? true
                                        : false;

                                    if (index <
                                        state.viewModel.notificationEntity!
                                            .length) {
                                      return NotificationCell(
                                        cellIndex: index,
                                        notificationEntity: state.viewModel
                                            .notificationEntity![index],
                                        notificationBloc: notificationBloc,
                                      );
                                    }

                                    if (state.viewModel.notificationEntity!
                                            .length ==
                                        state.viewModel.totalCount!) {
                                      if (state.viewModel.totalCount! > 15) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 32),
                                          child: Center(
                                              child: Text(
                                            translation(context).endOfList,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.gray767676,
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        0.04),
                                          )),
                                        );
                                      }
                                    } else {
                                      return const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 32),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                    return null;
                                  })),
                        ),
                      ],
                    );
                  }
                } else if (state is GetNotificationListState &&
                        state.status == BlocStatusState.failure ||
                    state is WifiDisconnectState &&
                        state.status == BlocStatusState.success) {
                  return Center(
                    child: Text(translation(context).error),
                  );
                }
                return Container();
              }),
        ));
  }
}
