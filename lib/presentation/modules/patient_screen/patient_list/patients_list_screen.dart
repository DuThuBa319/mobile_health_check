import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:mobile_health_check/presentation/modules/patient_screen/patient_list/widget/patient_list_cell.dart';
import 'package:mobile_health_check/utils/size_config.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../classes/language.dart';

import '../../../../common/singletons.dart';
import '../../../../domain/entities/patient_infor_entity.dart';
import '../../../common_widget/common.dart';
import '../../../route/route_list.dart';
import '../../../theme/app_text_theme.dart';
import '../bloc/get_patient_bloc.dart';

part 'patients_list_screen.action.dart';

class PatientListScreen extends StatefulWidget {
  final String id;

  const PatientListScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<PatientListScreen> createState() => _PatientListState();
}

TextEditingController filterKeyword = TextEditingController(text: '');

class _PatientListState extends State<PatientListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GetPatientBloc get patientBloc => BlocProvider.of(context);
  @override
  void initState() {
    super.initState();
    filterKeyword = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return PopScope(
        canPop: false,
        onPopInvoked: _onWillPop,
        child: CustomScreenForm(
            isShowAppBar: false,
            isShowLeadingButton: false,
            isShowBottomNayvigationBar: true,
            isShowRightButon: false,
            backgroundColor: AppColor.backgroundColor,
            appBarColor: AppColor.backgroundColor,
            title: " ",
            selectedIndex: 0,
            floatActionButton: Container(
              width: SizeConfig.screenDiagonal * 0.06,
              height: SizeConfig.screenDiagonal * 0.06,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 244, 51, 51),
              ),
              child: Center(
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteList.addPatient);
                      filterKeyword = TextEditingController(text: "");
                    },
                    icon: Icon(
                      size: SizeConfig.screenDiagonal * 0.03,
                      Icons.group_add_outlined,
                      color: Colors.white,
                    )),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
              child: BlocConsumer<GetPatientBloc, GetPatientState>(
                  listener: _blocListener,
                  builder: (context, state) {
                    if (state is GetPatientInitialState) {
                      patientBloc.add(GetPatientListEvent(userId: widget.id));
                    }

                    return Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.035,
                          right: SizeConfig.screenWidth * 0.035,
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      translation(context).patientList,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.screenWidth * 0.065,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth * 0.09,
                                      height: SizeConfig.screenWidth * 0.09,
                                      margin: EdgeInsets.only(
                                        right: SizeConfig.screenWidth * 0.02,
                                      ),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              100, 22, 44, 33),
                                          borderRadius: BorderRadius.circular(
                                              SizeConfig.screenWidth * 0.025)),
                                      child: Center(
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  RouteList.notification,
                                                  arguments: userDataData
                                                      .getUser()!
                                                      .id);
                                            },
                                            child: badges.Badge(
                                              position: badges.BadgePosition.topEnd(
                                                  top: SizeConfig
                                                              .screenDiagonal <
                                                          1350
                                                      ? -SizeConfig
                                                              .screenHeight *
                                                          0.025
                                                      : -SizeConfig
                                                              .screenHeight *
                                                          0.03,
                                                  end: SizeConfig
                                                              .screenDiagonal <
                                                          1350
                                                      ? -SizeConfig
                                                              .screenHeight *
                                                          0.025
                                                      : -SizeConfig
                                                              .screenHeight *
                                                          0.03),
                                              badgeContent:
                                                  state.viewModel.unreadCount ==
                                                          null
                                                      ? null
                                                      : Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle),
                                                          height: SizeConfig
                                                                      .screenDiagonal <
                                                                  1350
                                                              ? SizeConfig
                                                                      .screenDiagonal *
                                                                  0.02
                                                              : SizeConfig
                                                                      .screenDiagonal *
                                                                  0.03,
                                                          width: SizeConfig
                                                                      .screenDiagonal <
                                                                  1350
                                                              ? SizeConfig
                                                                      .screenDiagonal *
                                                                  0.02
                                                              : SizeConfig
                                                                      .screenDiagonal *
                                                                  0.03,
                                                          child: Center(
                                                            child: Text(
                                                                "${state.viewModel.unreadCount}",
                                                                style: TextStyle(
                                                                    fontSize: SizeConfig.screenDiagonal < 1350
                                                                        ? SizeConfig.screenDiagonal *
                                                                            0.0135
                                                                        : SizeConfig.screenDiagonal *
                                                                            0.0145,
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                        ),
                                              child: Icon(
                                                  size: SizeConfig.screenWidth *
                                                      0.05,
                                                  Icons
                                                      .notifications_none_rounded,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    )
                                  ]),
                              lineDecor(
                                  spaceBottom: SizeConfig.screenHeight * 0.01,
                                  spaceTop: 5),
                              //! Search box
                              Center(
                                child: Container(
                                  height: SizeConfig.screenHeight * 0.075,
                                  width: SizeConfig.screenWidth * 0.925,
                                  margin: EdgeInsets.only(
                                    top: SizeConfig.screenHeight * 0.005,
                                    bottom: SizeConfig.screenHeight * 0.02,
                                  ),
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(color: Colors.black26)
                                    ],
                                    borderRadius: BorderRadius.circular(
                                        SizeConfig.screenWidth * 0.015),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: TextField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextStyle(
                                          color: AppColor.gray767676,
                                          fontSize: SizeConfig.screenDiagonal <
                                                  1350
                                              ? SizeConfig.screenWidth * 0.05
                                              : SizeConfig.screenWidth * 0.045),
                                      controller: filterKeyword,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              SizeConfig.screenWidth * 0.015),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText:
                                            translation(context).searchPatient,
                                        hintStyle: TextStyle(
                                            color:
                                                SizeConfig.screenDiagonal < 1350
                                                    ? const Color.fromARGB(
                                                        255, 125, 124, 124)
                                                    : const Color.fromARGB(
                                                        255, 147, 147, 147),
                                            fontSize: SizeConfig
                                                        .screenDiagonal <
                                                    1350
                                                ? SizeConfig.screenWidth * 0.05
                                                : SizeConfig.screenWidth *
                                                    0.045),
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.search,
                                              size: SizeConfig.screenHeight *
                                                  0.03),
                                          color: Colors.black,
                                          onPressed: () {
                                            patientBloc.add(
                                              FilterPatientEvent(
                                                  searchText:
                                                      filterKeyword.text,
                                                  id: widget.id),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //? Loading
                              ((state.status == BlocStatusState.loading) &&
                                          (state is GetPatientListState ||
                                              state is SearchPatientState ||
                                              state is DeletePatientState) ||
                                      (state is DeletePatientState &&
                                          state.status ==
                                              BlocStatusState.success &&
                                          state.viewModel.patientEntities !=
                                              null))
                                  ? const Expanded(
                                      child: Center(
                                        child: Loading(
                                            brightness: Brightness.light),
                                      ),
                                    )
                                  : Container(),
                              //? Get thành công hoặc Search thành công và giữ nguyên trạng thái list
                              ((state.status == BlocStatusState.success &&
                                          (state is GetPatientListState ||
                                              state is SearchPatientState)) ||
                                      (state.status ==
                                              BlocStatusState.failure &&
                                          state is DeletePatientState))
                                  ? formPatientListScreen(
                                      contxt: context,
                                      itemCount: state
                                          .viewModel.patientEntities?.length,
                                      patientInforEntities:
                                          state.viewModel.patientEntities!)
                                  : Container(),
                              //? Failure
                              (state.status == BlocStatusState.failure &&
                                      (state is! DeletePatientState ||
                                          state.viewModel.isWifiDisconnect ==
                                              true))
                                  ? Expanded(
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            state.viewModel.errorMessage!,
                                            style: AppTextTheme.body2.copyWith(
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        0.05,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  0.01),
                                          RectangleButton(
                                            height:
                                                SizeConfig.screenHeight * 0.052,
                                            width: SizeConfig.screenWidth * 0.4,
                                            title:
                                                state.viewModel.errorMessage ==
                                                        translation(context)
                                                            .wrongSearchPatient
                                                    ? translation(context)
                                                        .backToList
                                                    : translation(context)
                                                        .loadAgain,
                                            onTap: () {
                                              filterKeyword =
                                                  TextEditingController(
                                                      text: '');
                                              patientBloc.add(
                                                  GetPatientListEvent(
                                                      userId: widget.id));
                                            },
                                          )
                                        ],
                                      )),
                                    )
                                  : Container()
                            ]));
                  }),
            )));
  }
}
