import 'package:mobile_health_check/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/assets/assets.dart';
import 'package:mobile_health_check/presentation/modules/login_screen/bloc/login_bloc.dart';

import '../../../../classes/language.dart';

import '../../../common_widget/common.dart';
import '../../../theme/app_text_theme.dart';
import '../../../theme/theme_color.dart';

part 'forgot_password_screen_actions.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPassScreen> {
  LoginBloc get bloc => BlocProvider.of(context);
  final TextEditingController _phoneNumberController = TextEditingController();
  // final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return CustomScreenForm(
      title: translation(context).forgotPass,
      isShowAppBar: true,
      isShowBottomNayvigationBar: false,
      isShowLeadingButton: true,
      appBarColor: const Color(0xff7BD4FF),
      backgroundColor: AppColor.white,
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: _blocListener,
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.08,
                right: SizeConfig.screenWidth * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                Text.rich(
                  softWrap: true,
                  textAlign: TextAlign.start,
                  style: AppTextTheme.body1.copyWith(
                      color: AppColor.black,
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.screenDiagonal * 0.0185),
                  TextSpan(
                    children: [
                      WidgetSpan(
                        child: SizedBox(
                            height: SizeConfig.screenWidth * 0.08,
                            width: SizeConfig.screenWidth * 0.08,
                            child: Image.asset(
                              Assets.forgotPassword,
                              fit: BoxFit.fill,
                            )),
                      ),
                      TextSpan(
                        text: translation(context).titileForgetPass,
                      )
                    ],
                  ),
                ),
                lineDecor(
                    spaceTop: SizeConfig.screenHeight * 0.03,
                    spaceBottom: SizeConfig.screenHeight * 0.015),
                //Text Field phoneNumber
                Container(
                  padding:
                      EdgeInsets.only(left: SizeConfig.screenWidth * 0.015),
                  height: SizeConfig.screenHeight * 0.1,
                  width: SizeConfig.screenWidth * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.cardBackgroundColor,
                  ),
                  margin:
                      EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.035),
                  child: Center(
                    child: TextField(
                      cursorColor: AppColor.gray767676,
                      keyboardType: TextInputType.phone,
                      controller: _phoneNumberController,
                      style: TextStyle(
                        fontSize: SizeConfig.screenDiagonal < 1350
                            ? SizeConfig.screenWidth * 0.05
                            : SizeConfig.screenWidth * 0.045,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontSize: SizeConfig.screenDiagonal < 1350
                              ? SizeConfig.screenWidth * 0.033
                              : SizeConfig.screenWidth * 0.02,
                          color: Colors.red,
                        ),
                        contentPadding: EdgeInsets.only(
                            bottom: SizeConfig.screenHeight * 0.002),
                        errorText: state.viewModel.errorMessage,
                        border: InputBorder.none,
                        labelText: translation(context).phoneNumber,
                        labelStyle: TextStyle(
                            color: AppColor.gray767676,
                            fontSize: SizeConfig.screenDiagonal < 1350
                                ? SizeConfig.screenWidth * 0.05
                                : SizeConfig.screenWidth * 0.032),
                      ),
                    ),
                  ),
                ),
                //Text field Password
                GestureDetector(
                    onTap: () => bloc.add(ResetPasswordEvent(
                        phoneNumber: _phoneNumberController.text)),
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
                          translation(context).confirm,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColor.white,
                            fontSize: SizeConfig.screenWidth * 0.05,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
