import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/domain/entities/login_entity_group/account_entity.dart';
import 'package:mobile_health_check/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/route/route_list.dart';
import '../../../../../classes/language.dart';
import '../../../../common_widget/common.dart';
import '../../../../theme/theme_color.dart';
import '../../bloc/admin_bloc.dart';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({
    super.key,
  });
  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  GetDoctorBloc get bloc => BlocProvider.of(context);

  final TextEditingController _controllerDoctorName = TextEditingController();
  final TextEditingController _controllerDoctorPhoneNumber =
      TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return CustomScreenForm(
        title: translation(context).doctorIn4,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: false,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.backgroundColor,
        child: BlocConsumer<GetDoctorBloc, GetDoctorState>(
          listener: (context, state) {
            //! ADD Doctor SUCCESSFULLY
            if (state is RegistDoctorState &&
                state.status == BlocStatusState.success) {
              showSuccessDialog(
                  onClose: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteList.doctorList,
                        arguments: userDataData.getUser()!.id,
                        (route) => false);
                  },
                  context: context,
                  message: translation(context).addDoctorSuccessText,
                  title: translation(context).addDoctorSuccessfully,
                  titleBtn: translation(context).exit);
            }

            //! EXCEPTION
            if (state is RegistDoctorState &&
                state.status == BlocStatusState.failure &&
                (state.viewModel.errorMessage ==
                        translation(context).duplicatedDoctorPhoneNumber ||
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
                            translation(context).doctorIn4,
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
                        controller: _controllerDoctorName,
                        style: TextStyle(
                            color: AppColor.gray767676,
                            fontSize: SizeConfig.screenWidth * 0.06),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(bottom: 3, top: 5),
                          errorText: (state.viewModel.errorEmptyName ==
                                  translation(context).pleaseEnterDoctorName)
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
                        controller: _controllerDoctorPhoneNumber,
                        style: TextStyle(
                            color: AppColor.gray767676,
                            fontSize: SizeConfig.screenWidth * 0.06),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(bottom: 3, top: 5),
                          errorText: (state.viewModel.errorEmptyPhoneNumber ==
                                  translation(context).invalidPhonenumber)
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
                            name: _controllerDoctorName.text,
                            phoneNumber: _controllerDoctorPhoneNumber.text,
                          );
                          bloc.add(RegistDoctorEvent(
                            accountEntity: accountEntity,
                          ));
                        }),
                  )
                ]),
              ),
            );
          },
        ));
  }
}
