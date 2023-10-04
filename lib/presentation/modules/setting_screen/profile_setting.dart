import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/domain/entities/relative_infor_entity.dart';
import 'package:mobile_health_check/function.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/common_widget/dialog/show_toast.dart';
import 'package:mobile_health_check/presentation/route/route_list.dart';

import '../../../classes/language.dart';
import '../../../common/singletons.dart';
import '../../../domain/entities/doctor_infor_entity.dart';
import '../../../domain/entities/patient_infor_entity.dart';
import '../../common_widget/common_button.dart';
import '../../common_widget/screen_form/custom_screen_form_for_patient.dart';
import '../../theme/theme_color.dart';
import '../patient/bloc/get_patient_bloc.dart';

class SettingProfile extends StatefulWidget {
  const SettingProfile({super.key});

  @override
  State<SettingProfile> createState() => _SettingProfileState();
}

class _SettingProfileState extends State<SettingProfile> {
  GetPatientBloc get updatePatientBloc => BlocProvider.of(context);
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();
  final TextEditingController _controllerGender = TextEditingController();

  final TextEditingController _controllerWeight = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerHeight = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  bool isWifiAvailable = false;
  bool is4GAvailable = false;
  double widthCell = SizeConfig.screenWidth * 0.9;
  double heightCell = SizeConfig.screenHeight * 0.11;
  void checkWifiAvailability() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      // ignore: unrelated_type_equality_checks
      isWifiAvailable = connectivityResult == ConnectivityResult.wifi;
      is4GAvailable = connectivityResult == ConnectivityResult.mobile;
    });
  }

  @override
  void initState() {
    checkWifiAvailability();
    super.initState();
    setState(() {
      if (userDataData.getUser()!.role == "relative" ||
          userDataData.getUser()!.role == "doctor") {
        _controllerName.text = userDataData.getUser()!.name!;
        _controllerPhoneNumber.text = userDataData.getUser()!.phoneNumber!;
        _controllerAge.text = "${userDataData.getUser()?.age ?? 0}";
        _controllerAddress.text =
            userDataData.getUser()?.address ?? "chưa có thông tin";
        _controllerGender.text =
            userDataData.getUser()?.gender == 0 ? "Nam" : "Nữ";
      } else {
        _controllerName.text = userDataData.getUser()!.name!;
        _controllerPhoneNumber.text = userDataData.getUser()!.phoneNumber!;
        _controllerAge.text = "${userDataData.getUser()?.age ?? 0}";
        _controllerGender.text =
            userDataData.getUser()?.gender == 0 ? "Nam" : "Nữ";
        _controllerWeight.text =
            "${userDataData.getUser()?.weight?.toInt() ?? 0}";
        _controllerHeight.text =
            "${userDataData.getUser()?.height?.toInt() ?? 0}";
        _controllerAddress.text = userDataData.getUser()?.address ??
            translation(context).doNotHaveInformation;
      }
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
        // selectedIndex: 2,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              top: SizeConfig.screenWidth * 0.05,
              left: SizeConfig.screenWidth * 0.05,
              right: SizeConfig.screenWidth * 0.05,
            ),
            height: SizeConfig.screenHeight * 0.8,
            width: widthCell,
            child: ListView(children: [
              Container(
                margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.03),
                height: heightCell,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 0.035),
                ),
                child: SizedBox(
                  height: heightCell,
                  width: widthCell,
                  child: TextField(
                    textAlign: TextAlign.start,
                    cursorColor: AppColor.black,
                    controller: _controllerName,
                    style: TextStyle(
                        color: AppColor.gray767676,
                        fontSize: SizeConfig.screenWidth * 0.05),
                    decoration: InputDecoration(
                      labelText: translation(context).name,
                      labelStyle: TextStyle(
                          color: AppColor.black,
                          fontSize: SizeConfig.screenWidth * 0.05,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.03),
                height: heightCell,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 0.035),
                ),
                child: SizedBox(
                  height: heightCell,
                  width: widthCell,
                  child: TextField(
                    textAlign: TextAlign.start,
                    cursorColor: AppColor.black,
                    controller: _controllerPhoneNumber,
                    style: TextStyle(
                        color: AppColor.gray767676,
                        fontSize: SizeConfig.screenWidth * 0.05),
                    decoration: InputDecoration(
                      labelText: translation(context).phoneNumber,
                      labelStyle: TextStyle(
                          color: AppColor.black,
                          fontSize: SizeConfig.screenWidth * 0.05,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.03),
                height: heightCell,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 0.035),
                ),
                child: SizedBox(
                  height: heightCell,
                  width: widthCell,
                  child: TextField(
                    textAlign: TextAlign.start,
                    cursorColor: AppColor.black,
                    controller: _controllerAge,
                    style: TextStyle(
                        color: AppColor.gray767676,
                        fontSize: SizeConfig.screenWidth * 0.05),
                    decoration: InputDecoration(
                      labelText: translation(context).age,
                      labelStyle: TextStyle(
                          color: AppColor.black,
                          fontSize: SizeConfig.screenWidth * 0.05,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.03),
                height: heightCell,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 0.035),
                ),
                child: SizedBox(
                  height: heightCell,
                  width: widthCell,
                  child: TextField(
                    textAlign: TextAlign.start,
                    cursorColor: AppColor.black,
                    controller: _controllerGender,
                    style: TextStyle(
                        color: AppColor.gray767676,
                        fontSize: SizeConfig.screenWidth * 0.05),
                    decoration: InputDecoration(
                      labelText: translation(context).gender,
                      labelStyle: TextStyle(
                          color: AppColor.black,
                          fontSize: SizeConfig.screenWidth * 0.05,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              (userDataData.getUser()!.role == "relative" ||
                      userDataData.getUser()!.role == "doctor")
                  ? (const SizedBox())
                  : Container(
                      margin: EdgeInsets.only(
                          bottom: SizeConfig.screenWidth * 0.03),
                      padding:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.03),
                      height: heightCell,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(
                            SizeConfig.screenWidth * 0.035),
                      ),
                      child: SizedBox(
                        height: heightCell,
                        width: widthCell,
                        child: TextField(
                          textAlign: TextAlign.start,
                          cursorColor: AppColor.black,
                          controller: _controllerHeight,
                          style: TextStyle(
                              color: AppColor.gray767676,
                              fontSize: SizeConfig.screenWidth * 0.05),
                          decoration: InputDecoration(
                            labelText: "${translation(context).height} (cm)",
                            labelStyle: TextStyle(
                                color: AppColor.black,
                                fontSize: SizeConfig.screenWidth * 0.05,
                                fontWeight: FontWeight.w500),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
              (userDataData.getUser()!.role == "relative" ||
                      userDataData.getUser()!.role == "doctor")
                  ? (const SizedBox())
                  : Container(
                      margin: EdgeInsets.only(
                          bottom: SizeConfig.screenWidth * 0.03),
                      padding:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.03),
                      height: heightCell,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(
                            SizeConfig.screenWidth * 0.035),
                      ),
                      child: SizedBox(
                        height: heightCell,
                        width: widthCell,
                        child: TextField(
                          textAlign: TextAlign.start,
                          cursorColor: AppColor.black,
                          controller: _controllerWeight,
                          style: TextStyle(
                              color: AppColor.gray767676,
                              fontSize: SizeConfig.screenWidth * 0.05),
                          decoration: InputDecoration(
                            labelText: "${translation(context).weight} (Kg)",
                            labelStyle: TextStyle(
                                color: AppColor.black,
                                fontSize: SizeConfig.screenWidth * 0.05,
                                fontWeight: FontWeight.w500),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
              Container(
                margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.03),
                height: SizeConfig.screenHeight * 0.11,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 0.035),
                ),
                child: SizedBox(
                  height: heightCell,
                  width: widthCell,
                  child: TextField(
                    textAlign: TextAlign.start,
                    cursorColor: AppColor.black,
                    controller: _controllerAddress,
                    style: TextStyle(
                        color: AppColor.gray767676,
                        fontSize: SizeConfig.screenWidth * 0.05),
                    decoration: InputDecoration(
                      labelText: translation(context).address,
                      labelStyle: TextStyle(
                          color: AppColor.black,
                          fontSize: SizeConfig.screenWidth * 0.05,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              Center(
                child: CommonButton(
                    width: widthCell,
                    height: SizeConfig.screenHeight * 0.07,
                    title: translation(context).save,
                    buttonColor: AppColor.saveSetting,
                    onTap: () async {
                      if (isWifiAvailable || is4GAvailable) {
                        final int gender;
                        int? newAge = int.parse(_controllerAge.text);
                        if (_controllerGender.text == "Nam" ||
                            _controllerGender.text == "nam" ||
                            _controllerGender.text == "male" ||
                            _controllerGender.text == "Male") {
                          gender = 0;
                        } else {
                          gender = 1;
                        }

                        if (userDataData.getUser()!.role == "relative") {
                          RelativeInforEntity newRelativeInforEntity =
                              RelativeInforEntity(
                            gender: gender,
                            name: _controllerName.text,
                            phoneNumber: _controllerPhoneNumber.text,
                            age: newAge,
                            id: userDataData.getUser()!.id!,
                            address: _controllerAddress.text,
                            personType: 2,
                          );

                          updatePatientBloc.add(UpdateRelativeInforEvent(
                              relativeInforEntity: newRelativeInforEntity,
                              id: userDataData.getUser()!.id));
                          await userDataData.setUser(newRelativeInforEntity
                              .convertUser(user: userDataData.getUser()!)
                              .convertToModel());
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(context, RouteList.setting);
                          // ignore: use_build_context_synchronously
                        }
                        if (userDataData.getUser()!.role == "doctor") {
                          DoctorInforEntity newDoctorInforEntity =
                              DoctorInforEntity(
                            gender: gender,
                            name: _controllerName.text,
                            phoneNumber: _controllerPhoneNumber.text,
                            age: newAge,
                            id: userDataData.getUser()!.id!,
                            address: _controllerAddress.text,
                            personType: 2,
                          );

                          updatePatientBloc.add(UpdateDoctorInforEvent(
                              doctorInforEntity: newDoctorInforEntity,
                              id: userDataData.getUser()!.id));
                          await userDataData.setUser(newDoctorInforEntity
                              .convertUser(user: userDataData.getUser()!)
                              .convertToModel());
                        } else {
                          var height = double.parse(_controllerHeight.text);
                          var weight = double.parse(_controllerWeight.text);
                          PatientInforEntity newPatientInforEntity =
                              PatientInforEntity(
                            gender: gender,
                            personType: 0,
                            // gender:
                            //     userDataData.getUser()?.gender == 0? : 1,
                            name: _controllerName.text,
                            phoneNumber: _controllerPhoneNumber.text,
                            age: newAge,
                            height: height,
                            weight: weight,
                            id: userDataData.getUser()?.id!,
                            address: _controllerAddress.text,
                            // doctor: userDataData.getUser()?.doctor,
                            // relatives: userDataData.getUser()?.relatives,
                          );

                          updatePatientBloc.add(UpdatePatientInforEvent(
                              patientInforEntity: newPatientInforEntity,
                              id: userDataData.getUser()?.id));
                          await userDataData.setUser(newPatientInforEntity
                              .convertUser(user: userDataData.getUser()!)
                              .convertToModel());
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(
                              context, RouteList.patientSetting);
                          // ignore: use_build_context_synchronously;
                        }
                        // ignore: use_build_context_synchronously

                        showToast(
                            // ignore: use_build_context_synchronously
                            translation(context).updateProfileSuccessfully);
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  translation(context).notification,
                                  style: TextStyle(
                                      color: AppColor.lineDecor,
                                      fontSize: SizeConfig.screenWidth * 0.08,
                                      fontWeight: FontWeight.bold),
                                ),
                                content: Text(
                                  translation(context).wifiDisconnect,
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: SizeConfig.screenWidth * 0.05,
                                      fontWeight: FontWeight.w400),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text(translation(context).accept),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                    }),
              )
            ]),
          ),
        ));
  }
}
