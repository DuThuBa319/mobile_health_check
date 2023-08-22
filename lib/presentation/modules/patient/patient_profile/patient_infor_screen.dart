import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_health_check/classes/language_constant.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';

import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../../../di/di.dart';

import '../../../../domain/entities/patient_infor_entity.dart';
import '../../../common_widget/assets.dart';
import '../../../common_widget/enum_common.dart';
import '../../../common_widget/line_decor.dart';
import '../../../common_widget/loading_widget.dart';
import '../../../common_widget/screen_form/image_picker_widget/custom_image_picker.dart';

// import '../../bloc/userlist/get_user_bloc/get_user_bloc.dart';
import '../../../route/route_list.dart';
import '../../../theme/theme_color.dart';

import '../../history/blood_pressure_history_screen/blood_pressure_history_screen.dart';
import '../../history/blood_sugar_history_screen/blood_sugar_history_screen.dart';
import '../../history/history_bloc/history_bloc.dart';
import '../../history/temperature_history_screen/temperature_history_screen.dart';

import '../patient_list_&_infor_bloc/get_patient_bloc.dart';
part 'patient_infor_screen.action.dart';

class HomeScreen extends StatefulWidget {
  final String? id;
  final GetUserBloc userBloc;
  final PatientInforEntity? patientInforEntity;

  const HomeScreen({
    this.patientInforEntity,
    Key? key,
    required this.id,
    required this.userBloc,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetUserBloc get userBloc => BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    final sreenHeight = MediaQuery.of(context).size.height;
    final sreenWidth = MediaQuery.of(context).size.width;

    // RefreshController refreshController =
    //     RefreshController(initialRefresh: true);
    // Future<void> onRefresh() async {
    //   // monitor network fetch
    //   await Future.delayed(const Duration(milliseconds: 1000));
    //   // if failed,use refreshFailed()
    //   refreshController.refreshCompleted();
    // }

    return WillPopScope(
        onWillPop: _onWillPop,
        child: CustomScreenForm(
            title: translation(context).patientIn4,
            isShowRightButon: false,
            isShowAppBar: true,
            isShowBottomNayvigationBar: true,
            isShowLeadingButton: true,
            appBarColor: const Color(0xff7BD4FF),
            backgroundColor: AppColor.cardBackground,
            leadingButton: IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, RouteList.userList),
                icon: const Icon(Icons.arrow_back)),
            child: BlocConsumer<GetUserBloc, GetUserState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetUserInitialState) {
                    userBloc
                        .add(GetUserDetailEvent(id: widget.id ?? widget.id!));
                  }
                  if (state is GetUserDetailState &&
                      state.status == BlocStatusState.loading) {
                    return const Center(
                      child: Loading(
                        brightness: Brightness.light,
                      ),
                    );
                  }
                  if (state is GetUserDetailState &&
                      state.status == BlocStatusState.success) {
                    PatientInforEntity user =
                        state.viewModel.userDetailEntity ??
                            state.viewModel.userDetailEntity!;
                    print(user);
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: sreenWidth,
                              decoration: BoxDecoration(
                                // color: const Color.fromARGB(255, 123, 211, 255),
                                gradient: const LinearGradient(
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
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.elliptical(
                                        MediaQuery.of(context).size.width,
                                        100)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Center(
                                    child: ImagePickerSingle(
                                      imagePath: null,
                                      isOnTapActive: true,
                                      isforAvatar: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: sreenHeight * 0.02,
                                  ),
                                  Text(
                                    user.name,
                                    style: AppTextTheme.body1.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(user.address?.city ?? "--",
                                      style: AppTextTheme.body3.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400)),
                                  SizedBox(
                                    height: sreenHeight * 0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      infoText(
                                          title: translation(context).weight,
                                          content: "${user.weight}"),
                                      infoText(
                                          title: translation(context).age,
                                          content: "${user.age}"),
                                      infoText(
                                          title: translation(context).height,
                                          content: "${user.height}"),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 25, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  translation(context).lastUpdate,
                                  style: AppTextTheme.body0.copyWith(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                lineDecor(),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          user.bloodPressures!.isNotEmpty ||
                                  user.bodyTemperatures!.isNotEmpty ||
                                  user.bloodSugars!.isNotEmpty
                              ? Column(
                                  children: [
                                    homeCell(
                                        dia: user.bloodPressures?[0].dia,
                                        sys: user.bloodPressures?[0].sys,
                                        pulse: user.bloodPressures?[0].pulse,
                                        dateTime:
                                            user.bloodPressures?[0].updatedDate,
                                        naviagte: "bloodPressureHistory",
                                        imagePath: Assets.bloodPressureMeter,
                                        indicator:
                                            translation(context).bloodPressure,
                                        color: AppColor.bloodPressureEquip),
                                    homeCell(
                                        bodyTemperature: user
                                            .bodyTemperatures?[0].temperature,
                                        dateTime: user
                                            .bodyTemperatures?[0].updatedDate,
                                        naviagte: "bodyTemperatureColor",
                                        imagePath: Assets.bodyTemperatureMeter,
                                        indicator: translation(context)
                                            .bodyTemperature,
                                        color: AppColor.bodyTemperatureColor),
                                    homeCell(
                                        dateTime:
                                            user.bloodSugars?[0].updatedDate,
                                        bloodSugar:
                                            user.bloodSugars?[0].bloodSugar,
                                        naviagte: "bloodSugarHistory",
                                        imagePath: Assets.bloodGlucoseMeter,
                                        indicator:
                                            translation(context).bloodSugar,
                                        color: AppColor.bloodGlucosColor)
                                  ],
                                )
                              : Center(
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(top: sreenHeight * 0.2),
                                    child: Text("Chưa có dữ liệu",
                                        style: AppTextTheme.body0.copyWith(
                                            color: Colors.red,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                )
                        ],
                      ),
                    );
                  }
                  if (state.status == BlocStatusState.failure) {
                    return const Center(
                      child: Text("error"),
                    );
                  }
                  return Container();
                })));
  }
}
