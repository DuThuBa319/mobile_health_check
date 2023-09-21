import 'package:mobile_health_check/function.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';

import '../../../../classes/language.dart';
import '../../../../data/models/relative_model/relative_infor_model.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/screen_form/custom_screen_form.dart';
import '../../../theme/theme_color.dart';
import '../bloc/get_patient_bloc.dart';

class AddRelativeScreen extends StatefulWidget {
  final String? patientId;
  final GetPatientBloc? patientBloc;
  const AddRelativeScreen(
      {Key? key, required this.patientId, required this.patientBloc})
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
                    controller: _controllerRelativeName,
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
                    controller: _controllerRelativePhoneNumber,
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
                          _controllerRelativePhoneNumber.text.length;
                      if (phoneNumberCount == 10 || phoneNumberCount == 11) {
                        RelativeInforModel? newRelativeInforModel =
                            RelativeInforModel(
                          name: _controllerRelativeName.text,
                          phoneNumber: _controllerRelativePhoneNumber.text,
                        );

                        widget.patientBloc?.add(RegistRelativeEvent(
                            relativeInforModel: newRelativeInforModel,
                            patientId: widget.patientId));

                        // Navigator.pushNamed(context, RouteList.patientInfor,
                        //         arguments: widget.patientId);

                        //     showToast(translation(context).addRelativeSuccessfully);
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => Center(
                            child: AlertDialog(
                              title: Text(translation(context).notification),
                              content: Text(
                                "Số điện thoại không chính xác, phải từ 10-11 ký tự",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              actions: [
                                TextButton(
                                    child: Text(translation(context).exit),
                                    onPressed: () {
                                      //Navigator.pop(context);
                                      Navigator.pop(context);
                                    }),
                              ],
                            ),
                          ),
                        );
                      }
                    }),
              )
            ]),
          ),
        ));
  }
}
