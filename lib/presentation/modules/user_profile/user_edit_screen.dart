import 'package:common_project/data/models/user_model.dart';
import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:common_project/presentation/modules/user_profile/user_detail_screen.dart';
import 'package:common_project/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../di/di.dart';
import '../../bloc/userlist/get_user_detail_bloc copy/get_user_detail_bloc.dart';
import '../../bloc/userlist/get_user_detail_bloc copy/get_user_detail_event.dart';
import '../../bloc/userlist/get_user_detail_bloc copy/get_user_detail_state.dart';
import '../../common_widget/loading_widget.dart';

//Class Home

class EditScreen extends StatefulWidget {
  String userId;
  String userName;
  String userJob;
  String userEmail;
  String userPhoneNumber;
  String userAge;
  EditScreen(
      {super.key,
      required this.userAge,
      required this.userEmail,
      required this.userId,
      required this.userJob,
      required this.userName,
      required this.userPhoneNumber});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController _controllerId = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerJob = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      _controllerId.text = widget.userId;
      _controllerName.text = widget.userName;
      _controllerJob.text = widget.userJob;
      _controllerAge.text = widget.userAge;
      _controllerEmail.text = widget.userEmail;
      _controllerPhoneNumber.text = widget.userPhoneNumber;
    });
  }

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
              title: 'Edit User Screen',
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
                    return ListView(
                        padding: const EdgeInsets.all(20),
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: _controllerId,
                            decoration: const InputDecoration(hintText: "Id:"),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _controllerAge,
                            decoration: const InputDecoration(hintText: "Age:"),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _controllerJob,
                            decoration: const InputDecoration(hintText: "Job:"),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _controllerName,
                            decoration:
                                const InputDecoration(hintText: "Name:"),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _controllerEmail,
                            decoration:
                                const InputDecoration(hintText: "Email:"),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _controllerPhoneNumber,
                            decoration:
                                const InputDecoration(hintText: "PhoneNumber:"),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                              onPressed: () async {
                                UserModel newUser = UserModel(
                                  id: int.parse(_controllerId.text),
                                  age: int.parse(_controllerAge.text),
                                  job: _controllerJob.text,
                                  name: _controllerName.text,
                                  email: _controllerEmail.text,
                                  phoneNumber: _controllerPhoneNumber.text,
                                );
                                BlocProvider.of<GetUserDetailBloc>(context).add(
                                    UpdateUserEvent(
                                        userId: newUser.id!, user: newUser));
                                Navigator.pop(context, MaterialPageRoute(
                                  builder: (context) {
                                    return BlocProvider<GetUserDetailBloc>(
                                      create: (context) =>
                                          getIt<GetUserDetailBloc>()
                                            ..add(GetUserDetailEvent(
                                                userId: newUser.id!)),
                                      child: const UserDetailScreen(),
                                    );
                                  },
                                ));
                                // Navigator.pop(context);
                              },
                              child: const Text("Save"))
                        ]);
                  }
                  return Container();
                },
              ));
        });
  }
}
