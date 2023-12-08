import 'package:flutter/services.dart';
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
                    if (state is GetDoctorInitialState ||
                        (state is DeleteDoctorState &&
                            state.status == BlocStatusState.success)) {
                      getDoctorBloc.add(GetDoctorListEvent());
                    }

                    if ((state is GetDoctorListState &&
                            state.status == BlocStatusState.loading) ||
                        (state is GetDoctorListState &&
                            state.status == BlocStatusState.loading &&
                            state.viewModel.allDoctorEntity == null) ||
                        (state is SearchDoctorState &&
                            state.status == BlocStatusState.loading)) {
                      return formDoctorListScreen(
                        isLoading: true,
                      );
                    }

                    if ((state is GetDoctorListState &&
                            state.status == BlocStatusState.success) ||
                        (state is DeleteDoctorState &&
                            state.status == BlocStatusState.loading) ||
                        (state is DeleteDoctorState &&
                            state.status == BlocStatusState.failure &&
                            state.viewModel.errorMessage ==
                                translation(context).cannotDeleteDoctor)) {
                      return formDoctorListScreen(
                          itemCount: state.viewModel.allDoctorEntity?.length,
                          isLoading: false,
                          personCellEntities: state.viewModel.allDoctorEntity);
                    }
                    if (state is SearchDoctorState &&
                        state.status == BlocStatusState.success) {
                      return formDoctorListScreen(
                          itemCount: state.viewModel.allDoctorEntity?.length,
                          isSearching: true,
                          personCellEntities: state.viewModel.allDoctorEntity);
                    }

                    if (state.status == BlocStatusState.failure) {
                      return Center(
                        child: Text(
                          translation(context).error,
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                              color: AppColor.red),
                        ),
                      );
                    }

                    return Container();
                  }),
            )));
  }
}
