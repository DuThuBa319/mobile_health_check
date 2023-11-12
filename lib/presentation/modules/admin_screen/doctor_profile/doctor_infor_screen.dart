import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';

import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../classes/language.dart';
import '../../../../domain/entities/doctor_infor_entity.dart';
import '../../../common_widget/dialog/show_toast.dart';
import '../../../common_widget/enum_common.dart';
import '../../../common_widget/loading_widget.dart';
import '../../../common_widget/screen_form/image_picker_widget/custom_image_picker.dart';

// import '../../bloc/Doctorlist/get_Doctor_bloc/get_Doctor_bloc.dart';
import '../../../theme/theme_color.dart';
import '../bloc/get_doctor_bloc.dart';

part 'doctor_infor_screen.action.dart';

class DoctorInforScreen extends StatefulWidget {
  final String? doctorId;

  const DoctorInforScreen({
    Key? key,
    required this.doctorId,
  }) : super(key: key);

  @override
  State<DoctorInforScreen> createState() => _DoctorInforScreenState();
}

class _DoctorInforScreenState extends State<DoctorInforScreen> {
  GetDoctorBloc get doctorBloc => BlocProvider.of(context);
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
        title: translation(context).doctorIn4,
        isShowRightButon: true,
        isShowAppBar: true,
        isShowBottomNayvigationBar: true,
        isShowLeadingButton: true,
        appBarColor: const Color(0xff7BD4FF),
        backgroundColor: const Color(0xffDBF3FF),
        child: BlocConsumer<GetDoctorBloc, GetDoctorState>(
            listener: _blocListener,
            builder: (context, state) {
              if (state is GetDoctorInitialState) {
                doctorBloc.add(GetDoctorInforEvent(doctorId: widget.doctorId));
              }
              if (state is GetDoctorInforState &&
                  state.status == BlocStatusState.loading) {
                return const Center(
                  child: Loading(
                    brightness: Brightness.light,
                  ),
                );
              }

              if (state is GetDoctorInforState &&
                  state.status == BlocStatusState.success) {
                DoctorInforEntity doctor = state.viewModel.doctorInforEntity ??
                    state.viewModel.doctorInforEntity!;

                return SmartRefresher(
                    header: const WaterDropHeader(),
                    controller: _refreshController,
                    onRefresh: () async {
                      await Future.delayed(const Duration(milliseconds: 1000));
                      _refreshController.refreshCompleted();
                      doctorBloc.add(GetDoctorInforEvent(
                          doctorId: widget.doctorId ?? widget.doctorId!));
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
                                  CustomImagePicker(
                                    age: doctor.age,
                                    gender: doctor.gender,
                                    imagePath: null,
                                    isOnTapActive: true,
                                    isforAvatar: true,
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.01,
                                  ),
                                  Text(
                                    "Dr. ${doctor.name}",
                                    style: AppTextTheme.body1.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(doctor.phoneNumber,
                                      style: AppTextTheme.body3.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: SizeConfig.screenWidth * 0.05,
                                      ))
                                ],
                              )),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.04,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.025),
                            child: Text(
                              translation(context).lastUpdate,
                              style: AppTextTheme.body0.copyWith(
                                  fontSize: SizeConfig.screenHeight * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          lineDecor(
                              spaceBottom: SizeConfig.screenWidth * 0.025,
                              spaceTop: 5,
                              spaceLeft: SizeConfig.screenWidth * 0.025),

                          //! Data
                          ListView(
                            shrinkWrap: true, // Add this line
                            physics:
                                const NeverScrollableScrollPhysics(), // Add this line
                            children: [
                              doctorIn4Cell("${translation(context).name}: ",
                                  doctor.name),
                              doctorIn4Cell(
                                  "${translation(context).phoneNumber}: ",
                                  doctor.phoneNumber),
                              doctorIn4Cell(
                                  "${translation(context).age}: ",
                                  (doctor.age == 0)
                                      ? translation(context).notUpdate
                                      : "${doctor.age}"),
                              doctorIn4Cell(
                                "${translation(context).gender}: ",
                                doctor.gender == 0
                                    ? translation(context).male
                                    : translation(context).female,
                              ),
                              doctorIn4Cell(
                                  "${translation(context).address}: ",
                                  (doctor.address == null ||
                                          doctor.address == "")
                                      ? translation(context).notUpdate
                                      : "${doctor.address}"),
                            ],
                          )
                        ],
                      ),
                    ));
              }
              if (state.status == BlocStatusState.failure ||
                  state is WifiDisconnectState) {
                return Center(child: Text(
                          translation(context).error,
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.05,
                              fontWeight: FontWeight.bold),
                        ),);
              }
              return Container();
            }));
  }
}

Widget doctorIn4Cell(String titile, String text) {
  return Container(
      margin: EdgeInsets.only(
          bottom: SizeConfig.screenWidth * 0.03,
          left: SizeConfig.screenWidth * 0.025,
          right: SizeConfig.screenWidth * 0.025),
      padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * 0.03,
          top: SizeConfig.screenHeight * 0.02),
      height: SizeConfig.screenHeight * 0.13,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.035),
      ),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
                text: titile,
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: SizeConfig.screenWidth * 0.055,
                    fontWeight: FontWeight.w500)),
            TextSpan(
              text: text,
              style: TextStyle(
                  color: Colors.black, fontSize: SizeConfig.screenWidth * 0.05),
            )
          ],
        ),
      ));
}
