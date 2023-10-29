import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_health_check/domain/entities/spo2_entity.dart';
import 'package:mobile_health_check/domain/entities/temperature_entity.dart';
import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:mobile_health_check/presentation/modules/patient_screen/patient_profile/widget/relative_cell.dart';

import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../classes/language.dart';
import '../../../../common/singletons.dart';
import '../../../../domain/entities/blood_pressure_entity.dart';
import '../../../../domain/entities/blood_sugar_entity.dart';
import '../../../../domain/entities/patient_infor_entity.dart';
import '../../../common_widget/assets.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/dialog/show_toast.dart';
import '../../../common_widget/enum_common.dart';
import '../../../common_widget/line_decor.dart';
import '../../../common_widget/loading_widget.dart';
import '../../../common_widget/screen_form/image_picker_widget/custom_image_picker.dart';

// import '../../bloc/Patientlist/get_Patient_bloc/get_Patient_bloc.dart';
import '../../../route/route_list.dart';
import '../../../theme/theme_color.dart';
import '../bloc/get_patient_bloc.dart';

part 'patient_infor_screen.action.dart';

class PatientInforScreen extends StatefulWidget {
  final String patientId;

  const PatientInforScreen({
    Key? key,
    required this.patientId,
  }) : super(key: key);

  @override
  State<PatientInforScreen> createState() => _PatientInforScreenState();
}

