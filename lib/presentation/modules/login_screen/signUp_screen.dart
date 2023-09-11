import 'package:mobile_health_check/function.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';

import '../../../../../classes/language_constant.dart';
import '../../common_widget/common_button.dart';
import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/screen_form/custom_screen_form.dart';
import '../../theme/theme_color.dart';

class SignUpDoctorScreen extends StatefulWidget {
  const SignUpDoctorScreen({super.key});

  @override
  State<SignUpDoctorScreen> createState() => _SignUpDoctorScreenState();
}

class _SignUpDoctorScreenState extends State<SignUpDoctorScreen> {
  bool showPass = false;
  bool showConfirmPass = false;

  final TextEditingController _controllerDoctorName = TextEditingController();
  final TextEditingController _controllerDoctorAge = TextEditingController();

  final TextEditingController _controllerDoctorPhoneNumber =
      TextEditingController();

  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  final TextEditingController _controllerDoctorGender = TextEditingController();
  // final TextEditingController _controllerDoctorName = TextEditingController();
  // final TextEditingController _controllerDoctorAge = TextEditingController();
  // final TextEditingController _controllerDoctorPhoneNumber =
  //     TextEditingController();
  // final TextEditingController _controllerDoctorSignUpress =
  //     TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    String pass = "";
    String confirmPass = "";
    return CustomScreenForm(
        title: translation(context).signUp,
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
                    controller: _controllerDoctorGender,
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
                    controller: _controllerDoctorAge,
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
                height: SizeConfig.screenWidth * 0.2,
                width: SizeConfig.screenWidth * 0.9,
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.04),
                margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 0.035),
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.02,
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.8,
                    child: TextField(
                      obscureText: showPass,
                      textAlign: TextAlign.start,
                      onChanged: (newPass) {
                        pass = newPass;
                      },
                      cursorColor: AppColor.black,
                      controller: passController,
                      style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.05,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                              showPass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: SizeConfig.screenWidth * 0.05),
                          onPressed: () {
                            setState(() {
                              showPass = !showPass;
                            });
                          },
                        ),
                        border: InputBorder.none,
                        labelText: translation(context).password,
                        labelStyle: TextStyle(
                            color: AppColor.gray767676,
                            fontSize: SizeConfig.screenWidth * 0.05),
                      ),
                    ),
                  ),

                  // Text(selectSetting, style: AppTextTheme.body1.copyWith()),
                ]),
              ),
              Container(
                height: SizeConfig.screenWidth * 0.2,
                width: SizeConfig.screenWidth * 0.9,
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.04),
                margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 0.035),
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.02,
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.8,
                    child: TextField(
                      obscureText: showConfirmPass,
                      textAlign: TextAlign.start,
                      onChanged: (newPass) {
                        confirmPass = newPass;
                      },
                      cursorColor: AppColor.black,
                      controller: confirmPassController,
                      style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.05,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                              showConfirmPass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: SizeConfig.screenWidth * 0.05),
                          onPressed: () {
                            setState(() {
                              showConfirmPass = !showConfirmPass;
                            });
                          },
                        ),
                        border: InputBorder.none,
                        labelText: translation(context).confirmPass,
                        labelStyle: TextStyle(
                            color: AppColor.gray767676,
                            fontSize: SizeConfig.screenWidth * 0.05),
                      ),
                    ),
                  ),

                  // Text(selectSetting, style: AppTextTheme.body1.copyWith()),
                ]),
              ),
//!ĐỊA CHỈ BÁC SĨ
              // Container(
              //   margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
              //   padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.04),
              //   height: SizeConfig.screenWidth * 0.2,
              //   decoration: BoxDecoration(
              //     color: AppColor.white,
              //     borderRadius:
              //         BorderRadius.circular(SizeConfig.screenWidth * 0.035),
              //   ),
              //   child: SizedBox(
              //     height: SizeConfig.screenWidth * 0.2,
              //     width: SizeConfig.screenWidth * 0.9,
              //     child: TextField(
              //       textAlign: TextAlign.start,
              //       cursorColor: AppColor.gray767676,
              //       controller: _controllerDoctorSignUpress,
              //       style: TextStyle(
              //           color: AppColor.gray767676,
              //           fontSize: SizeConfig.screenWidth * 0.06),
              //       decoration: InputDecoration(
              //         labelText: translation(context).address,
              //         labelStyle: TextStyle(
              //             color: AppColor.gray767676,
              //             fontSize: SizeConfig.screenWidth * 0.05,
              //             fontWeight: FontWeight.w400),
              //         border: InputBorder.none,
              //         // icon: Icon(Icons.account_box_rounded,
              //         //     size: SizeConfig.screenWidth * 0.12),
              //       ),
              //     ),
              //   ),
              // ),

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
              // settingProfileCell(userDataData.getUser()!.SignUpress, context,
              //     translation(context).SignUpress),
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
                      // var height = double.parse(_controllerDoctorHeight.text);
                      // var weight = double.parse(_controllerDoctorWeight.text);

                      // int? newAge = int.parse(_controllerDoctorAge.text);
                      // // SignUpressModel? SignUpressModel = SignUpressModel(
                      // //    _controllerDoctorSignUpress.text
                      // //  );
                      // DoctorInforModel newDoctorInforModel =
                      //     DoctorInforModel(
                      //   gender: userDataData.getUser()!.gender == false ? 0 : 1,
                      //   name: _controllerDoctorName.text,
                      //   phoneNumber: _controllerDoctorPhoneNumber.text,
                      //   age: newAge,
                      //   height: height,
                      //   weight: weight,
                      //   id: userDataData.getUser()!.id!,
                      //   // SignUpress: SignUpressModel,
                      // );
                      // // updateDoctorBloc.SignUp(UpdateDoctorInforEvent(
                      // //     model: newDoctorInforModel,
                      // //     id: userDataData.getUser()!.id));
                      // await userDataData.setUser(newDoctorInforModel
                      //     .getDoctorInforEntityDoctorApp()
                      //     .convertUser(user: userDataData.getUser()!)
                      //     .convertToModel());
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      showToast(translation(context).signUpSuccessfully);
                    }),
              )
            ]),
          ),
        ));
  }
}
