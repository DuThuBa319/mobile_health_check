import 'package:flutter/services.dart';
import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/enum_common.dart';
import 'package:mobile_health_check/presentation/modules/patient/patient_list/widget/patient_cell.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../classes/language_constant.dart';

import '../../../common_widget/dialog/show_toast.dart';
import '../../../common_widget/loading_widget.dart';
import '../../../common_widget/screen_form/custom_screen_form.dart';

import '../../../route/route_list.dart';
import '../../notification_onesignal/bloc/notification_bloc.dart';
import '../bloc/get_patient_bloc.dart';

part 'patients_list_screen.action.dart';

//Class Home
class PatientListScreen extends StatefulWidget {
  final String? id;

  const PatientListScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<PatientListScreen> createState() => _PatientListState();
}

TextEditingController filterKeyword = TextEditingController(text: '');

final TextEditingController idController = TextEditingController();
final TextEditingController ageController = TextEditingController();
final TextEditingController jobController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneNumberController = TextEditingController();

class _PatientListState extends State<PatientListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GetPatientBloc get patientBloc => BlocProvider.of(context);
  NotificationBloc get notificationBloc => BlocProvider.of(context);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      filterKeyword = TextEditingController(text: '');
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: CustomScreenForm(
          isShowAppBar: true,
          isShowLeadingButton: false,
          isShowBottomNayvigationBar: true,
          isShowRightButon: false,
          backgroundColor: AppColor.backgroundColor,
          appBarColor: AppColor.topGradient,
          // unreadCount: notificationData.unreadCount,
          // rightButton: IconButton(
          //   onPressed: gotoRegistPatientScreen,
          //   icon: const Icon(Icons.add),
          title: translation(context).patientList,
          // ),
          selectedIndex: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 8,
                      bottom: SizeConfig.screenWidth * 0.05,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.6,
                          child: TextField(
                            controller: filterKeyword,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              // filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintText: translation(context).searchPatient,
                              hintStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: SizeConfig.screenWidth * 0.05),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.search),
                                color: Colors.black,
                                onPressed: () {
                                  patientBloc.add(
                                    FilterPatientEvent(
                                        searchText: filterKeyword.text,
                                        id: widget.id ?? widget.id!),
                                  );
                                },
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, RouteList.addPatient);
                                    filterKeyword =
                                        TextEditingController(text: "");
                                  },
                                  icon: const Icon(
                                    Icons.group_add_outlined,
                                    color: Colors.black,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<GetPatientBloc, GetPatientState>(
                      listener: _blocListener,
                      builder: (context, state) {
                        if (state is GetPatientInitialState) {
                          patientBloc.add(
                              GetPatientListEvent(id: widget.id ?? widget.id!));
                        }
                        if (state is GetPatientListState &&
                            state.status == BlocStatusState.loading) {
                          return const Expanded(
                            child: Center(
                              child: Loading(brightness: Brightness.light),
                            ),
                          );
                        }

                        if (state is GetPatientListState &&
                            state.status == BlocStatusState.success) {
                          return Expanded(
                            child: SmartRefresher(
                              header: const WaterDropHeader(),
                              controller: _refreshController,
                              onRefresh: () async {
                                await Future.delayed(
                                    const Duration(milliseconds: 1000));
                                _refreshController.refreshCompleted();
                                patientBloc.add(GetPatientListEvent(
                                    id: widget.id ?? widget.id!));
                              },
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: state.viewModel.doctorInforEntity
                                        ?.patients?.length ??
                                    0,
                                itemBuilder: (BuildContext context, int index) {
                                  final patientEntity = state.viewModel
                                      .doctorInforEntity?.patients![index];
                                  return PatientListCell(
                                    patientEntity: patientEntity,
                                    patientBloc: patientBloc,
                                  );
                                },
                              ),
                            ),
                          );
                        }
                        if (state is SearchPatientState &&
                            state.status == BlocStatusState.loading) {
                          return const Expanded(
                            child: Center(
                              child: Loading(brightness: Brightness.light),
                            ),
                          );
                        }
                        if (state is SearchPatientState &&
                            state.status == BlocStatusState.success) {
                          return Expanded(
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
                                      id: widget.id ?? widget.id!),
                                );
                              },
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount:
                                    state.viewModel.patientEntity!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final patientEntity =
                                      state.viewModel.patientEntity?[index];
                                  return PatientListCell(
                                    patientEntity: patientEntity,
                                    patientBloc: patientBloc,
                                  );
                                },
                              ),
                            ),
                          );
                        }
                        if (state is GetPatientListState &&
                            state.status == BlocStatusState.failure) {
                          return const Center(
                            child: Text("error"),
                          );
                        }
                        return Container();
                      }),
                ]),
          )),
    );
  }
}
