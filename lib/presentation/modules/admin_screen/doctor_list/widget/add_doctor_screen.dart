import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/domain/entities/login_entity_group/account_entity.dart';
import 'package:mobile_health_check/function.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';
import 'package:mobile_health_check/presentation/route/route_list.dart';

import '../../../../../classes/language.dart';

import '../../../../common_widget/common_button.dart';
import '../../../../common_widget/dialog/dialog_one_button.dart';
import '../../../../common_widget/screen_form/custom_screen_form.dart';

import '../../../../theme/theme_color.dart';
import '../../bloc/get_doctor_bloc.dart';

class AddDoctorScreen extends StatefulWidget {
  final GetDoctorBloc? getDoctorBloc;
  const AddDoctorScreen({super.key, this.getDoctorBloc});
  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  final TextEditingController _controllerDoctorName =
      TextEditingController(text: "");
  final TextEditingController _controllerDoctorPhoneNumber =
      TextEditingController(text: "");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return CustomScreenForm(
        isRelativeApp: false,
        title: translation(context).addDoctor,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: false,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.backgroundColor,
        leadingButton: IconButton(
            onPressed: () => Navigator.pushNamed(context, RouteList.doctorList,
                arguments: userDataData.getUser()!.id!),
            icon: const Icon(Icons.arrow_back)),
        child: SingleChildScrollView(
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
                margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.04),
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
                margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.04),
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
                        int phoneNumberCount =
                            _controllerDoctorPhoneNumber.text.length;
                        if (phoneNumberCount == 10 || phoneNumberCount == 11) {
                          AccountEntity? newDoctorAccountEntity = AccountEntity(
                            name: _controllerDoctorName.text,
                            phoneNumber: _controllerDoctorPhoneNumber.text,
                          );
                          widget.getDoctorBloc?.add(RegistDoctorEvent(
                            accountEntity: newDoctorAccountEntity,
                          ));
                        } else {
                          showNoticeDialog(
                              context: context,
                              message:
                                  translation(context).phoneNumberCountError,
                              title: translation(context).notification,
                              titleBtn: translation(context).exit);
                        }
                      })),
            ]),
          ),
        ));
  }
}
