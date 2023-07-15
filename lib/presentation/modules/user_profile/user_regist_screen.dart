import 'package:common_project/presentation/bloc/userlist/get_user_bloc/get_user_event.dart';
import 'package:flutter/material.dart';

import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_model.dart';
import '../../bloc/userlist/get_user_bloc/get_user_bloc.dart';
import '../../bloc/userlist/get_user_bloc/get_user_state.dart';
import '../../common_widget/dialog/show_toast.dart';
import '../../theme/theme_color.dart';

class RegistScreen extends StatefulWidget {
  const RegistScreen({Key? key}) : super(key: key);

  @override
  State<RegistScreen> createState() => _RegistScreenState();
}

class _RegistScreenState extends State<RegistScreen> {
  final TextEditingController _controllerId = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerJob = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserBloc, GetUserState>(
        listener: _listener,
        builder: (context, state) {
          return CustomScreenForm(
              appBarColor: AppColor.appBarColor,
              backgroundColor: Colors.white,
              isShowAppBar: true,
              isShowLeadingButton: true,
              title: 'Regist New User',
              child: ListView(
                padding: const EdgeInsets.only(left: 10, right: 10),
                children: [
                  TextField(
                    controller: _controllerId,
                    decoration: const InputDecoration(labelText: 'ID'),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _controllerAge,
                    decoration: const InputDecoration(labelText: 'Age'),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _controllerJob,
                    decoration: const InputDecoration(labelText: 'Job'),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _controllerName,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _controllerEmail,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _controllerPhoneNumber,
                    decoration:
                        const InputDecoration(labelText: 'Phone Number'),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        BlocProvider.of<GetUserBloc>(context)
                            .add(RegistUserEvent(
                                user: UserModel(
                          id: int.parse(_controllerId.text),
                          age: int.parse(_controllerAge.text),
                          job: _controllerJob.text,
                          name: _controllerName.text,
                          email: _controllerEmail.text,
                          phoneNumber: _controllerPhoneNumber.text,
                        )));
                        Navigator.pop(context);
                      },
                      child: const Text('Create User'),
                    ),
                  ),
                ],
              ));
        });
  }
}

void _listener(BuildContext context, GetUserState state) {
  if (state is GetUserSuccessState) {
    showToast('Regist User');
  }
}
