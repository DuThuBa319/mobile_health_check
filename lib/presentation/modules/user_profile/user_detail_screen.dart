import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:common_project/presentation/modules/user_profile/user_edit_screen.dart';
import 'package:common_project/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/user_model.dart';
import '../../../di/di.dart';
import '../../bloc/userlist/get_user_detail_bloc copy/get_user_detail_bloc.dart';
import '../../bloc/userlist/get_user_detail_bloc copy/get_user_detail_event.dart';
import '../../bloc/userlist/get_user_detail_bloc copy/get_user_detail_state.dart';
import '../../common_widget/loading_widget.dart';
import '../../theme/app_text_theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//Class Home
class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserDetailBloc, GetUserDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          return CustomScreenForm(
              appBarColor: AppColor.appBarColor,
              backgroundColor: Colors.white,
              isShowAppBar: true,
              isShowLeadingButton: true,
              title: 'User Detail Screen',
              child: Builder(
                builder: (context) {
                  if (state is GetUserDetailLoadingState) {
                    return const Expanded(
                      child: Center(
                        child: Loading(
                          brightness: Brightness.light,
                        ),
                      ),
                    );
                  }
                  if (state is GetUserDetailSuccessState) {
                    final userEntity = state.viewModel.userDetailEntity;
                    return SmartRefresher(
                        controller: _refreshController,
                        onRefresh: () async {
                          await Future.delayed(
                              const Duration(milliseconds: 1000));
                          _refreshController.refreshCompleted();
                          BlocProvider.of<GetUserDetailBloc>(context)
                              .add(GetUserDetailEvent(userId: userEntity.id!));
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: AppColor.appBarColor,
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  20)),
                                      child: const Icon(
                                        Icons.people_sharp,
                                        size: 30,
                                      ))),
                              Text(
                                "User id: ${userEntity.id}",
                                style: AppTextTheme.body1,
                              ),
                              Text('Job: ${userEntity.job}',
                                  style: AppTextTheme.body1),
                              Text("Age: ${userEntity.age}",
                                  style: AppTextTheme.body1),
                              Text("Name: ${userEntity.name}",
                                  style: AppTextTheme.body1),
                              Text('Email: ${userEntity.email}',
                                  style: AppTextTheme.body1),
                              Text('PhoneNumBer: ${userEntity.phoneNumber}',
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
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                            onPressed: () async {
                                              print(userEntity.id);
                                              BlocProvider.of<
                                                          GetUserDetailBloc>(
                                                      context)
                                                  .add(DeleteUserEvent(
                                                      userId: userEntity.id!));
                                              Navigator.pop(context);
                                            },
                                            child: const Icon(Icons.delete))),
                                    const SizedBox(
                                      width: 30,
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
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                            onPressed: () {
                                              UserModel userModel = UserModel(
                                                  id: userEntity.id,
                                                  age: userEntity.age,
                                                  job: userEntity.job,
                                                  name: userEntity.name,
                                                  email: userEntity.email,
                                                  phoneNumber:
                                                      userEntity.phoneNumber);

                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return BlocProvider<
                                                      GetUserDetailBloc>(
                                                    create: (context) => getIt<
                                                        GetUserDetailBloc>()
                                                      ..add(UpdateUserEvent(
                                                          user: userModel,
                                                          userId:
                                                              userEntity.id!)),
                                                    child: EditScreen(
                                                      userId: userEntity.id
                                                          .toString(),
                                                      userAge: userEntity.age
                                                          .toString(),
                                                      userJob: userEntity.job!,
                                                      userName:
                                                          userEntity.name!,
                                                      userEmail:
                                                          userEntity.email!,
                                                      userPhoneNumber:
                                                          userEntity
                                                              .phoneNumber!,
                                                    ),
                                                  );
                                                },
                                              ));
                                            },
                                            child: const Icon(Icons.edit)))
                                  ]))
                            ]));
                  }

                  if (state is GetUserDetailFailedState) {
                    return const Center(
                      child: Text("error"),
                    );
                  }
                  return Container();
                },
              ));
        });
  }
}
