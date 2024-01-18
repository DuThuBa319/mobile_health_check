import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/domain/entities/login_entity_group/account_entity.dart';
import 'package:mobile_health_check/utils/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../classes/language.dart';

import '../../../common_widget/common.dart';
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
            if (state.status == BlocStatusState.success) {
              if (state is RegistRelativeState) {
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
            }

            //! EXCEPTION, FAILURE
            if (state.status == BlocStatusState.failure) {
              if (state is RegistRelativeState) {
                if (state.viewModel.duplicatedRelationshipPAR == true ||
                    state.viewModel.maximumRelativeCount == true ||
                    state.viewModel.errorMessage ==
                        translation(context).error) {
                  {
                    showExceptionDialog(
                      context: context,
                      message: state.viewModel.errorMessage!,
                      titleBtn: translation(context).exit,
                    );
                  }
                }
              }
              //! WIFI DISCONNECT
              if (state.viewModel.isWifiDisconnect == true) {
                showExceptionDialog(
                    context: context,
                    message: translation(context).wifiDisconnect,
                    titleBtn: translation(context).exit);
              }
            }
          },
          builder: (context, state) {
            if (state.status == BlocStatusState.loading) {
              //? Loading
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
                                fontWeight: FontWeight.bold),
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
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.start,
                        cursorColor: AppColor.gray767676,
                        controller: _controllerRelativeName,
                        style: TextStyle(
                            color: AppColor.gray767676,
                            fontSize: SizeConfig.screenWidth * 0.06),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(bottom: 2, top: 2),
                          errorText: (state.viewModel.errorEmptyName == true)
                              ? translation(context).pleaseEnterRelativeName
                              : null,
                          labelText: translation(context).name,
                          labelStyle: TextStyle(
                              color: AppColor.gray767676,
                              fontSize: SizeConfig.screenWidth * 0.055,
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
                    child: Center(
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
                              const EdgeInsets.only(bottom: 2, top: 2),
                          errorText:
                              (state.viewModel.errorEmptyPhoneNumber == true)
                                  ? translation(context).invalidPhonenumber
                                  : null,
                          labelText: translation(context).phoneNumber,
                          labelStyle: TextStyle(
                              color: AppColor.gray767676,
                              fontSize: SizeConfig.screenWidth * 0.055,
                              fontWeight: FontWeight.w400),
                          border: InputBorder.none,
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
