import 'package:mobile_health_check/function.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/common_widget/dialog/show_toast.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';

import '../../../../../classes/language_constant.dart';

import '../../../../common_widget/common_button.dart';
import '../../../../common_widget/screen_form/custom_screen_form.dart';

import '../../../../theme/theme_color.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final TextEditingController _controllerPatientName = TextEditingController();
  final TextEditingController _controllerPatientAge = TextEditingController();
  final TextEditingController _controllerPatientWeight =
      TextEditingController();
  final TextEditingController _controllerPatientPhoneNumber =
      TextEditingController();
  final TextEditingController _controllerPatientHeight =
      TextEditingController();
  final TextEditingController _controllerPatientAddress =
      TextEditingController();
  final TextEditingController _controllerPatientGender =
      TextEditingController();
  // final TextEditingController _controllerRelativeName = TextEditingController();
  // final TextEditingController _controllerRelativeAge = TextEditingController();
  // final TextEditingController _controllerRelativePhoneNumber =
  //     TextEditingController();
  // final TextEditingController _controllerRelativeAddress =
  //     TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
                    controller: _controllerPatientName,
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
                    textAlign: TextAlign.start,
                    cursorColor: AppColor.gray767676,
                    controller: _controllerPatientPhoneNumber,
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
                    controller: _controllerPatientGender,
                    style: TextStyle(
                        color: AppColor.gray767676,
                        fontSize: SizeConfig.screenWidth * 0.06),
                    decoration: InputDecoration(
                      labelText: translation(context).gender,
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
                    textAlign: TextAlign.start,
                    cursorColor: AppColor.gray767676,
                    controller: _controllerPatientAge,
                    style: TextStyle(
                        color: AppColor.gray767676,
                        fontSize: SizeConfig.screenWidth * 0.06),
                    decoration: InputDecoration(
                      labelText: translation(context).age,
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
                    textAlign: TextAlign.start,
                    cursorColor: AppColor.gray767676,
                    controller: _controllerPatientAddress,
                    style: TextStyle(
                        color: AppColor.gray767676,
                        fontSize: SizeConfig.screenWidth * 0.06),
                    decoration: InputDecoration(
                      labelText: translation(context).address,
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
              // settingProfileCell(userDataData.getUser()!.Address, context,
              //     translation(context).Address),
              // settingProfileCell(userDataData.getUser()!.city, context,
              //     translation(context).city),
              // settingProfileCell(userDataData.getUser()!.country, context,
              //     translation(context).country),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Center(
                child: CommonButton(
                    width: SizeConfig.screenWidth * 0.9,
                    height: SizeConfig.screenHeight * 0.07,
                    title: translation(context).save,
                    buttonColor: AppColor.saveSetting,
                    onTap: () async {
                      // var height = double.parse(_controllerPatientHeight.text);
                      // var weight = double.parse(_controllerPatientWeight.text);

                      // int? newAge = int.parse(_controllerPatientAge.text);
                      // // AddressModel? addressModel = AddressModel(
                      // //    _controllerPatientAddress.text
                      // //  );
                      // PatientInforModel newPatientInforModel =
                      //     PatientInforModel(
                      //   gender: userDataData.getUser()!.gender == false ? 0 : 1,
                      //   name: _controllerPatientName.text,
                      //   phoneNumber: _controllerPatientPhoneNumber.text,
                      //   age: newAge,
                      //   height: height,
                      //   weight: weight,
                      //   id: userDataData.getUser()!.id!,
                      //   // address: addressModel,
                      // );
                      // // updatePatientBloc.add(UpdatePatientInforEvent(
                      // //     model: newPatientInforModel,
                      // //     id: userDataData.getUser()!.id));
                      // await userDataData.setUser(newPatientInforModel
                      //     .getPatientInforEntityPatientApp()
                      //     .convertUser(user: userDataData.getUser()!)
                      //     .convertToModel());
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      showToast(translation(context).addPatientSuccessfully);
                    }),
              )
            ]),
          ),
        ));
  }
}
