import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_health_check/classes/language_constant.dart';
import 'package:mobile_health_check/domain/entities/temperature_entity.dart';
import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';

import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../domain/entities/blood_pressure_entity.dart';
import '../../../../domain/entities/blood_sugar_entity.dart';
import '../../../../domain/entities/patient_infor_entity.dart';
import '../../../common_widget/assets.dart';
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
  final String? id;

  const PatientInforScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<PatientInforScreen> createState() => _PatientInforScreenState();
}

class _PatientInforScreenState extends State<PatientInforScreen> {
  GetPatientBloc get patientBloc => BlocProvider.of(context);
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    // RefreshController refreshController =
    //     RefreshController(initialRefresh: true);
    // Future<void> onRefresh() async {
    //   // monitor network fetch
    //   await Future.delayed(const Duration(milliseconds: SizeConfig.screenWidth*0.0200));
    //   // if failed,use refreshFailed()
    //   refreshController.refreshCompleted();
    // }

    return CustomScreenForm(
        title: translation(context).patientIn4,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: true,
        isShowLeadingButton: true,
        appBarColor: const Color(0xff7BD4FF),
        backgroundColor: const Color(0xffDBF3FF),
        // leadingButton: IconButton(
        //     onPressed: () => Navigator.pushNamed(context, RouteList.patientList,
        //         arguments: userDataData.getUser()!.id!),
        //     icon: const Icon(Icons.arrow_back)),
        child: BlocConsumer<GetPatientBloc, GetPatientState>(
            listener: _blocListener,
            builder: (context, state) {
              if (state is GetPatientInitialState) {
                patientBloc
                    .add(GetPatientInforEvent(id: widget.id ?? widget.id!));
              }
              if (state is GetPatientInforState &&
                  state.status == BlocStatusState.loading) {
                return const Center(
                  child: Loading(
                    brightness: Brightness.light,
                  ),
                );
              }
              if (state is GetPatientInforState &&
                  state.status == BlocStatusState.success) {
                PatientInforEntity patient =
                    state.viewModel.patientInforEntity ??
                        state.viewModel.patientInforEntity!;
                print(patient);
                return SmartRefresher(
                    header: const WaterDropHeader(),
                    controller: _refreshController,
                    onRefresh: () async {
                      await Future.delayed(const Duration(milliseconds: 1000));
                      _refreshController.refreshCompleted();
                      patientBloc.add(
                          GetPatientInforEvent(id: widget.id ?? widget.id!));
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                // borderRadius: BorderRadius.vertical(
                                //     bottom: Radius.elliptical(
                                //         MediaQuery.of(context).size.width,
                                //         SizeConfig.screenWidth*0.020)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: SizeConfig.screenWidth * 0.025,
                                  ),
                                  Center(
                                    child: CustomImagePicker(
                                      age: patient.age,
                                      gender: patient.gender,
                                      imagePath: patient.avatarPath,
                                      isOnTapActive: true,
                                      isforAvatar: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.025,
                                  ),
                                  Text(
                                    patient.name,
                                    style: AppTextTheme.body1.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(patient.address?.city ?? "--",
                                      style: AppTextTheme.body3.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400)),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      infoText(
                                          title: translation(context).weight,
                                          content:
                                              "${patient.weight!.toInt()}"),
                                      infoText(
                                          title: translation(context).age,
                                          content: "${patient.age!.toInt()}"),
                                      infoText(
                                          title: translation(context).height,
                                          content:
                                              "${patient.height!.toInt()}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.01,
                                  ),
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15,
                                top: SizeConfig.screenHeight * 0.03,
                                bottom: SizeConfig.screenWidth * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  translation(context).lastUpdate,
                                  style: AppTextTheme.body0.copyWith(
                                      fontSize: SizeConfig.screenHeight * 0.02,
                                      fontWeight: FontWeight.bold),
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
                                  patient.bloodSugars!.isNotEmpty
                              ?
                              // Expanded(
                              //     child: SmartRefresher(
                              //         controller: _refreshController,
                              //         onRefresh: () async {
                              //           await Future.delayed(
                              //               const Duration(milliseconds: 1000));
                              //           _refreshController.refreshCompleted();
                              //           patientBloc.add(GetPatientInforEvent(
                              //               id: widget.id ?? widget.id!));
                              //         },
                              Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            RouteList.bloodPressuerDetail,
                                            arguments:
                                                patient.bloodPressures?[0]);
                                      },
                                      child: homeCell(
                                          bloodPressureEntity:
                                              patient.bloodPressures?[0],
                                          dateTime: patient
                                              .bloodPressures?[0].updatedDate,
                                          naviagte: "bloodPressureHistory",
                                          imagePath: Assets.bloodPressureMeter,
                                          indicator: translation(context)
                                              .bloodPressure,
                                          color: AppColor.bloodPressureEquip),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            RouteList.bodyTemperatureDetail,
                                            arguments:
                                                patient.bodyTemperatures?[0]);
                                      },
                                      child: homeCell(
                                          temperatureEntity:
                                              patient.bodyTemperatures?[0],
                                          dateTime: patient
                                              .bodyTemperatures?[0].updatedDate,
                                          naviagte: "bodyTemperatureColor",
                                          imagePath:
                                              Assets.bodyTemperatureMeter,
                                          indicator: translation(context)
                                              .bodyTemperature,
                                          color: AppColor.bodyTemperatureColor),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, RouteList.bloodSugarDetail,
                                            arguments: patient.bloodSugars?[0]);
                                      },
                                      child: homeCell(
                                          bloodSugarEntity:
                                              patient.bloodSugars?[0],
                                          dateTime: patient
                                              .bloodSugars?[0].updatedDate,
                                          naviagte: "bloodSugarHistory",
                                          imagePath: Assets.bloodGlucoseMeter,
                                          indicator:
                                              translation(context).bloodSugar,
                                          color: AppColor.bloodGlucosColor),
                                    )
                                  ],
                                )
                              : Center(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.screenHeight * 0.2),
                                    child: Text("Chưa có dữ liệu",
                                        style: AppTextTheme.body0.copyWith(
                                            color: Colors.red,
                                            fontSize:
                                                SizeConfig.screenHeight * 0.02,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                )
                        ],
                      ),
                    ));
              }
              if (state.status == BlocStatusState.failure) {
                return const Center(
                  child: Text("error"),
                );
              }
              return Container();
            }));
  }
}
