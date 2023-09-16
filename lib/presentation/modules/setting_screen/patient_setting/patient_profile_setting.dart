import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/function.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/common_widget/dialog/show_toast.dart';

import '../../../../classes/language_constant.dart';
import '../../../../common/singletons.dart';
import '../../../../data/models/patient_infor_model/patient_infor_model.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/screen_form/custom_screen_form_for_patient.dart';
import '../../../route/route_list.dart';
import '../../../theme/theme_color.dart';
import '../../patient/bloc/get_patient_bloc.dart';

class SettingPatientProfile extends StatefulWidget {
  const SettingPatientProfile({super.key});

  @override
  State<SettingPatientProfile> createState() => _SettingPatientProfileState();
}

class _SettingPatientProfileState extends State<SettingPatientProfile> {
  GetPatientBloc get updatePatientBloc => BlocProvider.of(context);
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();
  final TextEditingController _controllerWeight = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerHeight = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _controllerAge.text = "${userDataData.getUser()!.age}";
      _controllerName.text = userDataData.getUser()!.name!;
      _controllerWeight.text = "${userDataData.getUser()!.weight!.toInt()}";
      _controllerHeight.text = "${userDataData.getUser()!.height!.toInt()}";
      _controllerPhoneNumber.text = userDataData.getUser()!.phoneNumber!;
      _controllerAddress.text = userDataData.getUser()!.address!;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return PatientCustomScreenForm(
        title: translation(context).setting,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: false,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.backgroundColor,
        leadingButton: IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, RouteList.patientSetting),
            icon: const Icon(Icons.arrow_back)),
        // selectedIndex: 2,
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
                margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.01),
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
                    cursorColor: AppColor.black,
                    controller: _controllerName,
                    style: TextStyle(
                        color: AppColor.gray767676,
                        fontSize: SizeConfig.screenWidth * 0.06),
                    decoration: InputDecoration(
                      labelText: translation(context).name,
                      labelStyle: TextStyle(
                          color: AppColor.black,
                          fontSize: SizeConfig.screenWidth * 0.05,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                      icon: Icon(Icons.account_box_rounded,
                          size: SizeConfig.screenWidth * 0.12),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.01),
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
                    cursorColor: AppColor.black,
                    controller: _controllerPhoneNumber,
                    style: TextStyle(
                        color: AppColor.gray767676,
                        fontSize: SizeConfig.screenWidth * 0.06),
                    decoration: InputDecoration(
                      labelText: translation(context).phoneNumber,
                      labelStyle: TextStyle(
                          color: AppColor.black,
                          fontSize: SizeConfig.screenWidth * 0.05,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                      icon: Icon(Icons.account_box_rounded,
                          size: SizeConfig.screenWidth * 0.12),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.01),
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
                    cursorColor: AppColor.black,
                    controller: _controllerAge,
                    style: TextStyle(
                        color: AppColor.gray767676,
                        fontSize: SizeConfig.screenWidth * 0.06),
                    decoration: InputDecoration(
                      labelText: translation(context).age,
                      labelStyle: TextStyle(
                          color: AppColor.black,
                          fontSize: SizeConfig.screenWidth * 0.05,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                      icon: Icon(Icons.account_box_rounded,
                          size: SizeConfig.screenWidth * 0.12),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.01),
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
                    cursorColor: AppColor.black,
                    controller: _controllerHeight,
                    style: TextStyle(
                        color: AppColor.gray767676,
                        fontSize: SizeConfig.screenWidth * 0.06),
                    decoration: InputDecoration(
                      labelText: translation(context).height,
                      labelStyle: TextStyle(
                          color: AppColor.black,
                          fontSize: SizeConfig.screenWidth * 0.05,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                      icon: Icon(Icons.account_box_rounded,
                          size: SizeConfig.screenWidth * 0.12),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.01),
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
                    cursorColor: AppColor.black,
                    controller: _controllerWeight,
                    style: TextStyle(
                        color: AppColor.gray767676,
                        fontSize: SizeConfig.screenWidth * 0.06),
                    decoration: InputDecoration(
                      labelText: translation(context).weight,
                      labelStyle: TextStyle(
                          color: AppColor.black,
                          fontSize: SizeConfig.screenWidth * 0.05,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                      icon: Icon(Icons.account_box_rounded,
                          size: SizeConfig.screenWidth * 0.12),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.01),
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
                    cursorColor: AppColor.black,
                    controller: _controllerAddress,
                    style: TextStyle(
                        color: AppColor.gray767676,
                        fontSize: SizeConfig.screenWidth * 0.06),
                    decoration: InputDecoration(
                      labelText: translation(context).address,
                      labelStyle: TextStyle(
                          color: AppColor.black,
                          fontSize: SizeConfig.screenWidth * 0.05,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                      icon: Icon(Icons.account_box_rounded,
                          size: SizeConfig.screenWidth * 0.12),
                    ),
                  ),
                ),
              ),

              // settingProfileCell(userDataData.getUser()!.name, context,
              //     translation(context).name),
              // settingProfileCell(userDataData.getUser()!.phoneNumber, context,
              //     translation(context).phoneNumber),
              // settingProfileCell("${userDataData.getUser()!.age}", context,
              //     translation(context).age),
              // settingProfileCell("${userDataData.getUser()!.height?.toInt()}",
              //     context, translation(context).height),
              // settingProfileCell("${userDataData.getUser()!.weight?.toInt()}",
              //     context, translation(context).weight),
              // settingProfileCell(userDataData.getUser()!.street, context,
              //     translation(context).street),
              // settingProfileCell(userDataData.getUser()!.ward, context,
              //     translation(context).ward),
              // settingProfileCell(userDataData.getUser()!.city, context,
              //     translation(context).city),
              // settingProfileCell(userDataData.getUser()!.country, context,
              //     translation(context).country),
              SizedBox(height: SizeConfig.screenHeight * 0.01),
              Center(
                child: CommonButton(
                    width: SizeConfig.screenWidth * 0.9,
                    height: SizeConfig.screenHeight * 0.07,
                    title: translation(context).save,
                    buttonColor: AppColor.saveSetting,
                    onTap: () async {
                      var height = double.parse(_controllerHeight.text);
                      var weight = double.parse(_controllerWeight.text);

                      int? newAge = int.parse(_controllerAge.text);

                      PatientInforModel newPatientInforModel =
                          PatientInforModel(
                        gender: userDataData.getUser()!.gender == false ? 0 : 1,
                        name: _controllerName.text,
                        phoneNumber: _controllerPhoneNumber.text,
                        age: newAge,
                        height: height,
                        weight: weight,
                        id: userDataData.getUser()!.id!,
                        address: _controllerAddress.text,
                      );
                      updatePatientBloc.add(UpdatePatientInforEvent(
                          model: newPatientInforModel,
                          id: userDataData.getUser()!.id));
                      await userDataData.setUser(newPatientInforModel
                          .getPatientInforEntityPatientApp()
                          .convertUser(user: userDataData.getUser()!)
                          .convertToModel());
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      showToast(translation(context).updateProfileSuccessfully);
                    }),
              )
            ]),
          ),
        ));
  }
}
