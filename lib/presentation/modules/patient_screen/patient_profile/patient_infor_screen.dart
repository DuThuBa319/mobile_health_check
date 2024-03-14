import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';

import 'package:mobile_health_check/domain/entities/spo2_entity.dart';
import 'package:mobile_health_check/domain/entities/temperature_entity.dart';
import 'package:mobile_health_check/utils/size_config.dart';

import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../classes/language.dart';
import '../../../../common/singletons.dart';
import '../../../../domain/entities/blood_pressure_entity.dart';
import '../../../../domain/entities/blood_sugar_entity.dart';
import '../../../../domain/entities/patient_infor_entity.dart';
import '../../../../assets/assets.dart';

// import '../../bloc/Patientlist/get_Patient_bloc/get_Patient_bloc.dart';

import '../../../common_widget/common.dart';
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
        isShowAppBar: true,
        isShowBottomNayvigationBar: true,
        isShowLeadingButton: true,
        leadingButton: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: SizeConfig.screenDiagonal * 0.035,
            color: AppColor.white,
          ),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context,
                RouteList.patientList,
                arguments: userDataData.getUser()?.id!,
                (route) => false);
          },
        ),
        appBarColor: const Color(0xff7BD4FF),
        backgroundColor: const Color(0xffDBF3FF),
        isShowRightButon: true,
        child: BlocConsumer<GetPatientBloc, GetPatientState>(
            listener: _blocListener,
            builder: (context, state) {
              //? RemoveRelative Success & Init
              if (state is GetPatientInitialState ||
                  (state is RemoveRelationshipRaPState &&
                      state.status == BlocStatusState.success)) {
                patientBloc
                    .add(GetPatientInforEvent(patientId: widget.patientId));
              }
              //? Loading
              if (state is GetPatientInforState &&
                  state.status == BlocStatusState.loading) {
                return const Center(
                  child: Loading(
                    brightness: Brightness.light,
                  ),
                );
              }
              //? GetInfor Success
              if (state is GetPatientInforState &&
                  state.status == BlocStatusState.success) {
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //! Infor
                          Container(
                              width: SizeConfig.screenWidth,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff7BD4FF),
                                    Color(0xffDBF3FF),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.01,
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
                                  SizedBox(
                                    width: SizeConfig.screenWidth * 0.8,
                                    child: Text.rich(
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style: AppTextTheme.body1.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              SizeConfig.screenWidth * 0.06),
                                      TextSpan(
                                        text: patient.name,
                                        children: [
                                          const WidgetSpan(
                                            child: SizedBox(
                                              width: 5,
                                            ),
                                          ),
                                          WidgetSpan(
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      RouteList
                                                          .patientInforCell,
                                                      arguments: patient);
                                                },
                                                child: SizedBox(
                                                    width: SizeConfig
                                                            .screenDiagonal *
                                                        0.036,
                                                    height: SizeConfig
                                                            .screenDiagonal *
                                                        0.036,
                                                    child: Image.asset(
                                                      Assets.detail,
                                                      fit: BoxFit.cover,
                                                    ))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              )),
                          //! Data
                          Container(
                            margin: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.03,
                              top: SizeConfig.screenHeight * 0.03,
                              bottom: SizeConfig.screenWidth * 0.02,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  translation(context).lastUpdate,
                                  style: AppTextTheme.body0.copyWith(
                                      fontSize: SizeConfig.screenWidth * 0.045,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                lineDecor(
                                  spaceBottom: SizeConfig.screenHeight * 0.01,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    (patient.bloodPressures!.isNotEmpty)
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  RouteList.bloodPressuerDetail,
                                                  arguments: patient
                                                      .bloodPressures?[0]);
                                              showToast(
                                                  context: context,
                                                  status: ToastStatus.loading,
                                                  toastString:
                                                      translation(context)
                                                          .waitForSeconds);
                                            },
                                            child: homeCell(
                                                context: context,
                                                bloodPressureEntity:
                                                    patient.bloodPressures?[0],
                                                dateTime: patient
                                                    .bloodPressures?[0]
                                                    .updatedDate,
                                                navigate:
                                                    "bloodPressureHistory",
                                                imagePath:
                                                    Assets.bloodPressureMeter,
                                                indicator: translation(context)
                                                    .bloodPressure,
                                                color: AppColor
                                                    .bloodPressureEquip),
                                          )
                                        : const SizedBox(),
                                    (patient.bodyTemperatures!.isNotEmpty)
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  RouteList
                                                      .bodyTemperatureDetail,
                                                  arguments: patient
                                                      .bodyTemperatures?[0]);
                                              showToast(
                                                  context: context,
                                                  status: ToastStatus.loading,
                                                  toastString:
                                                      translation(context)
                                                          .waitForSeconds);
                                            },
                                            child: homeCell(
                                                context: context,
                                                temperatureEntity: patient
                                                    .bodyTemperatures?[0],
                                                dateTime: patient
                                                    .bodyTemperatures?[0]
                                                    .updatedDate,
                                                navigate:
                                                    "bodyTemperatureColor",
                                                imagePath:
                                                    Assets.bodyTemperatureMeter,
                                                indicator: translation(context)
                                                    .bodyTemperature,
                                                color: AppColor
                                                    .bodyTemperatureColor),
                                          )
                                        : const SizedBox(),
                                    (patient.bloodSugars!.isNotEmpty)
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  RouteList.bloodSugarDetail,
                                                  arguments:
                                                      patient.bloodSugars?[0]);
                                              showToast(
                                                  context: context,
                                                  status: ToastStatus.loading,
                                                  toastString:
                                                      translation(context)
                                                          .waitForSeconds);
                                            },
                                            child: homeCell(
                                                context: context,
                                                bloodSugarEntity:
                                                    patient.bloodSugars?[0],
                                                dateTime: patient
                                                    .bloodSugars?[0]
                                                    .updatedDate,
                                                navigate: "bloodSugarHistory",
                                                imagePath:
                                                    Assets.bloodGlucoseMeter,
                                                indicator: translation(context)
                                                    .bloodSugar,
                                                color:
                                                    AppColor.bloodGlucosColor),
                                          )
                                        : const SizedBox(),
                                    (patient.spo2s!.isNotEmpty)
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, RouteList.spo2Detail,
                                                  arguments: patient.spo2s?[0]);
                                              showToast(
                                                  context: context,
                                                  status: ToastStatus.loading,
                                                  toastString:
                                                      translation(context)
                                                          .waitForSeconds);
                                            },
                                            child: homeCell(
                                                context: context,
                                                spo2Entity: patient.spo2s?[0],
                                                dateTime: patient
                                                    .spo2s?[0].updatedDate,
                                                navigate: "oximeterHistory",
                                                imagePath: Assets.oximeter,
                                                indicator: translation(context)
                                                    .oximeter,
                                                color: AppColor.oximeterCell),
                                          )
                                        : const SizedBox(),
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
                                                SizeConfig.screenDiagonal *
                                                    0.022,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                          if (userDataData.getUser()?.role == UserRole.doctor)
                            Container(
                              margin: EdgeInsets.only(
                                top: SizeConfig.screenWidth * 0.02,
                                left: SizeConfig.screenWidth * 0.03,
                                bottom: SizeConfig.screenWidth * 0.02,
                                right: SizeConfig.screenWidth * 0.03,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    translation(context).relative,
                                    style: AppTextTheme.body0.copyWith(
                                        fontSize:
                                            SizeConfig.screenWidth * 0.045,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  lineDecor(
                                      spaceBottom:
                                          SizeConfig.screenHeight * 0.01,
                                      spaceTop: 2),
                                  ListView.separated(
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            Divider(
                                      height: SizeConfig.screenHeight * 0.005,
                                      color: AppColor.backgroundColor,
                                    ),
                                    physics: const BouncingScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: patient.relatives?.length ?? 0,
                                    itemBuilder:
                                        (BuildContext contxt, int index) {
                                      final relative =
                                          patient.relatives?[index];

                                      final endDrawerWidgets =
                                          <SlidableDrawerWidget>[
                                        SlidableDrawerWidget(
                                            backgroundColor:
                                                AppColor.green9DEEB2,
                                            foregroundColor: Colors.white,
                                            iconData: Icons.phone,
                                            labelText:
                                                translation(context).call,
                                            onPressed: (context) {
                                              if (state.viewModel
                                                      .isWifiDisconnect ==
                                                  true) {
                                              } else {
                                                return FlutterPhoneDirectCaller
                                                    .callNumber(
                                                        relative!.phoneNumber);
                                              }
                                            }),
                                        SlidableDrawerWidget(
                                            backgroundColor: AppColor.lineDecor,
                                            foregroundColor: Colors.white,
                                            iconData:
                                                Icons.delete_outline_outlined,
                                            labelText:
                                                translation(context).delete,
                                            onPressed: (context) {
                                              if (state.viewModel
                                                      .isWifiDisconnect ==
                                                  true) {
                                              } else {
                                                showWarningDialog(
                                                    contentDialogSize: SizeConfig
                                                                .screenDiagonal <
                                                            1350
                                                        ? SizeConfig
                                                                .screenWidth *
                                                            0.04
                                                        : SizeConfig
                                                                .screenWidth *
                                                            0.045,
                                                    useRootNavigator: true,
                                                    context: contxt,
                                                    message: translation(
                                                            context)
                                                        .deleteRelative,
                                                    title: translation(context)
                                                        .deleteRelativeWarningTitle,
                                                    onClose1: () {
                                                      Navigator.pop(contxt);
                                                    },
                                                    onClose2: () {
                                                      patientBloc.add(
                                                          RemoveRelationshipRaPEvent(
                                                              relativeId:
                                                                  relative!.id,
                                                              patientId:
                                                                  patient.id));
                                                      Navigator.pop(contxt);
                                                    });
                                              }
                                            })
                                      ];
                                      //! SlideAbleForm
                                      return CustomSlidableWidget(
                                        endDrawerWidgets: endDrawerWidgets,
                                        iconLeadingCell: Transform.translate(
                                          offset: Offset(
                                              SizeConfig.screenWidth * 0.01,
                                              SizeConfig.screenDiagonal < 1350
                                                  ? 0
                                                  : -SizeConfig.screenHeight *
                                                      0.0065),
                                          child: Icon(Icons.account_box_rounded,
                                              color: AppColor.blue03A1E4,
                                              size: SizeConfig.screenDiagonal *
                                                  0.045),
                                        ),
                                        textLine1: Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          relative!.name,
                                          style: AppTextTheme.body2.copyWith(
                                              fontSize:
                                                  SizeConfig.screenDiagonal <
                                                          1350
                                                      ? SizeConfig.screenWidth *
                                                          0.055
                                                      : SizeConfig.screenWidth *
                                                          0.045,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        textLine2: Row(
                                          children: [
                                            Text(relative.phoneNumber,
                                                style:
                                                    AppTextTheme.body3.copyWith(
                                                  fontSize: SizeConfig
                                                              .screenDiagonal <
                                                          1350
                                                      ? SizeConfig.screenWidth *
                                                          0.035
                                                      : SizeConfig.screenWidth *
                                                          0.032,
                                                )),
                                            emptySpace(5),
                                            InkWell(
                                              child: Icon(
                                                Icons.copy,
                                                color: AppColor.gray767676,
                                                size:
                                                    SizeConfig.screenDiagonal *
                                                        0.025,
                                              ),
                                              onTap: () {
                                                Clipboard.setData(ClipboardData(
                                                    text:
                                                        relative.phoneNumber));
                                                showToast(
                                                    context: context,
                                                    status: ToastStatus.success,
                                                    toastString:
                                                        translation(context)
                                                            .copySuccessfully);
                                              },
                                            )
                                          ],
                                        ),
                                        onTapCell: () {},
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  patient.relatives!.length < 2
                                      ? RectangleButton(
                                          width: SizeConfig.screenWidth * 0.4,
                                          height:
                                              SizeConfig.screenHeight * 0.05,
                                          title:
                                              translation(context).addRelative,
                                          buttonColor: AppColor.lineDecor,
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, RouteList.addRelative,
                                                arguments: widget.patientId);
                                          })
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ));
              }

              if (state.status == BlocStatusState.failure) {
                return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Text(
                        softWrap: true,
                        textAlign: TextAlign.center,
                        state.viewModel.errorMessage!,
                        style: AppTextTheme.body2.copyWith(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      RectangleButton(
                          height: SizeConfig.screenHeight * 0.052,
                          width: SizeConfig.screenWidth * 0.4,
                          title: translation(context).loadAgain,
                          onTap: () {
                            patientBloc.add(GetPatientInforEvent(
                                patientId: widget.patientId));
                          })
                    ]));
              }
              return Container();
            }));
  }
}
