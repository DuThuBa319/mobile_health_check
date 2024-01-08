import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:mobile_health_check/common/singletons.dart';

import 'package:mobile_health_check/domain/entities/cell_person_entity.dart';
import 'package:mobile_health_check/utils/size_config.dart';

import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../classes/language.dart';

import '../../../common_widget/common.dart';
import '../../../route/route_list.dart';
import '../../../theme/app_text_theme.dart';
import '../bloc/admin_bloc.dart';

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
                    Navigator.pushNamed(context, RouteList.addDoctor);
                    filterKeyword = TextEditingController(text: "");
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
                      getDoctorBloc
                          .add(GetDoctorListEvent(admindId: widget.id!));
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
                                    hintText: translation(context).searchDoctor,
                                    hintStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize:
                                            SizeConfig.screenWidth * 0.05),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.search),
                                      color: Colors.black,
                                      onPressed: () {
                                        getDoctorBloc.add(
                                          FilterDoctorEvent(
                                              searchText: filterKeyword.text,
                                              adminId: widget.id!),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //? Loading
                            ((state is GetDoctorListState &&
                                        state.status ==
                                            BlocStatusState.loading) ||
                                    (state is SearchDoctorState &&
                                        state.status ==
                                            BlocStatusState.loading) ||
                                    (state is DeleteDoctorState &&
                                        state.status ==
                                            BlocStatusState.loading) ||
                                    (state is DeleteDoctorState &&
                                        state.status ==
                                            BlocStatusState.success &&
                                        state.viewModel.allDoctorEntity !=
                                            null))
                                ? const Expanded(
                                    child: Center(
                                      child:
                                          Loading(brightness: Brightness.light),
                                    ),
                                  )
                                : Container(),

                            //? Get thành công hoặc Giữ nguyên trạng thái
                            ((state is GetDoctorListState &&
                                        state.status ==
                                            BlocStatusState.success) ||
                                    (state is GetDoctorListState &&
                                        state.status ==
                                            BlocStatusState.loading &&
                                        state.viewModel.allDoctorEntity !=
                                            null) ||
                                    (state is DeleteDoctorState &&
                                        state.status ==
                                            BlocStatusState.failure &&
                                        state.viewModel.errorMessage ==
                                            translation(context)
                                                .cannotDeleteDoctor))
                                ? formDoctorListScreen(
                                    itemCount:
                                        state.viewModel.allDoctorEntity?.length,
                                    personCellEntities:
                                        state.viewModel.allDoctorEntity)
                                : Container(),
                            //? Thành công
                            (state is SearchDoctorState &&
                                    state.status == BlocStatusState.success)
                                ? formDoctorListScreen(
                                    itemCount:
                                        state.viewModel.allDoctorEntity?.length,
                                    isSearching: true,
                                    personCellEntities:
                                        state.viewModel.allDoctorEntity)
                                : Container(),

                            //? Failure
                            //  (state.status == BlocStatusState.failure) {
                            //   return Center(
                            //     child: Text(
                            //       translation(context).error,
                            //       style: TextStyle(
                            //           fontSize: SizeConfig.screenWidth * 0.05,
                            //           fontWeight: FontWeight.bold,
                            //           color: AppColor.red),
                            //     ),
                            //   );
                            // }
                          ]),
                    );
                  }),
            )));
  }
}
