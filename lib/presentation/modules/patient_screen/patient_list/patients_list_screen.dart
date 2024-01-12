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
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 244, 51, 51),
                  borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteList.addPatient);
                    filterKeyword = TextEditingController(text: "");
                  },
                  icon: const Icon(
                    Icons.group_add_outlined,
                    color: Colors.white,
                  )),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: SizeConfig.screenWidth * 0.03),
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
                                              SizeConfig.screenWidth * 0.07,
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
                                              SizeConfig.screenWidth * 0.030)),
                                      child: Center(
                                        child: InkWell(
                                            onTap: () {
                                              if (state.viewModel
                                                      .isWifiDisconnect ==
                                                  true) {
                                              } else {
                                                Navigator.pushNamed(context,
                                                    RouteList.notification,
                                                    arguments: userDataData
                                                        .getUser()!
                                                        .id);
                                              }
                                            },
                                            child: badges.Badge(
                                              position:
                                                  badges.BadgePosition.topEnd(
                                                      top: -8,
                                                      end: -SizeConfig
                                                              .screenWidth *
                                                          0.035),
                                              badgeContent: state.viewModel
                                                          .unreadCount ==
                                                      null
                                                  ? null
                                                  : Text("${state.viewModel.unreadCount}",
                                                      style: TextStyle(
                                                          fontSize: SizeConfig
                                                                  .screenWidth *
                                                              0.03,
                                                          color: Colors.white)),
                                              child: const Icon(
                                                  Icons
                                                      .notifications_none_rounded,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    )
                                  ]),
                              lineDecor(
                                  spaceBottom: SizeConfig.screenWidth * 0.03,
                                  spaceTop: 5),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 2,
                                  right: 2,
                                  top: SizeConfig.screenWidth * 0.01,
                                  bottom: SizeConfig.screenWidth * 0.05,
                                ),
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(color: Colors.black26)
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: SizedBox(
                                  child: TextField(
                                    controller: filterKeyword,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            SizeConfig.screenWidth * 0.03),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText:
                                          translation(context).searchPatient,
                                      hintStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize:
                                              SizeConfig.screenWidth * 0.05),
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.search),
                                        color: Colors.black,
                                        onPressed: () {
                                          patientBloc.add(
                                            FilterPatientEvent(
                                                searchText: filterKeyword.text,
                                                id: widget.id),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //? Loading
                              ((state is GetPatientListState &&
                                          state.status ==
                                              BlocStatusState.loading) ||
                                      (state is SearchPatientState &&
                                          state.status ==
                                              BlocStatusState.loading) ||
                                      (state is DeletePatientState &&
                                          state.status ==
                                              BlocStatusState.loading) ||
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
                              //? Get thành công hoặc Giữ nguyên trạng thái
                              ((state is GetPatientListState &&
                                      state.status == BlocStatusState.success))
                                  ? formPatientListScreen(
                                      contxt: context,
                                      itemCount: state
                                          .viewModel.patientEntities?.length,
                                      patientInforEntities:
                                          state.viewModel.patientEntities!)
                                  : Container(),
                              //? Thành công
                              (state is SearchPatientState &&
                                      state.status == BlocStatusState.success)
                                  ? formPatientListScreen(
                                      contxt: context,
                                      itemCount: state
                                          .viewModel.patientEntities?.length,
                                      patientInforEntities:
                                          state.viewModel.patientEntities!)
                                  : Container(),
                              (state.status == BlocStatusState.failure &&
                                      (state is SearchPatientState ||
                                          state is GetPatientListState ||
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
                                            style: AppTextTheme.body2
                                                .copyWith(color: Colors.red),
                                          ),
                                          const SizedBox(height: 10),
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
