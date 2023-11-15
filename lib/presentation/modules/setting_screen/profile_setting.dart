import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/common/service/navigation/navigation_service.dart';
import 'package:mobile_health_check/domain/entities/relative_infor_entity.dart';
import 'package:mobile_health_check/function.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/common_widget/dialog/dialog_one_button.dart';
import 'package:mobile_health_check/presentation/common_widget/dialog/show_toast.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';
import 'package:mobile_health_check/presentation/common_widget/loading_widget.dart';
import 'package:mobile_health_check/presentation/modules/setting_screen/setting_bloc/setting_bloc.dart';

import '../../../classes/language.dart';
import '../../../common/singletons.dart';
import '../../../di/di.dart';
import '../../../domain/entities/doctor_infor_entity.dart';
import '../../../domain/entities/patient_infor_entity.dart';
import '../../common_widget/rectangle_button.dart';
import '../../common_widget/enum_common.dart';
import '../../common_widget/screen_form/custom_screen_form.dart';
import '../../theme/theme_color.dart';

class SettingProfile extends StatefulWidget {
  const SettingProfile({super.key});

  @override
  State<SettingProfile> createState() => _SettingProfileState();
}

class _SettingProfileState extends State<SettingProfile> {
  SettingBloc get updatePatientBloc => BlocProvider.of(context);
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
  late Map<TextEditingController, String> _errorMessages;

