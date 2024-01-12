// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/domain/entities/change_password_entity.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';

import 'package:mobile_health_check/utils/size_config.dart';
import 'package:mobile_health_check/presentation/modules/setting_screen/setting_bloc/setting_bloc.dart';

import '../../../../classes/language.dart';
import '../../../../common/singletons.dart';

import '../../common_widget/common.dart';
import '../../theme/theme_color.dart';

// ignore: must_be_immutable
class SettingPassword extends StatefulWidget {
  const SettingPassword({
    Key? key,
  }) : super(key: key);
  @override
  State<SettingPassword> createState() => _SettingPasswordState();
}

class _SettingPasswordState extends State<SettingPassword> {
  SettingBloc get bloc => BlocProvider.of(context);
  final TextEditingController _controllerCurrentPassword =
      TextEditingController();
  final TextEditingController _controllerNewPassword = TextEditingController();
  bool showPass1 = true;
  bool showPass2 = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return CustomScreenForm(
        title: translation(context).setting,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: false,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.backgroundColor,
        selectedIndex: 2,
        child:
            BlocConsumer<SettingBloc, SettingState>(listener: (context, state) {
          //! CHANGE PASS SUCCESSFULLY
          if (state is ChangePassState) {
            if (state.status == BlocStatusState.success) {
              showSuccessDialog(
                  onClose: () {
                    Navigator.pop(context);
                  },
                  context: context,
                  message: translation(context).changePassSuccessText,
                  title: translation(context).updatePasswordSuccessfullly,
                  titleBtn: translation(context).accept);
            }

            if (state.status == BlocStatusState.failure) {
              //! WIFI DISCONNECT
              if (state.viewModel.isWifiDisconnect == true) {
                showExceptionDialog(
                    context: context,
                    message: translation(context).wifiDisconnect,
                    titleBtn: translation(context).exit);
              }
              //! ERROR CURRENT PASSWORD
              if (state.viewModel.isCurrentPassWrong == true) {
                showExceptionDialog(
                    context: context,
                    message: translation(context).currentPassWrong,
                    titleBtn: translation(context).exit);
              }
            }
          }
        }, builder: (context, state) {
          if (state is ChangePassState &&
              state.status == BlocStatusState.loading) {
            return const Center(
              child: Loading(
                brightness: Brightness.light,
              ),
            );
          }
          return Container(
            margin: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.06,
                right: SizeConfig.screenWidth * 0.06),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.05),
                    Text(translation(context).updatePassword,
                        style: AppTextTheme.body0.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.screenWidth * 0.06)),
                    lineDecor(),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    Container(
                      height: SizeConfig.screenWidth * 0.2,
                      width: SizeConfig.screenWidth * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.02,
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.85,
                            child: TextField(
                              // focusNode: _focusNode,
                              cursorColor: AppColor.gray767676,
                              controller: _controllerCurrentPassword,
                              obscureText: showPass1,
                              style: TextStyle(
                                fontSize: SizeConfig.screenWidth * 0.05,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                iconColor: AppColor.primaryColorLight,
                                contentPadding:
                                    const EdgeInsets.only(bottom: 5, top: 5),
                                errorText:
                                    state.viewModel.errorEmptyCurrentPassword ==
                                            true
                                        ? translation(context)
                                            .pleaseEnterYourCurrentPassword
                                        : null,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      showPass1
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      size: SizeConfig.screenWidth * 0.05),
                                  onPressed: () {
                                    setState(() {
                                      showPass1 = !showPass1;
                                    });
                                  },
                                ),
                                icon: Icon(Icons.lock,
                                    size: SizeConfig.screenWidth * 0.1),
                                border: InputBorder.none,
                                labelText: translation(context).oldPassword,
                                labelStyle: TextStyle(
                                    color: AppColor.gray767676,
                                    fontSize: SizeConfig.screenWidth * 0.05),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    Container(
                      height: SizeConfig.screenWidth * 0.2,
                      width: SizeConfig.screenWidth * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.02,
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.85,
                            child: TextField(
                              // focusNode: _focusNode,
                              cursorColor: AppColor.gray767676,
                              controller: _controllerNewPassword,
                              obscureText: showPass2,
                              style: TextStyle(
                                fontSize: SizeConfig.screenWidth * 0.05,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                iconColor: AppColor.primaryColorLight,
                                contentPadding:
                                    const EdgeInsets.only(bottom: 5, top: 5),
                                errorText:
                                    state.viewModel.errorEmptyNewPassword ==
                                            true
                                        ? translation(context)
                                            .pleaseEnterYourNewPassword
                                        : null,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      showPass2
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      size: SizeConfig.screenWidth * 0.05),
                                  onPressed: () {
                                    setState(() {
                                      showPass2 = !showPass2;
                                    });
                                  },
                                ),
                                icon: Icon(Icons.lock,
                                    size: SizeConfig.screenWidth * 0.1),
                                border: InputBorder.none,
                                labelText: translation(context).newPassword,
                                labelStyle: TextStyle(
                                    color: AppColor.gray767676,
                                    fontSize: SizeConfig.screenWidth * 0.05),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.03),
                    Center(
                      child: RectangleButton(
                          height: SizeConfig.screenHeight * 0.07,
                          title: translation(context).save,
                          buttonColor: AppColor.saveSetting,
                          onTap: () {
                            final changePassEntity = ChangePassEntity(
                                currentPassword:
                                    _controllerCurrentPassword.text,
                                newPassword: _controllerNewPassword.text);
                            bloc.add(ChangePassEvent(
                                changePassEntity: changePassEntity,
                                userId: userDataData.getUser()!.id));
                          }),
                    )
                  ]),
            ),
          );
        }));
  }
}
