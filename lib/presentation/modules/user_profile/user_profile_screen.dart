import 'package:common_project/presentation/modules/user_profile/user_regist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:common_project/presentation/modules/user_profile/widget/user_list_cell.dart';
import 'package:common_project/presentation/theme/theme_color.dart';
import '../../../di/di.dart';
import '../../bloc/userlist/get_user_bloc/get_user_bloc.dart';
import '../../bloc/userlist/get_user_bloc/get_user_event.dart';
import '../../bloc/userlist/get_user_bloc/get_user_state.dart';
import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/loading_widget.dart';
part 'user_profile_screen.action.dart';

//Class Home
class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListState();
}

// final RefreshController _refreshController =
//     RefreshController(initialRefresh: false);
TextEditingController filterKeyword = TextEditingController(text: '');

final TextEditingController idController = TextEditingController();
final TextEditingController ageController = TextEditingController();
final TextEditingController jobController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneNumberController = TextEditingController();

class _UserListState extends State<UserListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserBloc, GetUserState>(
        listener: _Listener,
        builder: (context, state) {
          return CustomScreenForm(
              appBarColor: AppColor.appBarColor,
              backgroundColor: Colors.white,
              isShowAppBar: true,
              isShowLeadingButton: true,
              title: 'User List Screen',
              isShowRightButon: true,
              rightButton: IconButton(
                  onPressed: () {
                     Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return BlocProvider<GetUserBloc>(
                        create: (context) => getIt<GetUserBloc>(),
                        child: const RegistScreen(),
                      );
                    },
                  ));
                  },
                  icon: const Icon(Icons.add, color: Colors.white)),
              child: Column(
                children: [
                  TextField(
                    controller: filterKeyword,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                        hintText: "Eg: Johny",
                        hintStyle: const TextStyle(color: Colors.black54),
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            color: Colors.black,
                            iconSize: 25,
                            onPressed: () {
                              BlocProvider.of<GetUserBloc>(context)
                                  .add(FilterUserEvent(
                                searchText: filterKeyword.text,
                              ));
                            })),
                  ),
                  Builder(builder: (context) {
                    if (state is GetUserLoadingState) {
                      return const Expanded(
                        child: Center(
                          child: Loading(
                            brightness: Brightness.light,
                          ),
                        ),
                      );
                    }
                    if (state is GetUserSuccessState) {
                      // return SmartRefresher(
                      //     controller: _refreshController,
                      //     onRefresh: () async {
                      //       await Future.delayed(
                      //           const Duration(milliseconds: 1000));
                      //       _refreshController.refreshCompleted();
                      // BlocProvider.of<GetUserBloc>(context).add(GetUserEvent());
                      //     },
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.viewModel.userEntity?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            final userEntity =
                                state.viewModel.userEntity?[index];
                            return UserListCell(
                              userEntity: userEntity,
                            );
                          },
                        ),
                      );
                    }
                    if (state is GetUserFailedState) {
                      return const Center(
                        child: Text("error"),
                      );
                    }
                    return Container();

                    //Class UserListCell
                  }),
                ],
              ));
        });
  }
}
