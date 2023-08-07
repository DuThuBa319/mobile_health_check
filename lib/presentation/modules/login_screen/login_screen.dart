import 'package:common_project/presentation/modules/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login/login_bloc.dart';
import '../../common_widget/dialog/dialog_one_button.dart';
import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/enum_common.dart';
import '../../theme/theme_color.dart';

part 'login_screen.action.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  LoginBloc get bloc => BlocProvider.of(context);
  final _accountCtroller = TextEditingController();
  final _passCtroller = TextEditingController();
  String username = "";
  String password = "";
  bool showPass = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: _blocListener,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(95, 22, 17, 44),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(30, 70, 30, 0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Row(
                      children: [
                        Text(
                          'Login Account',
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            letterSpacing: 1,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.account_circle_outlined,
                          color: AppColor.iconUnselected,
                        ),
                      ],
                    ),

                    const Text(
                      'Welcome Back Flutter',
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: Container(
                            padding: const EdgeInsets.only(right: 3.5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 3, color: AppColor.primaryColor),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: FlutterLogo(
                                size: 90,
                              ),
                            )),
                      ),
                    ),

                    //Text Field Username
                    Container(
                        margin: const EdgeInsets.only(top: 50),
                        height: 60,
                        padding: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.circular(10)),
                        child: TextField(
                            cursorColor: AppColor.gray767676,
                            textAlign: TextAlign.start,
                            onChanged: (newUsername) {
                              print(newUsername);
                              username = newUsername;
                            },
                            controller: _accountCtroller,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.account_box_rounded,
                                  size: 30,
                                ),
                                labelText: "Username",
                                labelStyle:
                                    TextStyle(color: AppColor.gray767676)))),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 1),
                                blurRadius: 5,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.circular(10)),
                        child: TextField(
                          textAlign: TextAlign.start,
                          onChanged: (newPassword) {
                            print(newPassword);
                            password = newPassword;
                          },
                          cursorColor: AppColor.gray767676,
                          controller: _passCtroller,
                          obscureText: showPass,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Password",
                            icon: const Icon(
                              Icons.lock_rounded,
                              size: 30,
                            ),
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 155, 153, 152)),
                            suffixIcon: IconButton(
                              icon: Icon(showPass
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  showPass = !showPass;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Text field Password
                    const SizedBox(
                      height: 30,
                    ),
                    // nut sign in
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: GestureDetector(
                          onTap: login,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: const Center(
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}