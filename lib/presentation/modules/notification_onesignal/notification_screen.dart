import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/utils/size_config.dart';
import 'package:mobile_health_check/presentation/modules/notification_onesignal/widget/notification_cell.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../classes/language.dart';
import '../../common_widget/common.dart';

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
  String? userId = userDataData.getUser()?.id;
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
            userId: userId, startIndex: startIndex, lastIndex: lastIndex));
      }
    });
  }

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
        title: translation(context).notification,
        leadingButton: IconButton(
            onPressed: () => Navigator.pushNamed(context, RouteList.patientList,
                arguments: userId!),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: SizeConfig.screenDiagonal * 0.035,
            )),
        selectedIndex: 2,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<NotificationBloc, NotificationState>(
              listener: _blocListener,
              builder: (context, state) {
                //? Init
                if (state is NotificationInitialState) {
                  lastIndex = 14;
                  startIndex = 0;
                  notificationBloc.add(GetNotificationListEvent(
                      userId: userId,
                      startIndex: startIndex,
                      lastIndex: lastIndex));
                }
                //? Loading
                if (state.status == BlocStatusState.loading &&
                    ((state is GetNotificationListState &&
                            state.viewModel.notificationEntity == null) ||
                        state is RefreshNotificationListState)) {
                  return const Center(
                    child: Loading(brightness: Brightness.light),
                  );
                }
                //? Success & keep state
                if ((state.status == BlocStatusState.loading &&
                        ((state is SetReadedNotificationFromCellState &&
                                state.viewModel.notificationEntity != null) ||
                            (state is GetNotificationListState) ||
                            (state is DeleteNotificationState))) ||
                    (state.status == BlocStatusState.success &&
                        (state is GetNotificationListState ||
                            state is RefreshNotificationListState ||
                            state is DeleteNotificationState ||
                            state is SetReadedNotificationFromCellState ||
                            state is SetReadedNotificationState))) {
                  if (state.viewModel.notificationEntity!.isEmpty) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          translation(context).noNotification,
                          style: AppTextTheme.body2.copyWith(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        RectangleButton(
                          height: SizeConfig.screenHeight * 0.045,
                          width: SizeConfig.screenWidth * 0.3,
                          title: translation(context).loadAgain,
                          onTap: () {
                            notificationBloc.add(
                                RefreshNotificationListEvent(userId: userId));
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
                                lastIndex = 14;
                                startIndex = 0;
                                notificationBloc.add(
                                    RefreshNotificationListEvent(
                                        userId: userId));
                              },
                              child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(
                                            height: 8,
                                            color: AppColor.white,
                                          ),
                                  controller: expandingController,
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: state.viewModel.notificationEntity!
                                          .length +
                                      1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    loadMore = (state
                                                    .viewModel
                                                    .notificationEntity!
                                                    .length <
                                                state.viewModel.totalCount! &&
                                            state.status !=
                                                BlocStatusState.loading)
                                        ? true
                                        : false;
                                    if (index <
                                        state.viewModel.notificationEntity!
                                            .length) {
                                      return NotificationCell(
                                        cellIndex: index,
                                        notificationEntity: state.viewModel
                                            .notificationEntity?[index],
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
                                                    SizeConfig.screenDiagonal *
                                                        0.02),
                                          )),
                                        );
                                      }
                                    } else {
                                      return const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 32),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: AppColor.white,
                                          ),
                                        ),
                                      );
                                    }
                                    return null;
                                  })),
                        ),
                      ],
                    );
                  }
                } else if (state.status == BlocStatusState.failure) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        softWrap: true,
                        textAlign: TextAlign.center,
                        state.viewModel.errorMessage!,
                        style: AppTextTheme.body2.copyWith(color: Colors.red),
                      ),
                      const SizedBox(height: 10),
                      RectangleButton(
                        height: SizeConfig.screenHeight * 0.045,
                        width: SizeConfig.screenWidth * 0.3,
                        title: translation(context).loadAgain,
                        onTap: () {
                          notificationBloc.add(
                              RefreshNotificationListEvent(userId: userId));
                        },
                      )
                    ],
                  ));
                }

                return Container();
              }),
        ));
  }
}
