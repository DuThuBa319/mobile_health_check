import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/domain/entities/login_entity_group/account_entity.dart';
import 'package:mobile_health_check/utils/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../../classes/language.dart';

import '../../../../common_widget/common.dart';
import '../../../../route/route_list.dart';
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
        title: translation(context).addPatient,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: false,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.backgroundColor,
        child: BlocConsumer<GetPatientBloc, GetPatientState>(
          listener: (context, state) {
            //! ADD PATIENT SUCCESSFULLY
            if (state.status == BlocStatusState.success) {
              if (state is RegistPatientState) {
                showToast(translation(context).addPatientSuccessfully);
                showSuccessDialog(
                    onClose: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteList.patientList,
                          arguments: userDataData.getUser()!.id!,
                          (route) => false);
                    },
                    context: context,
                    message: translation(context).addPatientSuccessText,
                    title: translation(context).addPatientSuccessfully,
                    titleBtn: translation(context).exit);
              }
            }

//
            //! EXCEPTION, FAILURE
            if (state.status == BlocStatusState.failure) {
              if (state is RegistPatientState) {
                if (state.viewModel.duplicatedRelationshipPAD == true ||
                    state.viewModel.hasDoctorBefore == true ||
                    state.viewModel.isWifiDisconnect == true ||
                    state.viewModel.errorMessage ==
                        translation(context).error) {
                  showExceptionDialog(
                    context: context,
                    message: state.viewModel.errorMessage!,
                    titleBtn: translation(context).exit,
                  );
                }
              }
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
                            translation(context).patientIn4,
                            style: TextStyle(
                                fontSize: SizeConfig.screenDiagonal * 0.025,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          lineDecor(),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.015,
                          )
                        ],
                      )),
                  Container(
                    margin:
                        EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                    padding:
                        EdgeInsets.only(left: SizeConfig.screenWidth * 0.04),
                    height: SizeConfig.screenHeight * 0.09,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius:
                          BorderRadius.circular(SizeConfig.screenWidth * 0.035),
                    ),
                    child: SizedBox(
                      height: SizeConfig.screenHeight * 0.09,
                      width: SizeConfig.screenWidth * 0.9,
                      child: TextField(
                        textAlign: TextAlign.start,
                        cursorColor: AppColor.gray767676,
                        controller: _controllerPatientName,
                        style: TextStyle(
                            color: AppColor.gray767676,
                            fontSize: SizeConfig.screenDiagonal * 0.025),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 5, bottom: 5),

                          errorText: (state.viewModel.errorEmptyName == true)
                              ? translation(context).pleaseEnterPatientName
                              : null,
                          labelText: translation(context).name,
                          labelStyle: TextStyle(
                              color: AppColor.gray767676,
                              fontSize: SizeConfig.screenDiagonal * 0.022,
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
                    height: SizeConfig.screenHeight * 0.09,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius:
                          BorderRadius.circular(SizeConfig.screenWidth * 0.035),
                    ),
                    child: SizedBox(
                      height: SizeConfig.screenHeight * 0.09,
                      width: SizeConfig.screenWidth * 0.9,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.start,
                        cursorColor: AppColor.gray767676,
                        controller: _controllerPatientPhoneNumber,
                        style: TextStyle(
                            color: AppColor.gray767676,
                            fontSize: SizeConfig.screenDiagonal * 0.025),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 5, bottom: 5),
                          errorText:
                              (state.viewModel.errorEmptyPhoneNumber == true)
                                  ? translation(context).invalidPhonenumber
                                  : null,
                          labelText: translation(context).phoneNumber,
                          labelStyle: TextStyle(
                              color: AppColor.gray767676,
                              fontSize: SizeConfig.screenDiagonal * 0.022,
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
                            AccountEntity? newPatientAccountEntity =
                                AccountEntity(
                              name: _controllerPatientName.text,
                              phoneNumber: _controllerPatientPhoneNumber.text,
                            );
                            bloc.add(RegistPatientEvent(
                                accountEntity: newPatientAccountEntity,
                                doctorId: userDataData.getUser()!.id));
                          })),
                ]),
              ),
            );
          },
        ));
  }
}
