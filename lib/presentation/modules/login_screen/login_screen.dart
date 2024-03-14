// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/utils/size_config.dart';
import 'package:mobile_health_check/main.dart';
import 'package:mobile_health_check/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../classes/language.dart';
import '../../../classes/language_constant.dart';

import '../../common_widget/common.dart';
import '../../route/route_list.dart';

import '../../theme/theme_color.dart';
import 'bloc/login_bloc.dart';

part 'login_screen.action.dart';

List<Widget> language = <Widget>[
  Text('EN',
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: SizeConfig.screenWidth * 0.045)),
  Text('VN',
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: SizeConfig.screenWidth * 0.045)),
];

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

//! 1 => En
//! 2 => Vi
class _LoginState extends State<LoginScreen> {
  final List<bool> selectLanguage = <bool>[
    notificationData.localeId == 1 ? true : false,
    (notificationData.localeId == 2 || notificationData.localeId == null)
        ? true
        : false
  ];
  LoginBloc get bloc => BlocProvider.of(context);
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool vertical = false;
  bool showPass = true;

  // final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Language? selectedLanguage;
    SizeConfig.init(context);
    return PopScope(
      canPop: false,
      onPopInvoked: _onWillPop,
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: _blocListener,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColor.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                    SizeConfig.screenWidth * 0.08,
                    SizeConfig.screenWidth * 0.1,
                    SizeConfig.screenWidth * 0.08,
                    0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    ToggleButtons(
                      direction: vertical ? Axis.vertical : Axis.horizontal,
                      onPressed: (int index) async {
                        for (int i = 0; i < selectLanguage.length; i++) {
                          selectLanguage[i] = i == index;
                          if (index == 0) {
                            selectedLanguage = Language(1, ENGLISH, 'en');
                            Locale locale =
                                await setLocale(selectedLanguage!.languageCode);
                            notificationData.saveLocale(1);

                            MyApp.setLocale(context, locale);

                            showToast(
                                context: context,
                                status: ToastStatus.success,
                                toastString: "Change language successfully");
                            //? await notificationData
                            //?     .saveLocale(selectedLanguage!.id);
                            setState(() {});
                          }
                          if (index == 1) {
                            selectedLanguage = Language(2, VIETNAMESE, 'vi');
                            Locale locale =
                                await setLocale(selectedLanguage!.languageCode);
                            notificationData.saveLocale(2);

                            MyApp.setLocale(context, locale);

                            showToast(
                                context: context,
                                status: ToastStatus.success,
                                toastString: "Đổi ngôn ngữ thành công");
                            //? await notificationData
                            // ?    .saveLocale(selectedLanguage!.id);
                            setState(() {});
                          }
                        }
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedBorderColor: AppColor.topGradient,
                      selectedColor: Colors.white,
                      fillColor: AppColor.topGradient,
                      color: AppColor.topGradient,
                      constraints: BoxConstraints(
                        minHeight: SizeConfig.screenHeight * 0.04,
                        minWidth: SizeConfig.screenWidth * 0.2,
                      ),
                      isSelected: selectLanguage,
                      children: language,
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.035,
                    ),
                    Center(
                      child: SizedBox(
                        width: SizeConfig.screenWidth * 0.35,
                        height: SizeConfig.screenWidth * 0.35,
                        child: Image.asset(
                          Assets.teleHealth,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: SizeConfig.screenHeight * 0.025,
                    ),
                    Center(
                      child: Text(
                        translation(context).signIn,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.topGradient,
                          fontSize: SizeConfig.screenWidth * 0.11,
                        ),
                      ),
                    ),

                    //Text Field Username
                    Container(
                      padding:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.015),
                      height: SizeConfig.screenHeight * 0.1,
                      width: SizeConfig.screenWidth * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.cardBackgroundColor,
                      ),
                      margin: EdgeInsets.only(
                          top: SizeConfig.screenWidth * 0.03,
                          bottom: SizeConfig.screenWidth * 0.025),
                      child: Center(
                        child: TextField(
                          cursorColor: AppColor.gray767676,
                          keyboardType: TextInputType.number,
                          // focusNode: _focusNode,
                          controller: _usernameController,
                          style: TextStyle(
                            fontSize: SizeConfig.screenDiagonal < 1350
                                ? SizeConfig.screenWidth * 0.05
                                : SizeConfig.screenWidth * 0.045,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                              fontSize: SizeConfig.screenDiagonal < 1350
                                  ? SizeConfig.screenWidth * 0.03
                                  : SizeConfig.screenWidth * 0.032,
                              color: Colors.red,
                            ),
                            iconColor: AppColor.primaryColorLight,
                            isDense: true, // Giữ khoảng cách cố định cho icon
                            errorText: (state.viewModel.errorMessage ==
                                    translation(context).pleaseEnterYourAccount)
                                ? state.viewModel.errorMessage
                                : null,
                            border: InputBorder.none,
                            labelText: translation(context).phoneNumber,
                            icon: Icon(Icons.account_box_rounded,
                                size: SizeConfig.screenDiagonal * 0.05),
                            labelStyle: TextStyle(
                              color: AppColor.gray767676,
                              fontSize: SizeConfig.screenDiagonal < 1350
                                  ? SizeConfig.screenWidth * 0.05
                                  : SizeConfig.screenWidth * 0.032,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Text field Password
                    Container(
                      height: SizeConfig.screenHeight * 0.1,
                      padding: EdgeInsets.only(
                          right: 5,
                          left: SizeConfig.screenWidth * 0.015,
                          top: 2,
                          bottom: 2),
                      width: SizeConfig.screenWidth * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.cardBackgroundColor,
                      ),
                      margin: EdgeInsets.only(
                          bottom: SizeConfig.screenWidth * 0.04),
                      child: Center(
                        child: TextField(
                          // focusNode: _focusNode,
                          cursorColor: AppColor.gray767676,
                          controller: _passwordController,
                          obscureText: showPass,
                          style: TextStyle(
                            fontSize: SizeConfig.screenDiagonal < 1350
                                ? SizeConfig.screenWidth * 0.05
                                : SizeConfig.screenWidth * 0.045,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            iconColor: AppColor.primaryColorLight,
                            isDense: true, // Giữ khoảng cách cố định cho icon
                            errorStyle: TextStyle(
                              fontSize: SizeConfig.screenDiagonal < 1350
                                  ? SizeConfig.screenWidth * 0.03
                                  : SizeConfig.screenWidth * 0.032,
                              color: Colors.red,
                            ),

                            errorText: (state.viewModel.errorMessage ==
                                    translation(context).pleaseEnterYourAccount)
                                ? state.viewModel.errorMessage
                                : null,
                            suffixIcon: IconButton(
                              icon: Icon(
                                  showPass
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: SizeConfig.screenDiagonal * 0.025),
                              onPressed: () {
                                setState(() {
                                  showPass = !showPass;
                                });
                              },
                            ),
                            icon: Icon(Icons.lock,
                                size: SizeConfig.screenDiagonal * 0.05),
                            border: InputBorder.none,
                            labelText: translation(context).password,
                            labelStyle: TextStyle(
                              color: AppColor.gray767676,
                              fontSize: SizeConfig.screenDiagonal < 1350
                                  ? SizeConfig.screenWidth * 0.05
                                  : SizeConfig.screenWidth * 0.032,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, RouteList.forgotPass),
                          child: Text(
                            translation(context).forgotPass,
                            style: TextStyle(
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w400,
                              color: AppColor.gray767676,
                              fontSize: SizeConfig.screenWidth * 0.045,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                        onTap: login,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.screenHeight * 0.01,
                              bottom: SizeConfig.screenWidth * 0.2),
                          decoration: BoxDecoration(
                              color: AppColor.topGradient,
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.screenWidth * 0.03)),
                          height: SizeConfig.screenWidth * 0.15,
                          width: SizeConfig.screenWidth * 0.9,
                          child: Center(
                            child: Text(
                              translation(context).signIn,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.white,
                                fontSize: SizeConfig.screenWidth * 0.06,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
