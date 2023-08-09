import 'package:mobile_health_check/domain/entities/user_entity.dart';
import 'package:mobile_health_check/presentation/bloc/userlist/get_user_bloc/get_user_bloc.dart';
import 'package:mobile_health_check/presentation/common_widget/enum_common.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../di/di.dart';
import '../../bloc/userlist/get_user_detail_bloc/get_user_detail_bloc.dart';

import '../../common_widget/loading_widget.dart';

import '../../theme/app_text_theme.dart';
import 'user_edit_screen.dart';

//Class Home
class UserDetailScreen extends StatefulWidget {
  final int id;
  final GetUserBloc userBloc;
  const UserDetailScreen({Key? key, required this.id, required this.userBloc})
      : super(key: key);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  // final RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);
  GetUserDetailBloc get detailBloc => BlocProvider.of(context);
  @override
  Widget build(BuildContext context) {
    return CustomScreenForm(
        appBarColor: AppColor.appBarColor,
        backgroundColor: Colors.white,
        isShowAppBar: true,
        isShowLeadingButton: true,
        title: 'User Detail Screen',
        child: Column(children: [
          BlocConsumer<GetUserDetailBloc, GetUserDetailState>(
            listener: (context, state) {
              if (state is UpdateUserState &&
                  state.status == BlocStatusState.success) {
                detailBloc.add(GetUserDetailEvent(userId: widget.id));
              }
              if (state is DeleteUserState &&
                  state.status == BlocStatusState.success) {
                widget.userBloc.add(GetListUserEvent());
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is GetUserDetailInitialState) {
                detailBloc.add(GetUserDetailEvent(userId: widget.id));
              }
              if (state is GetDetailUserState &&
                  state.status == BlocStatusState.loading) {
                return const Expanded(
                  child: Center(
                    child: Loading(
                      brightness: Brightness.light,
                    ),
                  ),
                );
              }
              if (state is GetDetailUserState &&
                  state.status == BlocStatusState.success) {
                UserEntity user = state.viewModel.userDetailEntity!;
                return Expanded(
                    child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: AppColor.appBarColor,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(20)),
                              child: const Icon(
                                Icons.people_sharp,
                                size: 30,
                              ))),
                      Text(
                        "User id: ${user.id}",
                        style: AppTextTheme.body1,
                      ),
                      Text('Job: ${user.job}', style: AppTextTheme.body1),
                      Text("Age: ${user.age}", style: AppTextTheme.body1),
                      Text("Name: ${user.name}", style: AppTextTheme.body1),
                      Text('Email: ${user.email}', style: AppTextTheme.body1),
                      Text('PhoneNumBer: ${user.phoneNumber}',
                          style: AppTextTheme.body1),
                      Container(
                          margin: const EdgeInsets.only(left: 250),
                          child: Row(children: [
                            SizedBox(
                                height: 60,
                                width: 60,
                                child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          width: 2,
                                          color: AppColor.appBarColor),
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    onPressed: () async {
                                      BlocProvider.of<GetUserDetailBloc>(
                                              context)
                                          .add(DeleteUserEvent(
                                              userId: user.id!));
                                    },
                                    child: const Icon(Icons.delete))),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                                height: 60,
                                width: 60,
                                child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          width: 2,
                                          color: AppColor.appBarColor),
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return BlocProvider<
                                              GetUserDetailBloc>(
                                            create: (context) =>
                                                getIt<GetUserDetailBloc>(),
                                            child: EditScreen(
                                              userEntity: user,
                                              detailBloc: detailBloc,
                                            ),
                                          );
                                        },
                                      ));
                                    },
                                    child: const Icon(Icons.edit)))
                          ]))
                    ],
                  ),
                ));
              }

              if (state is GetDetailUserState &&
                  state.status == BlocStatusState.failure) {
                return const Center(
                  child: Text("error"),
                );
              }
              return Container();
            },
          ),
        ]));
  }
}
