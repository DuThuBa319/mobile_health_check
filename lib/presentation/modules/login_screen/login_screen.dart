import 'dart:async';

import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../classes/language.dart';
import '../../../classes/language_constant.dart';
import '../../../main.dart';
import '../../common_widget/dialog/dialog_one_button.dart';
import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/enum_common.dart';
import '../../route/route_list.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/theme_color.dart';
import 'login/login_bloc.dart';

part 'login_screen.action.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  LoginBloc get bloc => BlocProvider.of(context);
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
    return BlocConsumer<LoginBloc, LoginState>(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              selectedLanguage = Language(1, ENGLISH, 'en');
                              Locale locale = await setLocale(
                                  selectedLanguage!.languageCode);
                              // ignore: use_build_context_synchronously
                              MyApp.setLocale(context, locale);
                              showToast("Change language successfully");
                              await notificationData
                                  .saveLocale(selectedLanguage!.id);

                              setState(() {});
                            },
                            child: Stack(
                              children: [
                                Image.asset(
                                  Assets.enFlag,
                                  scale: SizeConfig.screenWidth * 0.03,
                                ),
                                Positioned(
                                  left: SizeConfig.screenWidth * 0.095,
                                  top: 8,
                                  child: Icon(
                                    Icons.check_circle,
                                    // ignore: unrelated_type_equality_checks
                                    color: (notificationData.localeId == 1)
                                        ? Colors.blue
                                        : Colors.grey,
                                    size: SizeConfig.screenWidth * 0.04,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.02,
                          ),
                          GestureDetector(
                            onTap: () async {
                              selectedLanguage = Language(2, VIETNAMESE, 'vi');
                              Locale locale = await setLocale(
                                  selectedLanguage!.languageCode);
                              // ignore: use_build_context_synchronously
                              MyApp.setLocale(context, locale);
                              showToast("Đổi ngôn ngữ thành công");
                              await notificationData
                                  .saveLocale(selectedLanguage!.id);
                              setState(() {});
                            },
                            child: Stack(
                              children: [
                                Image.asset(
                                  Assets.vnFlag,
                                  scale: SizeConfig.screenWidth * 0.03,
                                ),
                                Positioned(
                                  left: SizeConfig.screenWidth * 0.095,
                                  top: 8,
                                  child: Icon(
                                    Icons.check_circle,
                                    // ignore: unrelated_type_equality_checks
                                    color: (notificationData.localeId == 2)
                                        ? Colors.blue
                                        : Colors.grey,
                                    size: SizeConfig.screenWidth * 0.04,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),

                  Center(
                    child: Image.asset(
                      Assets.appLogo,
                      scale: 3,
                    ),
                  ),

                  SizedBox(
                    height: SizeConfig.screenWidth * 0.05,
                  ),
                  Center(
                    child: Text(
                      translation(context).signIn,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.topGradient,
                        fontSize: SizeConfig.screenWidth * 0.1,
                      ),
                    ),
                  ),

                  //Text Field Username
                  Container(
                    height: SizeConfig.screenWidth * 0.2,
                    width: SizeConfig.screenWidth * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.cardBackgroundColor,
                    ),
                    margin: EdgeInsets.only(
                        top: SizeConfig.screenWidth * 0.06,
                        bottom: SizeConfig.screenWidth * 0.035),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.01,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.8,
                          child: TextField(
                            // focusNode: _focusNode,
                            controller: _usernameController,
                            style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.05,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Email",
                              icon: Icon(Icons.account_box_rounded,
                                  size: SizeConfig.screenWidth * 0.12),
                              labelStyle: TextStyle(
                                  color: AppColor.gray767676,
                                  fontSize: SizeConfig.screenWidth * 0.05),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Text field Password
                  Container(
                    height: SizeConfig.screenWidth * 0.2,
                    width: SizeConfig.screenWidth * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.cardBackgroundColor,
                    ),
                    margin: EdgeInsets.only(
                        top: SizeConfig.screenWidth * 0.06,
                        bottom: SizeConfig.screenWidth * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.02,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.8,
                          child: TextField(
                            // focusNode: _focusNode,
                            controller: _passwordController,
                            obscureText: showPass,
                            style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.05,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                    showPass
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: SizeConfig.screenWidth * 0.05),
                                onPressed: () {
                                  setState(() {
                                    showPass = !showPass;
                                  });
                                },
                              ),
                              icon: Icon(Icons.lock,
                                  size: SizeConfig.screenWidth * 0.1),
                              border: InputBorder.none,
                              labelText: translation(context).password,
                              labelStyle: TextStyle(
                                  color: AppColor.gray767676,
                                  fontSize: SizeConfig.screenWidth * 0.05),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: null,
                        child: Text(
                          translation(context).forgotPass,
                          style: TextStyle(
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.w400,
                            color: AppColor.gray767676,
                            fontSize: SizeConfig.screenWidth * 0.035,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // nut si
                  //
                  //gn in
                  GestureDetector(
                      onTap: login,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.screenWidth * 0.03,
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
                              fontWeight: FontWeight.w400,
                              color: AppColor.white,
                              fontSize: SizeConfig.screenWidth * 0.055,
                            ),
                          ),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        translation(context).dontHaveAccount,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColor.gray767676,
                          fontSize: SizeConfig.screenWidth * 0.04,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: null,
                        child: Text(
                          translation(context).signUp,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: AppColor.topGradient,
                            fontSize: SizeConfig.screenWidth * 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
