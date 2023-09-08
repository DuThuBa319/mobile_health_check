import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';
import 'package:mobile_health_check/presentation/modules/notification_onesignal/widget/notification_cell.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../classes/language_constant.dart';
import '../../../presentation/common_widget/screen_form/custom_screen_form.dart';
import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/enum_common.dart';
import '../../common_widget/loading_widget.dart';
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
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  NotificationBloc get notificationBloc => BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return CustomScreenForm(
        isShowAppBar: true,
        isShowLeadingButton: true,
        isShowBottomNayvigationBar: true,
        isShowRightButon: false,
        backgroundColor: AppColor.white,
        appBarColor: AppColor.topGradient,

        // rightButton: IconButton(
        //   onPressed: gotoRegistnotificationScreen,
        //   icon: const Icon(Icons.add),
        title: translation(context).notification,
        // ),
        selectedIndex: 1,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lineDecor(),
              BlocConsumer<NotificationBloc, NotificationState>(
                  listener: _blocListener,
                  builder: (context, state) {
                    if (state is NotificationInitialState) {
                      notificationBloc.add(GetNotificationListEvent(
                          id: widget.id ?? widget.id!));
                    }
                    if (state is GetNotificationListState &&
                        state.status == BlocStatusState.loading) {
                      return const Expanded(
                        child: Center(
                          child: Loading(brightness: Brightness.light),
                        ),
                      );
                    }

                    if (state is GetNotificationListState &&
                        state.status == BlocStatusState.success) {
                      if (state.viewModel.notificationEntity!.isEmpty) {
                        return Center(
                            child: Text(translation(context).selectTime,
                                style: AppTextTheme.body2
                                    .copyWith(color: Colors.red)));
                      } else {
                        return Expanded(
                          child: SmartRefresher(
                            controller: _refreshController,
                            header: const WaterDropHeader(),
                            onRefresh: () async {
                              await Future.delayed(
                                  const Duration(milliseconds: 1000));
                              _refreshController.refreshCompleted();
                              notificationBloc.add(GetNotificationListEvent(
                                  id: widget.id ?? widget.id!));
                            },
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount:
                                  state.viewModel.notificationEntity?.length,
                              itemBuilder: (BuildContext context, int index) {
                                final notificationEntity =
                                    state.viewModel.notificationEntity![index];
                                return NotificationCell(
                                  notificationEntity: notificationEntity,
                                  notificationBloc: notificationBloc,
                                );
                              },
                            ),
                          ),
                        );
                      }
                    }
                    return Container();
                  }),
            ],
          ),
        ));
  }
}
