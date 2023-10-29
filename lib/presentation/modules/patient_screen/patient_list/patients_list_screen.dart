import 'package:flutter/services.dart';
import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/enum_common.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';
import 'package:mobile_health_check/presentation/modules/patient_screen/patient_list/widget/patient_cell.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../classes/language.dart';

import '../../../../common/singletons.dart';
import '../../../common_widget/dialog/dialog_one_button.dart';
import '../../../common_widget/dialog/dialog_two_button.dart';
import '../../../common_widget/dialog/show_toast.dart';
import '../../../common_widget/loading_widget.dart';
import '../../../common_widget/screen_form/custom_screen_form.dart';

import '../../../route/route_list.dart';
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
    return WillPopScope(
        onWillPop: _onWillPop,
        child: CustomScreenForm(
            isRelativeApp: (userDataData.getUser()?.role == UserRole.relative)
                ? true
                : false,
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
                    Navigator.pushNamed(context, RouteList.addPatient,
                        arguments: patientBloc);
                    filterKeyword = TextEditingController(text: " ");
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
                      // if (userDataData.getUser()?.role == UserRole.doctor) {
                        patientBloc.add(GetPatientListEvent(userId: widget.id));
                      // }
                      //  else if (userDataData.getUser()?.role ==
                      //     UserRole.relative) {
                      //   patientBloc.add(GetPatientListOfRelativeEvent(
                      //       relativeId: widget.id));
                      // }
                    }

                    if ((state is GetPatientListState &&
                            state.status == BlocStatusState.loading) ||
                        // (state is GetPatientListOfRelativeState &&
                        //     state.status == BlocStatusState.loading) ||
                        (state is SearchPatientState &&
                            state.status == BlocStatusState.loading)) {
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
                                              Navigator.pushNamed(context,
                                                  RouteList.notification,
                                                  arguments: userDataData
                                                      .getUser()!
                                                      .id!);
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
                                  top: SizeConfig.screenWidth * 0.01,
                                  bottom: SizeConfig.screenWidth * 0.05,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.screenWidth * 0.03),
                                  color: Colors.white,
                                ),
                                child: userDataData.getUser()?.role ==
                                        UserRole.doctor
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: SizeConfig.screenWidth * 0.6,
                                            child: TextField(
                                              controller: filterKeyword,
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          SizeConfig
                                                                  .screenWidth *
                                                              0.03),
                                                  borderSide: BorderSide.none,
                                                ),
                                                hintText: translation(context)
                                                    .searchPatient,
                                                hintStyle: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize:
                                                        SizeConfig.screenWidth *
                                                            0.05),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  icon:
                                                      const Icon(Icons.search),
                                                  color: Colors.black,
                                                  onPressed: () {
                                                    patientBloc.add(
                                                      FilterPatientEvent(
                                                          searchText:
                                                              filterKeyword
                                                                  .text,
                                                          id: widget.id),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(
                                        child: TextField(
                                          controller: filterKeyword,
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      SizeConfig.screenWidth *
                                                          0.03),
                                              borderSide: BorderSide.none,
                                            ),
                                            hintText: translation(context)
                                                .searchPatient,
                                            hintStyle: TextStyle(
                                                color: Colors.black54,
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        0.05),
                                            suffixIcon: IconButton(
                                              icon: const Icon(Icons.search),
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
                              const Expanded(
                                child: Center(
                                  child: Loading(brightness: Brightness.light),
                                ),
                              )
                            ]),
                      );
                    }

                    if ((state is DeletePatientState &&
                            state.status == BlocStatusState.loading) ||
                        (state is GetPatientListState &&
                            state.status == BlocStatusState.success) ||
                        // (state is GetPatientListOfRelativeState &&
                        //     state.status == BlocStatusState.success) 
                        //     ||
                        (state is RegistPatientState &&
                            state.status == BlocStatusState.loading)) {
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
                                              Navigator.pushNamed(context,
                                                  RouteList.notification,
                                                  arguments: userDataData
                                                      .getUser()!
                                                      .id!);
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
                                  top: SizeConfig.screenWidth * 0.01,
                                  bottom: SizeConfig.screenWidth * 0.05,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.screenWidth * 0.03),
                                  color: Colors.white,
                                ),
                                child: userDataData.getUser()?.role ==
                                        UserRole.doctor
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: SizeConfig.screenWidth * 0.6,
                                            child: TextField(
                                              controller: filterKeyword,
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          SizeConfig
                                                                  .screenWidth *
                                                              0.03),
                                                  borderSide: BorderSide.none,
                                                ),
                                                hintText: translation(context)
                                                    .searchPatient,
                                                hintStyle: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize:
                                                        SizeConfig.screenWidth *
                                                            0.05),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  icon:
                                                      const Icon(Icons.search),
                                                  color: Colors.black,
                                                  onPressed: () {
                                                    patientBloc.add(
                                                      FilterPatientEvent(
                                                          searchText:
                                                              filterKeyword
                                                                  .text,
                                                          id: widget.id),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(
                                        child: TextField(
                                          controller: filterKeyword,
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      SizeConfig.screenWidth *
                                                          0.03),
                                              borderSide: BorderSide.none,
                                            ),
                                            hintText: translation(context)
                                                .searchPatient,
                                            hintStyle: TextStyle(
                                                color: Colors.black54,
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        0.05),
                                            suffixIcon: IconButton(
                                              icon: const Icon(Icons.search),
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
                              Expanded(
                                child: SmartRefresher(
                                  header: const WaterDropHeader(),
                                  controller: _refreshController,
                                  onRefresh: () async {
                                    await Future.delayed(
                                        const Duration(milliseconds: 1000));
                                    _refreshController.refreshCompleted();
                                    // if (userDataData.getUser()!.role! ==
                                    //     UserRole.doctor) {
                                      patientBloc.add(GetPatientListEvent(
                                          userId: widget.id));
                                    // } else if (userDataData.getUser()!.role! ==
                                    //     UserRole.relative) {
                                    //   patientBloc.add(
                                    //       GetPatientListOfRelativeEvent(
                                    //           relativeId: widget.id));
                                    // }
                                  },
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: state.viewModel.patientEntities
                                            ?.length ??
                                        0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final patientInforEntity = state
                                          .viewModel.patientEntities?[index];
                                      return PatientListCell(
                                        patientInforEntity: patientInforEntity,
                                        patientBloc: patientBloc,
                                      );
                                    },
                                  ),
                                ),
                              )
                            ]),
                      );
                    }

                    if (state is SearchPatientState &&
                        state.status == BlocStatusState.success) {
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
                                                SizeConfig.screenWidth *
                                                    0.030)),
                                        child: Center(
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    RouteList.notification,
                                                    arguments: userDataData
                                                        .getUser()!
                                                        .id!);
                                              },
                                              child: badges.Badge(
                                                // badgeStyle: badges.BadgeStyle(badgeColor:  (state.viewModel
                                                //                 .unreadCount ==
                                                //             null)
                                                //         ? null:AppColor.redFB4B53),
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
                                                    : Text(
                                                        "${state.viewModel.unreadCount}",
                                                        style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .screenWidth *
                                                                0.03,
                                                            color:
                                                                Colors.white)),
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
                                    top: SizeConfig.screenWidth * 0.01,
                                    bottom: SizeConfig.screenWidth * 0.05,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        SizeConfig.screenWidth * 0.03),
                                    color: Colors.white,
                                  ),
                                  child: userDataData.getUser()?.role ==
                                          UserRole.doctor
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width:
                                                  SizeConfig.screenWidth * 0.6,
                                              child: TextField(
                                                controller: filterKeyword,
                                                decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(SizeConfig
                                                                .screenWidth *
                                                            0.03),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  hintText: translation(context)
                                                      .searchPatient,
                                                  hintStyle: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: SizeConfig
                                                              .screenWidth *
                                                          0.05),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.search),
                                                    color: Colors.black,
                                                    onPressed: () {
                                                      patientBloc.add(
                                                        FilterPatientEvent(
                                                            searchText:
                                                                filterKeyword
                                                                    .text,
                                                            id: widget.id),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox(
                                          child: TextField(
                                            controller: filterKeyword,
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        SizeConfig.screenWidth *
                                                            0.03),
                                                borderSide: BorderSide.none,
                                              ),
                                              hintText: translation(context)
                                                  .searchPatient,
                                              hintStyle: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize:
                                                      SizeConfig.screenWidth *
                                                          0.05),
                                              suffixIcon: IconButton(
                                                icon: const Icon(Icons.search),
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
                                Expanded(
                                  child: SmartRefresher(
                                    header: const WaterDropHeader(),
                                    controller: _refreshController,
                                    onRefresh: () async {
                                      await Future.delayed(
                                          const Duration(milliseconds: 1000));
                                      _refreshController.refreshCompleted();
                                      patientBloc.add(
                                        FilterPatientEvent(
                                            searchText: filterKeyword.text,
                                            id: widget.id),
                                      );
                                    },
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: state
                                          .viewModel.patientEntities?.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final patientInforEntity = state
                                            .viewModel.patientEntities?[index];
                                        return PatientListCell(
                                          patientInforEntity:
                                              patientInforEntity,
                                          patientBloc: patientBloc,
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ]));
                    }

                    if ((state is GetPatientListState &&
                            state.status == BlocStatusState.failure) 
                            // ||
                        // state is GetPatientListOfRelativeState &&
                        //     state.status == BlocStatusState.failure
                            )
                             {
                      return Center(
                        child: Text(translation(context).error),
                      );
                    }

                    return Container();
                  }),
            )));
  }
}