class _PatientInforScreenState extends State<PatientInforScreen> {
  GetPatientBloc get patientBloc => BlocProvider.of(context);
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return CustomScreenForm(
        title: translation(context).patientIn4,
        isRelativeApp:
            (userDataData.getUser()?.role == UserRole.relative) ? true : false,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: true,
        isShowLeadingButton: true,
        appBarColor: const Color(0xff7BD4FF),
        backgroundColor: const Color(0xffDBF3FF),
        leadingButton: IconButton(
            onPressed: () => Navigator.pushNamed(context, RouteList.patientList,
                arguments: userDataData.getUser()!.id!),
            icon: const Icon(Icons.arrow_back)),
        child: BlocConsumer<GetPatientBloc, GetPatientState>(
            listener: _blocListener,
            builder: (context, state) {
              
              if ((state is GetPatientInitialState) ||
                  (state is DeleteRelativeState &&
                      state.status == BlocStatusState.success)) {
                patientBloc
                    .add(GetPatientInforEvent(patientId: widget.patientId));
              }
              if (state is GetPatientInforState &&
                  state.status == BlocStatusState.loading) {
                return const Center(
                  child: Loading(
                    brightness: Brightness.light,
                  ),
                );
              }

              if ((state is GetPatientInforState &&
                      state.status == BlocStatusState.success) ||
                  (state is DeleteRelativeState &&
                      state.status == BlocStatusState.loading)) {
                PatientInforEntity patient =
                    state.viewModel.patientInforEntity!;

                return SmartRefresher(
                    header: const WaterDropHeader(),
                    controller: _refreshController,
                    onRefresh: () async {
                      await Future.delayed(const Duration(milliseconds: 1000));
                      _refreshController.refreshCompleted();
                      patientBloc.add(
                          GetPatientInforEvent(patientId: widget.patientId));
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //! Infor
                          Container(
                              width: SizeConfig.screenWidth,
                              decoration: const BoxDecoration(
                                // color: const Color.fromARGB(255, 123, 211, 255),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff7BD4FF),
                                    Color(0xffDBF3FF),

                                    // Colors.white, // Xanh nhạt nhất
                                    // Xanh đậm nhất
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  // Thay đổi begin và end để điều chỉnh hướng chuyển đổi màu
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: SizeConfig.screenWidth * 0.025,
                                  ),
                                  Center(
                                    child: CustomImagePicker(
                                      age: patient.age,
                                      gender: patient.gender,
                                      imagePath: null,
                                      isOnTapActive: true,
                                      isforAvatar: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        patient.name,
                                        style: AppTextTheme.body1.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                RouteList.patientInforCell,
                                                arguments: patient);
                                          },
                                          child: SizedBox(
                                              width:
                                                  SizeConfig.screenWidth * 0.12,
                                              child: Image.asset(
                                                Assets.detail,
                                                fit: BoxFit.cover,
                                              ))),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(patient.phoneNumber,
                                      style: AppTextTheme.body3.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: SizeConfig.screenWidth * 0.05,
                                      ))
                                ],
                              )),
                          //! Data
                          Container(
                            padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.04,
                              top: SizeConfig.screenHeight * 0.03,
                              bottom: SizeConfig.screenWidth * 0.02,
                              right: SizeConfig.screenWidth * 0.025,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      translation(context).lastUpdate,
                                      style: AppTextTheme.body0.copyWith(
                                          fontSize:
                                              SizeConfig.screenHeight * 0.02,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                lineDecor(),
                                SizedBox(
                                  height: SizeConfig.screenWidth * 0.02,
                                ),
                              ],
                            ),
                          ),
                          patient.bloodPressures!.isNotEmpty ||
                                  patient.bodyTemperatures!.isNotEmpty ||
                                  patient.bloodSugars!.isNotEmpty ||
                                  patient.spo2s!.isNotEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (patient.bloodPressures!.isNotEmpty)
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RouteList.bloodPressuerDetail,
                                              arguments:
                                                  patient.bloodPressures?[0]);
                                          showToast(translation(context)
                                              .waitForSeconds);
                                        },
                                        child: homeCell(
                                            bloodPressureEntity:
                                                patient.bloodPressures?[0],
                                            dateTime: patient
                                                .bloodPressures?[0].updatedDate,
                                            navigate: "bloodPressureHistory",
                                            imagePath:
                                                Assets.bloodPressureMeter,
                                            indicator: translation(context)
                                                .bloodPressure,
                                            color: AppColor.bloodPressureEquip),
                                      ),
                                    if (patient.bodyTemperatures!.isNotEmpty)
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RouteList.bodyTemperatureDetail,
                                              arguments:
                                                  patient.bodyTemperatures?[0]);
                                          showToast(translation(context)
                                              .waitForSeconds);
                                        },
                                        child: homeCell(
                                            temperatureEntity:
                                                patient.bodyTemperatures?[0],
                                            dateTime: patient
                                                .bodyTemperatures?[0]
                                                .updatedDate,
                                            navigate: "bodyTemperatureColor",
                                            imagePath:
                                                Assets.bodyTemperatureMeter,
                                            indicator: translation(context)
                                                .bodyTemperature,
                                            color:
                                                AppColor.bodyTemperatureColor),
                                      ),
                                    if (patient.bloodSugars!.isNotEmpty)
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RouteList.bloodSugarDetail,
                                              arguments:
                                                  patient.bloodSugars?[0]);
                                          showToast(translation(context)
                                              .waitForSeconds);
                                        },
                                        child: homeCell(
                                            bloodSugarEntity:
                                                patient.bloodSugars?[0],
                                            dateTime: patient
                                                .bloodSugars?[0].updatedDate,
                                            navigate: "bloodSugarHistory",
                                            imagePath: Assets.bloodGlucoseMeter,
                                            indicator:
                                                translation(context).bloodSugar,
                                            color: AppColor.bloodGlucosColor),
                                      ),
                                    if (patient.spo2s!.isNotEmpty)
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, RouteList.spo2Detail,
                                              arguments: patient.spo2s?[0]);
                                          showToast(translation(context)
                                              .waitForSeconds);
                                        },
                                        child: homeCell(
                                            spo2Entity: patient.spo2s?[0],
                                            dateTime:
                                                patient.spo2s?[0].updatedDate,
                                            navigate: "oximeterHistory",
                                            imagePath: Assets.oximeter,
                                            indicator:
                                                translation(context).oximeter,
                                            color: AppColor.oximeterCell),
                                      ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )
                              : SizedBox(
                                  height: SizeConfig.screenHeight * 0.2,
                                  child: Center(
                                    child: Text(translation(context).noData,
                                        style: AppTextTheme.body0.copyWith(
                                            color: Colors.red,
                                            fontSize:
                                                SizeConfig.screenWidth * 0.05,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                          if (userDataData.getUser()?.role == UserRole.doctor)
                            Container(
                              padding: EdgeInsets.only(
                                top: SizeConfig.screenWidth * 0.02,
                                left: SizeConfig.screenWidth * 0.04,
                                bottom: SizeConfig.screenWidth * 0.02,
                                right: SizeConfig.screenWidth * 0.025,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    translation(context).relative,
                                    style: AppTextTheme.body0.copyWith(
                                        fontSize:
                                            SizeConfig.screenHeight * 0.02,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  lineDecor(),
                                  SizedBox(
                                    height: SizeConfig.screenWidth * 0.02,
                                  ),
                                  ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: patient.relatives?.length ?? 0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final relatives =
                                          patient.relatives?[index];
                                      return RelativeListCell(
                                        deleteRelativeBloc: patientBloc,
                                        relativeInforEntity: relatives,
                                        patientInforEntity: patient,
                                      );
                                    },
                                  ),
                                  patient.relatives!.length <= 2
                                      ? CommonButton(
                                          width: SizeConfig.screenWidth * 0.4,
                                          height:
                                              SizeConfig.screenHeight * 0.045,
                                          title:
                                              translation(context).addRelative,
                                          buttonColor: AppColor.lineDecor,
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, RouteList.addRelative,
                                                arguments: widget.patientId);
                                          })
                                      : const SizedBox(
                                          width: 0.5,
                                        ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ));
              }
              if (state.status == BlocStatusState.failure ||
                  state is WifiDisconnectState) {
                return Center(child: Text(translation(context).error));
              }
              return Container();
            }));
  }
}
