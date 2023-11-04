import 'package:mobile_health_check/domain/entities/cell_person_entity.dart';
import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/enum_common.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../classes/language.dart';

import '../../../common_widget/dialog/dialog_one_button.dart';
import '../../../common_widget/dialog/dialog_two_button.dart';
import '../../../common_widget/dialog/show_toast.dart';
import '../../../common_widget/loading_widget.dart';
import '../../../common_widget/screen_form/custom_screen_form.dart';

import '../../../common_widget/slidable.dart';
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
                        (state is GetDoctorListState &&
                            state.status == BlocStatusState.loading &&
                            state.viewModel.allDoctorEntity == null) ||
                        (state is SearchDoctorState &&
                            state.status == BlocStatusState.loading) ||
                        (state is DeleteDoctorState &&
                            state.status == BlocStatusState.loading)) {
                      return formDoctorListScreen(
                        isloading: true,
                      );
                    }

                    if ((state is GetDoctorListState &&
                            state.status == BlocStatusState.success) ||
                        (state is SearchDoctorState &&
                            state.status == BlocStatusState.success) ||
                        (state is DeleteDoctorState &&
                            state.status == BlocStatusState.success)) {
                      return formDoctorListScreen(
                          itemCount: state.viewModel.allDoctorEntity?.length,
                          isloading: false,
                          personCellEntities: state.viewModel.allDoctorEntity);
                    }

                    if ((state is GetDoctorListState &&
                            state.status == BlocStatusState.failure) ||
                        (state is DeleteDoctorState &&
                            state.status == BlocStatusState.failure) ||
                        (state is SearchDoctorState &&
                            state.status == BlocStatusState.failure) ||
                        (state is WifiDisconnectState &&
                            state.status == BlocStatusState.success)) {
                      return Center(
                        child: Text(translation(context).error),
                      );
                    }

                    return Container();
                  }),
            )));
  }
}
