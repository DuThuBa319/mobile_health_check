import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/enum_common.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';
import 'package:mobile_health_check/presentation/modules/admin_screen/doctor_list/widget/doctor_cell.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../classes/language.dart';

import '../../../../common/singletons.dart';
import '../../../common_widget/dialog/dialog_one_button.dart';
import '../../../common_widget/dialog/dialog_two_button.dart';
import '../../../common_widget/dialog/show_toast.dart';
import '../../../common_widget/loading_widget.dart';
import '../../../common_widget/screen_form/custom_screen_form.dart';

import '../../../route/route_list.dart';
import '../bloc/get_doctor_bloc.dart';

part 'doctor_list_screen.action.dart';

class DoctorListScreen extends StatefulWidget {
  final String? id;

  const DoctorListScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DoctorListScreen> createState() => _DoctorListState();
}

TextEditingController filterKeyword = TextEditingController(text: '');

class _DoctorListState extends State<DoctorListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  GetDoctorBloc get getDoctorBloc => BlocProvider.of(context);
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
            isRelativeApp: false,
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
                    Navigator.pushNamed(context, RouteList.addDoctor
                       );
                    filterKeyword = TextEditingController(text: " ");
                  },
                  icon: const Icon(
                    Icons.group_add_outlined,
                    color: Colors.white,
                  )),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: SizeConfig.screenWidth * 0.03),
              child: BlocConsumer<GetDoctorBloc, GetDoctorState>(
                  listener: _blocListener,
                  builder: (context, state) {
                    if (state is GetDoctorInitialState) {
                      getDoctorBloc.add(GetDoctorListEvent());
                    }

                    if ((state is GetDoctorListState &&
                            state.status == BlocStatusState.loading) ||
                        (state is SearchDoctorState &&
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
                              //! đổi text => doctorList
                              Text(
                                translation(context).doctorList,
                                style: TextStyle(
                                    fontSize: SizeConfig.screenWidth * 0.07,
                                    fontWeight: FontWeight.bold),
                              ),
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
                                  child: Row(
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
                                                      SizeConfig.screenWidth *
                                                          0.03),
                                              borderSide: BorderSide.none,
                                            ),
                                            hintText: translation(context)
                                                .searchDoctor,
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
                                              icon: const Icon(Icons.search),
                                              color: Colors.black,
                                              onPressed: () {
                                                getDoctorBloc.add(
                                                  FilterDoctorEvent(
                                                      searchText:
                                                          filterKeyword.text,
                                                      id: widget.id ??
                                                          widget.id!),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              const Expanded(
                                child: Center(
                                  child: Loading(brightness: Brightness.light),
                                ),
                              )
                            ]),
                      );
                    }

                    if ((state is DeleteDoctorState &&
                            state.status == BlocStatusState.loading) ||
                        (state is GetDoctorListState &&
                            state.status == BlocStatusState.success) ||
                        (state is DeleteDoctorState &&
                            state.status == BlocStatusState.success)) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.035,
                          right: SizeConfig.screenWidth * 0.035,
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translation(context).doctorList,
                                style: TextStyle(
                                    fontSize: SizeConfig.screenWidth * 0.07,
                                    fontWeight: FontWeight.bold),
                              ),
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
                                  child: Row(
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
                                                      SizeConfig.screenWidth *
                                                          0.03),
                                              borderSide: BorderSide.none,
                                            ),
                                            hintText: translation(context)
                                                .searchDoctor,
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
                                              icon: const Icon(Icons.search),
                                              color: Colors.black,
                                              onPressed: () {
                                                getDoctorBloc.add(
                                                  FilterDoctorEvent(
                                                      searchText:
                                                          filterKeyword.text,
                                                      id: widget.id ??
                                                          widget.id!),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              Expanded(
                                child: SmartRefresher(
                                  header: const WaterDropHeader(),
                                  controller: _refreshController,
                                  onRefresh: () async {
                                    await Future.delayed(
                                        const Duration(milliseconds: 1000));
                                    _refreshController.refreshCompleted();
                                    getDoctorBloc.add(GetDoctorListEvent());
                                  },
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: state.viewModel.allDoctorEntity
                                            ?.length ??
                                        0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final doctorCellEntity = state
                                          .viewModel.allDoctorEntity?[index];
                                      return DoctorListCell(
                                        doctorCellEntity: doctorCellEntity,
                                        doctorBloc: getDoctorBloc,
                                      );
                                    },
                                  ),
                                ),
                              )
                            ]),
                      );
                    }

                    if (state is SearchDoctorState &&
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
                                Text(
                                  translation(context).doctorList,
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth * 0.07,
                                      fontWeight: FontWeight.bold),
                                ),
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
                                    child: Row(
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
                                                        SizeConfig.screenWidth *
                                                            0.03),
                                                borderSide: BorderSide.none,
                                              ),
                                              hintText: translation(context)
                                                  .searchDoctor,
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
                                                icon: const Icon(Icons.search),
                                                color: Colors.black,
                                                onPressed: () {
                                                  getDoctorBloc.add(
                                                    FilterDoctorEvent(
                                                        searchText:
                                                            filterKeyword.text,
                                                        id: widget.id ??
                                                            widget.id!),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                  child: SmartRefresher(
                                    header: const WaterDropHeader(),
                                    controller: _refreshController,
                                    onRefresh: () async {
                                      await Future.delayed(
                                          const Duration(milliseconds: 1000));
                                      _refreshController.refreshCompleted();
                                      getDoctorBloc.add(
                                        FilterDoctorEvent(
                                            searchText: filterKeyword.text,
                                            id: widget.id ?? widget.id!),
                                      );
                                    },
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: state.viewModel.allDoctorEntity
                                              ?.length ??
                                          0,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final doctorCellEntity = state
                                            .viewModel.allDoctorEntity?[index];
                                        return DoctorListCell(
                                          doctorCellEntity: doctorCellEntity,
                                          doctorBloc: getDoctorBloc,
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ]));
                    }

                    if ((state is GetDoctorListState &&
                        state.status == BlocStatusState.failure)) {
                          //! dịch
                      return  Center(
                        child: Text(translation(context).error),
                      );
                    }

                    return Container();
                  }),
            )));
  }
}
