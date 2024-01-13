import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/utils/size_config.dart';

import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../classes/language.dart';
import '../../../../domain/entities/doctor_infor_entity.dart';

// import '../../bloc/Doctorlist/get_Doctor_bloc/get_Doctor_bloc.dart';
import '../../../common_widget/common.dart';
import '../../../theme/theme_color.dart';
import '../bloc/admin_bloc.dart';

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
              //? Init
              if (state is GetDoctorInitialState) {
                doctorBloc.add(GetDoctorInforEvent(doctorId: widget.doctorId));
              }
              //? Loading
              if (state is GetDoctorInforState &&
                  state.status == BlocStatusState.loading) {
                return const Center(
                  child: Loading(
                    brightness: Brightness.light,
                  ),
                );
              }
              //? Success
              if (state is GetDoctorInforState &&
                  state.status == BlocStatusState.success) {
                DoctorInforEntity doctor = state.viewModel.doctorInforEntity!;
                return SmartRefresher(
                    header: const WaterDropHeader(),
                    controller: _refreshController,
                    onRefresh: () async {
                      await Future.delayed(const Duration(milliseconds: 1000));
                      _refreshController.refreshCompleted();
                      doctorBloc
                          .add(GetDoctorInforEvent(doctorId: widget.doctorId!));
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  SizedBox(
                                    width: SizeConfig.screenWidth * 0.7,
                                    child: Center(
                                      child: Text(
                                        "Dr. ${doctor.name}",
                                        textAlign: TextAlign.center,
                                        style: AppTextTheme.body1.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.04,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.025),
                            child: Text(
                              translation(context).doctorIn4,
                              style: AppTextTheme.body0.copyWith(
                                  fontSize: SizeConfig.screenWidth * 0.06,
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
                              doctorIn4Cell(
                                  context,
                                  "${translation(context).name}: ",
                                  doctor.name),
                              doctorIn4Cell(
                                  context,
                                  "${translation(context).phoneNumber}: ",
                                  doctor.phoneNumber,
                                  isSelectable: true),
                              doctorIn4Cell(
                                  context,
                                  "${translation(context).age}: ",
                                  (doctor.age == 0)
                                      ? translation(context).notUpdate
                                      : "${doctor.age}"),
                              doctorIn4Cell(
                                context,
                                "${translation(context).gender}: ",
                                doctor.gender == 0
                                    ? translation(context).male
                                    : translation(context).female,
                              ),
                              doctorIn4Cell(
                                  context,
                                  "${translation(context).address}: ",
                                  (doctor.address == null ||
                                          doctor.address == "")
                                      ? translation(context).notUpdate
                                      : "${doctor.address}",
                                  isSelectable: true),
                            ],
                          )
                        ],
                      ),
                    ));
              }
              if (state is GetDoctorInforState &&
                  state.status == BlocStatusState.failure) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      softWrap: true,
                      textAlign: TextAlign.center,
                      state.viewModel.errorMessage!,
                      style: AppTextTheme.body2.copyWith(color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    RectangleButton(
                      height: SizeConfig.screenHeight * 0.052,
                      width: SizeConfig.screenWidth * 0.4,
                      title: translation(context).loadAgain,
                      onTap: () {
                        doctorBloc.add(
                            GetDoctorInforEvent(doctorId: widget.doctorId));
                      },
                    )
                  ],
                ));
              }

              return Container();
            }));
  }
}

Widget doctorIn4Cell(BuildContext context, title, String text,
    {bool isSelectable = false}) {
  return Container(
      margin: EdgeInsets.only(
          bottom: SizeConfig.screenWidth * 0.03,
          left: SizeConfig.screenWidth * 0.025,
          right: SizeConfig.screenWidth * 0.04),
      padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * 0.03,
          top: SizeConfig.screenHeight * 0.02),
      height: title == "${translation(context).address}: "
          ? SizeConfig.screenHeight * 0.15
          : SizeConfig.screenHeight * 0.1,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.035),
      ),
      child: RichText(
        maxLines: title == "${translation(context).address}: " ? 3 : 2,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
                text: title,
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: SizeConfig.screenWidth * 0.055,
                    fontWeight: FontWeight.w500)),
            TextSpan(
              text: text,
              style: TextStyle(
                  color: Colors.black, fontSize: SizeConfig.screenWidth * 0.05),
            ),
            const WidgetSpan(child: SizedBox(width: 10)),
            WidgetSpan(
              child: isSelectable
                  ? InkWell(
                      child: const Icon(Icons.copy, color: Colors.black54),
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: text));
                        showToast(translation(context).copySuccessfully);
                        // Clipboard.setData(ClipboardData(
                        //         text: doctor.phoneNumber))
                        //     .then((value) {
                        //   ScaffoldMessenger.of(context)
                        //       .showSnackBar(const SnackBar(
                        //           title:
                        //               Text('Đã sao chép')));
                        // });
                      },
                    )
                  : emptySpace(5),
            )
          ],
        ),
      ));
}
