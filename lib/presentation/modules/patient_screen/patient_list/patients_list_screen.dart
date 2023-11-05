import 'package:flutter/services.dart';
import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/enum_common.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';
import 'package:mobile_health_check/presentation/modules/patient_screen/patient_list/widget/patient_list_cell.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../classes/language.dart';

import '../../../../common/singletons.dart';
import '../../../../domain/entities/patient_infor_entity.dart';
import '../../../common_widget/dialog/dialog_one_button.dart';
import '../../../common_widget/dialog/dialog_two_button.dart';
import '../../../common_widget/dialog/show_toast.dart';
import '../../../common_widget/loading_widget.dart';
import '../../../common_widget/screen_form/custom_screen_form.dart';

import '../../../common_widget/slidable.dart';
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
                      patientBloc.add(GetPatientListEvent(userId: widget.id));
                    }
                    if ((state is GetPatientListState &&
                            state.status == BlocStatusState.loading) ||
                        (state is SearchPatientState &&
                            state.status == BlocStatusState.loading)) {
                      return formPatientListScreen(
                          unreadCount: state.viewModel.unreadCount,
                          isLoading: true);
                    }
                    if ((state is GetPatientListState &&
                            state.status == BlocStatusState.success) ||
                        (state is GetPatientListState &&
                            state.status == BlocStatusState.loading &&
                            state.viewModel.patientEntities == null)) {
                      return formPatientListScreen(
                        isLoading: false,
                        itemCount: state.viewModel.patientEntities?.length,
                        patientInforEntities: state.viewModel.patientEntities,
                        unreadCount: state.viewModel.unreadCount,
                      );
                    }

                    if (state is SearchPatientState &&
                        state.status == BlocStatusState.success) {
                      return formPatientListScreen(
                        isSearching: true,
                        itemCount: state.viewModel.patientEntities?.length,
                        patientInforEntities: state.viewModel.patientEntities,
                        unreadCount: state.viewModel.unreadCount,
                      );
                    }

                    if ((state is GetPatientListState &&
                            state.status == BlocStatusState.failure) ||
                        (state is SearchPatientState &&
                            state.status == BlocStatusState.failure) ||
                        (state is DeletePatientState &&
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
