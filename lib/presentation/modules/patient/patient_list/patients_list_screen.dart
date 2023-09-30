import 'package:flutter/services.dart';
import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/enum_common.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';
import 'package:mobile_health_check/presentation/modules/patient/patient_list/widget/patient_cell.dart';
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
  int? numberOfNotification = 0;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GetPatientBloc get patientBloc => BlocProvider.of(context);

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
          isRelativeApp:
              (userDataData.getUser()?.role == "relative") ? true : false,
          isShowAppBar: false,
          isShowLeadingButton: false,
          isShowBottomNayvigationBar: true,
          isShowRightButon: false,
          backgroundColor: AppColor.backgroundColor,
          appBarColor: AppColor.backgroundColor,
          title: "",
          // ),
          selectedIndex: 0,
          floatActionButton: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 244, 51, 51),
                borderRadius: BorderRadius.circular(30)),
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteList.addPatient,
                      arguments: patientBloc);
                  filterKeyword = TextEditingController(text: "");
                },
                icon: const Icon(
                  Icons.group_add_outlined,
                  color: Colors.white,
                )),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          translation(context).patientList,
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.07,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: SizeConfig.screenWidth * 0.09,
                          height: SizeConfig.screenWidth * 0.09,
                          margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(100, 22, 44, 33),
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteList.notification,
                                      arguments: userDataData.getUser()!.id!);
                                },
                                child: badges.Badge(
                                  position: badges.BadgePosition.topEnd(
                                      top: -8, end: -15),
                                  badgeContent: Text("$numberOfNotification",
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.white)),
                                  child: const Icon(
                                      Icons.notifications_none_rounded,
                                      color: Colors.white),
                                )),
                          ),
                        )
                      ]),
                  lineDecor(spaceBottom: 10, spaceTop: 5),
                  Container(
                    margin: EdgeInsets.only(
                      top: 8,
                      bottom: SizeConfig.screenWidth * 0.05,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: userDataData.getUser()?.role == "doctor"
                        ? Row(
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
                                    hintText:
                                        translation(context).searchPatient,
                                    hintStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize:
                                            SizeConfig.screenWidth * 0.05),
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
                                // filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: translation(context).searchPatient,
                                hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: SizeConfig.screenWidth * 0.05),
                                suffixIcon: IconButton(
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
                              ),
                            ),
                          ),
                  ),
                  BlocConsumer<GetPatientBloc, GetPatientState>(
                      listener: _blocListener,
                      builder: (context, state) {
                        if (state is GetPatientInitialState) {
                          if (userDataData.getUser()!.role! == 'doctor') {
                            patientBloc.add(GetPatientListEvent(
                                id: widget.id ?? widget.id!));
                          } 
                          else if (userDataData.getUser()!.role! ==
                              'relative') {
                            patientBloc.add(GetPatientListOfRelativeEvent(
                                relativeId: widget.id ?? widget.id!));
                          }
                        }
                        if ((state is GetPatientListState &&
                                state.status == BlocStatusState.loading) ||
                            (state is GetPatientListOfRelativeState &&
                                state.status == BlocStatusState.loading)) {
                          return const Expanded(
                            child: Center(
                              child: Loading(brightness: Brightness.light),
                            ),
                          );
                        }

                        if ((state is DeletePatientState &&
                                state.status == BlocStatusState.loading) ||
                            (state is GetPatientListState &&
                                state.status == BlocStatusState.success) ||
                            (state is DeletePatientState &&
                                state.status == BlocStatusState.success) ||
                            (state is RegistPatientState &&
                                state.status == BlocStatusState.loading)) {
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
                                  final patientInforEntity = state.viewModel
                                      .doctorInforEntity?.patients![index];
                                  return PatientListCell(
                                    patientInforEntity: patientInforEntity,
                                    patientBloc: patientBloc,
                                  );
                                },
                              ),
                            ),
                          );
                        }
                        if ((state is GetPatientListOfRelativeState &&
                            state.status == BlocStatusState.success)) {
                          return Expanded(
                            child: SmartRefresher(
                              header: const WaterDropHeader(),
                              controller: _refreshController,
                              onRefresh: () async {
                                await Future.delayed(
                                    const Duration(milliseconds: 1000));
                                _refreshController.refreshCompleted();
                                patientBloc.add(GetPatientListOfRelativeEvent(
                                    relativeId: widget.id ?? widget.id!));
                              },
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: state.viewModel.relativeInforEntity
                                        ?.patients?.length ??
                                    0,
                                itemBuilder: (BuildContext context, int index) {
                                  final patientInforEntity = state.viewModel
                                      .relativeInforEntity?.patients![index];
                                  return PatientListCell(
                                    patientInforEntity: patientInforEntity,
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
                                    state.viewModel.patientEntities?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final patientInforEntity =
                                      state.viewModel.patientEntities?[index];
                                  return PatientListCell(
                                    patientInforEntity: patientInforEntity,
                                    patientBloc: patientBloc,
                                  );
                                },
                              ),
                            ),
                          );
                        }
                        if ((mounted is GetPatientListState &&
                                state.status == BlocStatusState.failure) ||
                            state is GetPatientListOfRelativeState &&
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
