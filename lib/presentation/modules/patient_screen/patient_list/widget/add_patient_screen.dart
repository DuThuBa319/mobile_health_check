import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/domain/entities/login_entity_group/account_entity.dart';
import 'package:mobile_health_check/function.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/common_widget/dialog/show_toast.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';
import 'package:mobile_health_check/presentation/route/route_list.dart';

import '../../../../../classes/language.dart';

import '../../../../common_widget/common_button.dart';
import '../../../../common_widget/dialog/dialog_one_button.dart';
import '../../../../common_widget/enum_common.dart';
import '../../../../common_widget/screen_form/custom_screen_form.dart';

import '../../../../theme/theme_color.dart';
import '../../bloc/get_patient_bloc.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({
    super.key,
  });
  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final TextEditingController _controllerPatientName =
      TextEditingController(text: "");
  final TextEditingController _controllerPatientPhoneNumber =
      TextEditingController(text: "");
  @override
  void initState() {
    super.initState();
  }

  GetPatientBloc get bloc => BlocProvider.of(context);
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return CustomScreenForm(
        isRelativeApp:
            (userDataData.getUser()?.role == UserRole.relative) ? true : false,
        title: translation(context).addPatient,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: false,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.backgroundColor,
        leadingButton: IconButton(
            onPressed: () => Navigator.pushNamed(context, RouteList.patientList,
                arguments: userDataData.getUser()!.id!),
            icon: const Icon(Icons.arrow_back)),
        child: BlocConsumer<GetPatientBloc, GetPatientState>(
          listener: (context, state) {
            // if (state is RegistPatientState &&

//! ADD PATIENT SUCCESSFULLY
            if (state is RegistPatientState &&
                state.status == BlocStatusState.success) {
              showToast(translation(context).addPatientSuccessfully);
              showNoticeDialog(
                  onClose: () {
                    Navigator.pushNamed(context, RouteList.patientList,
                        arguments: userDataData.getUser()?.id);
                  },
                  context: context,
                  message: translation(context).addPatientSuccessfully,
                  title: translation(context).notification,
                  titleBtn: translation(context).exit);
            }
//
//! EXCEPTION
            if (state is RegistPatientState &&
                state.status == BlocStatusState.failure &&
                (state.viewModel.errorMessage ==
                        translation(context).duplicatedRelationshipPAD ||
                    state.viewModel.errorMessage ==
                        translation(context).hasDoctorBefore ||
                    state.viewModel.errorMessage ==
                        translation(context).error)) {
              showNoticeDialog(
                context: context,
                message: state.viewModel.errorMessage!,
                title: translation(context).notification,
                titleBtn: translation(context).exit,
              );
            }
//! WIFI DISCONNECT
            if (state is WifiDisconnectState &&
                state.status == BlocStatusState.success) {
              showNoticeDialog(
                  context: context,
                  message: translation(context).wifiDisconnect,
                  title: translation(context).notification,
                  titleBtn: translation(context).exit);
            }
          },
          builder: (context, state) {
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
                            translation(context).patientIn4,
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
                        controller: _controllerPatientName,
                        style: TextStyle(
                            color: AppColor.gray767676,
                            fontSize: SizeConfig.screenWidth * 0.06),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 5, bottom: 5),

                          errorText: state.viewModel.errorEmptyName ==
                                  translation(context).pleaseEnterPatientName
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
                        controller: _controllerPatientPhoneNumber,
                        style: TextStyle(
                            color: AppColor.gray767676,
                            fontSize: SizeConfig.screenWidth * 0.06),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 5, bottom: 5),
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
                      child: CommonButton(
                          width: SizeConfig.screenWidth * 0.9,
                          height: SizeConfig.screenHeight * 0.07,
                          title: translation(context).save,
                          buttonColor: AppColor.saveSetting,
                          onTap: () {
                            // int phoneNumberCount =
                            //     _controllerPatientPhoneNumber.text.length;
                            // if (phoneNumberCount == 10 ||
                            //     phoneNumberCount == 11) {
                            AccountEntity? newPatientAccountEntity =
                                AccountEntity(
                              name: _controllerPatientName.text,
                              phoneNumber: _controllerPatientPhoneNumber.text,
                            );
                            bloc.add(RegistPatientEvent(
                                accountEntity: newPatientAccountEntity,
                                doctorId: userDataData.getUser()!.id));
                            // } else {
                            //   showNoticeDialog(
                            //       context: context,
                            //       message: translation(context)
                            //           .phoneNumberCountError,
                            //       title: translation(context).notification,
                            //       titleBtn: translation(context).exit);
                            // }
                          })),
                ]),
              ),
            );
          },
        ));
  }
}
