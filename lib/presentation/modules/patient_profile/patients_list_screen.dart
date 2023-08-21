import 'package:mobile_health_check/presentation/common_widget/enum_common.dart';
import 'package:mobile_health_check/presentation/modules/patient_profile/widget/patient_cell.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../classes/language_constant.dart';
import '../../bloc/patient_list_&_infor/get_patient_bloc.dart';

import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/loading_widget.dart';
import '../../common_widget/screen_form/custom_screen_form.dart';
import '../../route/route_list.dart';

part 'patients_list_screen.action.dart';

//Class Home
class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListState();
}

TextEditingController filterKeyword = TextEditingController(text: '');

final TextEditingController idController = TextEditingController();
final TextEditingController ageController = TextEditingController();
final TextEditingController jobController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneNumberController = TextEditingController();

class _UserListState extends State<UserListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GetUserBloc get userBloc => BlocProvider.of(context);
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
        //   onPressed: gotoRegistUserScreen,
        //   icon: const Icon(Icons.add),
        title: translation(context).patientList,
        // ),
        selectedIndex: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 20),
                  child: Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.black12,
                      )
                    ]),
                    child: TextField(
                      controller: filterKeyword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: translation(context).searchPatient,
                        hintStyle: const TextStyle(color: Colors.black54),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          color: Colors.black,
                          onPressed: () {
                            userBloc.add(
                              FilterUserEvent(searchText: filterKeyword.text),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                BlocConsumer<GetUserBloc, GetUserState>(
                    listener: _blocListener,
                    builder: (context, state) {
                      if (state is GetUserInitialState) {
                        userBloc.add(GetListUserEvent());
                      }
                      if (state is GetListUserState &&
                          state.status == BlocStatusState.loading) {
                        return const Expanded(
                          child: Center(
                            child: Loading(brightness: Brightness.light),
                          ),
                        );
                      }

                      if (state is GetListUserState &&
                          state.status == BlocStatusState.success) {
                        return Expanded(
                          child: SmartRefresher(
                            controller: _refreshController,
                            onRefresh: () async {
                              await Future.delayed(
                                  const Duration(milliseconds: 1000));
                              _refreshController.refreshCompleted();
                              userBloc.add(GetListUserEvent());
                            },
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  state.viewModel.userEntity?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                final userEntity =
                                    state.viewModel.userEntity?[index];
                                return UserListCell(
                                  userEntity: userEntity,
                                  userBloc: userBloc,
                                );
                              },
                            ),
                          ),
                        );
                      }
                      if (state is GetListUserState &&
                          state.status == BlocStatusState.failure) {
                        return const Center(
                          child: Text("error"),
                        );
                      }
                      return Container();
                    }),
              ]),
        ));
  }
}
