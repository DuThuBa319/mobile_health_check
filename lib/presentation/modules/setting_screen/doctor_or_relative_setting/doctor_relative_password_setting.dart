// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/domain/entities/change_password_entity.dart';

import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';

import '../../../../classes/language.dart';
import '../../../../common/singletons.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/dialog/dialog_one_button.dart';
import '../../../common_widget/dialog/loading_dialog.dart';
import '../../../common_widget/enum_common.dart';
import '../../../common_widget/line_decor.dart';
import '../../../route/route_list.dart';
import '../../../theme/theme_color.dart';
import '../setting_bloc/setting_bloc.dart';

// ignore: must_be_immutable
class SettingDrOrRePassword extends StatefulWidget {
  const SettingDrOrRePassword({
    Key? key,
  }) : super(key: key);
  @override
  State<SettingDrOrRePassword> createState() => _SettingDrOrRePasswordState();
}

class _SettingDrOrRePasswordState extends State<SettingDrOrRePassword> {
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
        isRelativeApp:
            (userDataData.getUser()?.role == UserRole.relative) ? true : false,
        title: translation(context).updatePassword,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: false,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.backgroundColor,
        leadingButton: IconButton(
            onPressed: () => Navigator.pushNamed(context, RouteList.setting),
            icon: const Icon(Icons.arrow_back)),
        selectedIndex: 2,
        child: SingleChildScrollView(
          child: BlocConsumer<SettingBloc, SettingState>(
              listener: (context, state) {
            //! WIFI DISCONNECT
            if (state is WifiDisconnectState &&
                state.status == BlocStatusState.success) {
              showNoticeDialog(
                  context: context,
                  message: translation(context).wifiDisconnect,
                  title: translation(context).notification,
                  titleBtn: translation(context).accept);
            }

            if (state is ChangePassState &&
                state.status == BlocStatusState.loading) {
              showLoadingDialog(context: context);
            }

            //! ERROR CURRENT PASSWORD
            if (state is ChangePassState &&
                state.status == BlocStatusState.failure &&
                state.viewModel.errorMessage ==
                    translation(context).currentPassWrong) {
              showNoticeDialog(
                  onClose: () {
                    Navigator.pushNamed(
                        context, RouteList.settingDrOrRePassword);
                  },
                  context: context,
                  message: translation(context).currentPassWrong,
                  title: translation(context).notification,
                  titleBtn: translation(context).accept);
            }

            //! CHANGE PASS SUCCESSFULLY
            if (state is ChangePassState &&
                state.status == BlocStatusState.success) {
              showNoticeDialog(
                  onClose: () {
                    Navigator.pushNamed(context, RouteList.setting,
                        arguments: userDataData.getUser()?.id);
                  },
                  context: context,
                  message: translation(context).updatePasswordSuccessfullly,
                  title: translation(context).notification,
                  titleBtn: translation(context).accept);
            }
          }, builder: (context, state) {
            return Container(
              margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.06,
                  right: SizeConfig.screenWidth * 0.06),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.05),
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

                              controller: _controllerCurrentPassword,
                              obscureText: showPass1,
                              style: TextStyle(
                                fontSize: SizeConfig.screenWidth * 0.05,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 5, top: 5),
                                errorText: state.viewModel
                                            .errorEmptyCurrentPassword ==
                                        translation(context)
                                            .pleaseEnterYourCurrentPassword
                                    ? state.viewModel.errorEmptyCurrentPassword
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
                              controller: _controllerNewPassword,
                              obscureText: showPass2,
                              style: TextStyle(
                                fontSize: SizeConfig.screenWidth * 0.05,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 5, top: 5),
                                errorText:
                                    state.viewModel.errorEmptyNewPassword ==
                                            translation(context)
                                                .pleaseEnterYourNewPassword
                                        ? state.viewModel.errorEmptyNewPassword
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
                      child: CommonButton(
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
            );
          }),
        ));
  }
}