  @override
  void initState() {
    NavigationService navigationService = injector<NavigationService>();

    // checkWifiAvailability();
    super.initState();
    // ignore: unrelated_type_equality_checks
    (userDataData.getUser()?.role == UserRole.doctor ||
            // ignore: unrelated_type_equality_checks
            userDataData.getUser()?.role == UserRole.relative ||
            userDataData.getUser()?.role == UserRole.admin)
        ? _errorMessages = {
            _controllerName:
                translation(navigationService.navigatorKey.currentContext!)
                    .pleaseUpdateYourName,
            _controllerAge:
                translation(navigationService.navigatorKey.currentContext!)
                    .pleaseUpdateYourAge,
            _controllerGender:
                translation(navigationService.navigatorKey.currentContext!)
                    .pleaseUpdateYourGender,
            _controllerPhoneNumber:
                translation(navigationService.navigatorKey.currentContext!)
                    .pleaseUpdateYourPhoneNumber,
            _controllerAddress:
                translation(navigationService.navigatorKey.currentContext!)
                    .pleaseUpdateYourAddress,
          }
        : _errorMessages = {
            _controllerName:
                translation(navigationService.navigatorKey.currentContext!)
                    .pleaseUpdateYourName,
            _controllerAge:
                translation(navigationService.navigatorKey.currentContext!)
                    .pleaseUpdateYourAge,
            _controllerGender:
                translation(navigationService.navigatorKey.currentContext!)
                    .pleaseUpdateYourGender,
            _controllerPhoneNumber:
                translation(navigationService.navigatorKey.currentContext!)
                    .pleaseUpdateYourPhoneNumber,
            _controllerAddress:
                translation(navigationService.navigatorKey.currentContext!)
                    .pleaseUpdateYourAddress,
            _controllerWeight:
                translation(navigationService.navigatorKey.currentContext!)
                    .pleaseUpdateYourWeight,
            _controllerHeight:
                translation(navigationService.navigatorKey.currentContext!)
                    .pleaseUpdateYourHeight,
          };
    setState(() {
      if (userDataData.getUser()?.role == UserRole.relative ||
          userDataData.getUser()?.role == UserRole.doctor ||
          userDataData.getUser()?.role == UserRole.admin) {
        _controllerName.text = userDataData.getUser()!.name!;
        _controllerPhoneNumber.text = userDataData.getUser()!.phoneNumber!;
        _controllerAge.text = "${userDataData.getUser()?.age ?? 0}";
        _controllerAddress.text = userDataData.getUser()?.address ??
            translation(navigationService.navigatorKey.currentContext!)
                .notUpdate;
        _controllerGender.text = userDataData.getUser()?.gender == 0
            ? translation(navigationService.navigatorKey.currentContext!).male
            : translation(navigationService.navigatorKey.currentContext!)
                .female;
        _controllerWeight.text =
            "${userDataData.getUser()?.weight?.toInt() ?? 0}";
        _controllerHeight.text =
            "${userDataData.getUser()?.height?.toInt() ?? 0}";
      } else {
        _controllerName.text = userDataData.getUser()!.name!;
        _controllerPhoneNumber.text = userDataData.getUser()!.phoneNumber!;
        _controllerAge.text = "${userDataData.getUser()?.age ?? 0}";
        _controllerGender.text = userDataData.getUser()?.gender == 0
            ? translation(navigationService.navigatorKey.currentContext!).male
            : translation(navigationService.navigatorKey.currentContext!)
                .female;

        _controllerWeight.text =
            "${userDataData.getUser()?.weight?.toInt() ?? 0}";
        _controllerHeight.text =
            "${userDataData.getUser()?.height?.toInt() ?? 0}";
        _controllerAddress.text = userDataData.getUser()?.address ??
            translation(context).doNotHaveInformation;
      }
    });
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Container(
      margin: EdgeInsets.only(
          bottom: SizeConfig.screenHeight * 0.01,
          left: SizeConfig.screenWidth * 0.03,
          right: SizeConfig.screenWidth * 0.03),
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.02,
      ), // You can adjust this margin
      height: SizeConfig.screenHeight * 0.1, // You can adjust this padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: TextField(
          keyboardType: (controller == _controllerAge ||
                  controller == _controllerWeight ||
                  controller == _controllerHeight ||
                  controller == _controllerPhoneNumber)
              ? TextInputType.number
              : TextInputType.text,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: AppColor.gray767676,
              fontSize: SizeConfig.screenWidth * 0.065),
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
            border: InputBorder.none,
            labelText: label,
            labelStyle: TextStyle(
                color: const Color.fromARGB(255, 48, 48, 48),
                fontSize: SizeConfig.screenWidth * 0.05,
                fontWeight: FontWeight.w500),
            errorText:
                controller.text.isEmpty ? _errorMessages[controller] : null,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return CustomScreenForm(
        title: translation(context).setting,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: false,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.backgroundColor,
        // selectedIndex: 2,
        child:
            BlocConsumer<SettingBloc, SettingState>(listener: (context, state) {
          if (((state is UpdateDoctorInforState) ||
                  (state is UpdateRelativeInforState) ||
                  (state is UpdatePatientInforState)) &&
              state.status == BlocStatusState.success) {
            //! UPDATE PROFILE SUCCESSFULLY
            showNoticeDialog(
                onClose: () {
                  Navigator.pop(context);
                },
                context: context,
                message: translation(context).updateProfileSuccessfully,
                title: translation(context).notification,
                titleBtn: translation(context).accept);
          }
          //! WIFI DISCONNECT
          if (state is WifiDisconnectState &&
              state.status == BlocStatusState.success) {
            showNoticeDialog(
                context: context,
                message: translation(context).wifiDisconnect,
                title: translation(context).notification,
                titleBtn: translation(context).accept);
          }
          // //! LOADING
          if (((state is UpdateDoctorInforState) ||
                  (state is UpdateRelativeInforState) ||
                  (state is UpdatePatientInforState)) &&
              state.status == BlocStatusState.loading) {
            showToast(translation(context).loadingData);
          }
        }, builder: (context, state) {
          if (((state is UpdateDoctorInforState) ||
                  (state is UpdateRelativeInforState) ||
                  (state is UpdatePatientInforState)) &&
              state.status == BlocStatusState.loading) {
            return const Center(
              child: Loading(
                brightness: Brightness.light,
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  lineDecor(
                      spaceTop: SizeConfig.screenHeight * 0.03,
                      spaceLeft: SizeConfig.screenWidth * 0.03,
                      spaceBottom: SizeConfig.screenHeight * 0.012),
                  _buildTextField(_controllerName, translation(context).name),
                  _buildTextField(
                      _controllerPhoneNumber, translation(context).phoneNumber),
                  userDataData.getUser()?.role == UserRole.admin
                      ? const SizedBox(height: 0.1)
                      : _buildTextField(
                          _controllerAge, translation(context).age),
                  userDataData.getUser()?.role == UserRole.admin
                      ? const SizedBox(height: 0.1)
                      : _buildTextField(
                          _controllerGender, translation(context).gender),
                  // ignore: unrelated_type_equality_checks
                  userDataData.getUser()?.role == UserRole.patient
                      ? _buildTextField(_controllerHeight,
                          '${translation(context).height} (cm)')
                      : const SizedBox(height: 0.1),
                  // ignore: unrelated_type_equality_checks
                  userDataData.getUser()?.role == UserRole.patient
                      ? _buildTextField(_controllerWeight,
                          '${translation(context).weight} (Kg)')
                      : const SizedBox(height: 0.1),
                  userDataData.getUser()?.role == UserRole.admin
                      ? const SizedBox(height: 0.1)
                      : _buildTextField(
                          _controllerAddress, translation(context).address),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  Center(
                    child: RectangleButton(
                        width: widthCell,
                        height: SizeConfig.screenHeight * 0.07,
                        title: translation(context).save,
                        buttonColor: AppColor.saveSetting,
                        onTap: () async {
                          if (_controllerAddress.text.isEmpty ||
                              _controllerAge.text.isEmpty ||
                              _controllerGender.text.isEmpty ||
                              _controllerHeight.text.isEmpty ||
                              _controllerPhoneNumber.text.isEmpty ||
                              _controllerWeight.text.isEmpty ||
                              _controllerName.text.isEmpty) {
                            showToast(translation(context)
                                .pleaseEnterCompleteInformation);
                          } else {
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

                            if (userDataData.getUser()?.role ==
                                UserRole.relative) {
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
                            }

                            if (userDataData.getUser()?.role ==
                                UserRole.doctor) {
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
                            } else if (userDataData.getUser()?.role ==
                                UserRole.patient) {
                              var height = double.parse(_controllerHeight.text);
                              var weight = double.parse(_controllerWeight.text);
                              PatientInforEntity newPatientInforEntity =
                                  PatientInforEntity(
                                gender: gender,
                                personType: 0,
                                name: _controllerName.text,
                                phoneNumber: _controllerPhoneNumber.text,
                                age: newAge,
                                height: height,
                                weight: weight,
                                id: userDataData.getUser()?.id!,
                                address: _controllerAddress.text,
                              );

                              updatePatientBloc.add(UpdatePatientInforEvent(
                                  patientInforEntity: newPatientInforEntity,
                                  id: userDataData.getUser()?.id));
                              await userDataData.setUser(newPatientInforEntity
                                  .convertUser(user: userDataData.getUser()!)
                                  .convertToModel());
                            }
                          }
                        }
                        // }
                        ),
                  )
                ]),
          );
        }));
  }
}
