import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/domain/entities/login_entity_group/account_entity.dart';
import 'package:mobile_health_check/function.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/common_widget/dialog/exception_dialog.dart';
import 'package:mobile_health_check/presentation/common_widget/dialog/success_dialog.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';

import '../../../../classes/language.dart';
import '../../../common_widget/loading_widget.dart';
import '../../../common_widget/rectangle_button.dart';
import '../../../common_widget/enum_common.dart';
import '../../../common_widget/screen_form/custom_screen_form.dart';
import '../../../route/route_list.dart';
import '../../../theme/theme_color.dart';
import '../bloc/get_patient_bloc.dart';

class AddRelativeScreen extends StatefulWidget {
  final String patientId;

  const AddRelativeScreen({Key? key, required this.patientId})
      : super(key: key);
  @override
  State<AddRelativeScreen> createState() => _AddRelativeScreenState();
}

class _AddRelativeScreenState extends State<AddRelativeScreen> {
  final TextEditingController _controllerRelativeName = TextEditingController();
  final TextEditingController _controllerRelativePhoneNumber =
      TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  GetPatientBloc get patientBloc => BlocProvider.of(context);
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return CustomScreenForm(
        title: translation(context).addRelative,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: false,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.backgroundColor,
        // selectedIndex: 2,
        child: BlocConsumer<GetPatientBloc, GetPatientState>(
          listener: (context, state) {
//! ADD RELATIVE SUCCESSFULLY
            if (state is RegistRelativeState &&
                state.status == BlocStatusState.success) {
              showSuccessDialog(
                  onClose: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RouteList.patientInfor,
                      arguments: widget.patientId,
                    );
                  },
                  context: context,
                  message: translation(context).addRelativeSuccessText,
                  title: translation(context).addRelativeSuccessfully,
                  titleBtn: translation(context).exit);
            }

//! EXCEPTION
            if (state is RegistRelativeState &&
                state.status == BlocStatusState.failure &&
                (state.viewModel.errorMessage ==
                        translation(context).duplicatedRelationshipPAR ||
                    state.viewModel.errorMessage ==
                        translation(context).maximumRelativeCount ||
                    state.viewModel.errorMessage ==
                        translation(context).error)) {
              showExceptionDialog(
                context: context,
                message: state.viewModel.errorMessage!,
                titleBtn: translation(context).exit,
              );
            }
//! WIFI DISCONNECT
            if (state.status == BlocStatusState.failure &&
                state.viewModel.errorMessage ==
                    translation(context).wifiDisconnect) {
              showExceptionDialog(
                  context: context,
                  message: translation(context).wifiDisconnect,
                  titleBtn: translation(context).exit);
            }
          },
          builder: (context, state) {
            if (state.status == BlocStatusState.loading) {
              return const Center(
                  child: Loading(
                brightness: Brightness.light,
              ));
            }
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.screenWidth * 0.05,
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                ),
                height: SizeConfig.screenHeight * 0.8,
                width: SizeConfig.screenWidth * 0.9,
                child: ListView(children: [
                  Container(
                      margin: EdgeInsets.only(
                        top: SizeConfig.screenWidth * 0.01,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            translation(context).relativeIn4,
                            style: TextStyle(
                                fontSize: SizeConfig.screenWidth * 0.06,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          lineDecor(),
                          SizedBox(
                            height: SizeConfig.screenWidth * 0.03,
                          )
                        ],
                      )),
                  Container(
                    margin:
                        EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                    padding:
                        EdgeInsets.only(left: SizeConfig.screenWidth * 0.04),
                    height: SizeConfig.screenWidth * 0.2,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius:
                          BorderRadius.circular(SizeConfig.screenWidth * 0.035),
                    ),
                    child: SizedBox(
                      height: SizeConfig.screenWidth * 0.2,
                      width: SizeConfig.screenWidth * 0.9,
                      child: TextField(
                        textAlign: TextAlign.start,
                        cursorColor: AppColor.gray767676,
                        controller: _controllerRelativeName,
                        style: TextStyle(
                            color: AppColor.gray767676,
                            fontSize: SizeConfig.screenWidth * 0.06),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(bottom: 3, top: 5),
                          errorText: state.viewModel.errorEmptyName ==
                                  translation(context).pleaseEnterRelativeName
                              ? state.viewModel.errorEmptyName
                              : null,
                          labelText: translation(context).name,
                          labelStyle: TextStyle(
                              color: AppColor.gray767676,
                              fontSize: SizeConfig.screenWidth * 0.05,
                              fontWeight: FontWeight.w400),
                          border: InputBorder.none,
                          // icon: Icon(Icons.account_box_rounded,
                          //     size: SizeConfig.screenWidth * 0.12),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                    padding:
                        EdgeInsets.only(left: SizeConfig.screenWidth * 0.04),
                    height: SizeConfig.screenWidth * 0.2,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius:
                          BorderRadius.circular(SizeConfig.screenWidth * 0.035),
                    ),
                    child: SizedBox(
                      height: SizeConfig.screenWidth * 0.2,
                      width: SizeConfig.screenWidth * 0.9,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.start,
                        cursorColor: AppColor.gray767676,
                        controller: _controllerRelativePhoneNumber,
                        style: TextStyle(
                            color: AppColor.gray767676,
                            fontSize: SizeConfig.screenWidth * 0.06),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(bottom: 3, top: 5),
                          errorText: state.viewModel.errorEmptyPhoneNumber ==
                                  translation(context).invalidPhonenumber
                              ? state.viewModel.errorEmptyPhoneNumber
                              : null,
                          labelText: translation(context).phoneNumber,
                          labelStyle: TextStyle(
                              color: AppColor.gray767676,
                              fontSize: SizeConfig.screenWidth * 0.05,
                              fontWeight: FontWeight.w400),
                          border: InputBorder.none,
                          // icon: Icon(Icons.account_box_rounded,
                          //     size: SizeConfig.screenWidth * 0.12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Center(
                    child: RectangleButton(
                        width: SizeConfig.screenWidth * 0.9,
                        height: SizeConfig.screenHeight * 0.07,
                        title: translation(context).save,
                        buttonColor: AppColor.saveSetting,
                        onTap: () {
                          AccountEntity? accountEntity = AccountEntity(
                            name: _controllerRelativeName.text,
                            phoneNumber: _controllerRelativePhoneNumber.text,
                          );

                          patientBloc.add(RegistRelativeEvent(
                              accountEntity: accountEntity,
                              patientId: widget.patientId));
                        }),
                  )
                ]),
              ),
            );
          },
        ));
  }
}
