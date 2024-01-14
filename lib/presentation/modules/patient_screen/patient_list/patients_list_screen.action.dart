part of 'patients_list_screen.dart';

// ignore: library_private_types_in_public_api, recursive_getters
extension PatientListScreenAction on _PatientListState {
  void _blocListener(context, GetPatientState state) {
    //? Loading
    if (state.status == BlocStatusState.loading) {
      if (state is GetPatientListState || state is SearchPatientState) {
        showToast(translation(context).loadingData);
      }
      if (state is DeletePatientState) {
        showToast(translation(context).deletingPatient);
      }
    }

    //? success
    if (state.status == BlocStatusState.success) {
      if (state is GetPatientListState) {
        showToast(translation(context).dataLoaded);
      }
      if (state is DeletePatientState) {
        showToast(translation(context).deletePatientSuccessfully);
        patientBloc.add(GetPatientListEvent(userId: widget.id));
      }
    }

    //? Failure
    if (state.status == BlocStatusState.failure) {
      showToast(translation(context).loadingError);
      if (state.viewModel.isWifiDisconnect == true ||
          state is DeletePatientState) {
        showExceptionDialog(
            context: context,
            message: state.viewModel.errorMessage!,
            titleBtn: translation(context).exit);
      }
    }
  }

  _onWillPop(bool didPop) async {
    bool enableToPop = true;

    if (enableToPop == true) {
      await showWarningDialog(
          context: context,
          message: translation(context).areYouSureToExitApp,
          title: translation(context).exitAppTitle,
          onClose1: () {},
          onClose2: () {
            SystemNavigator.pop();
          });
    }
  }

  Widget formPatientListScreen(
      {BuildContext? contxt,
      int? itemCount,
      required List<PatientInforEntity> patientInforEntities}) {
    return Expanded(
      child: SmartRefresher(
          header: const WaterDropHeader(),
          controller: _refreshController,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            _refreshController.refreshCompleted();
            patientBloc.add(GetPatientListEvent(userId: widget.id));
          },
          child: ListView.separated(
            separatorBuilder: (context, int index) => const Divider(
              height: 8,
              color: AppColor.backgroundColor,
            ),
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: itemCount ?? 0,
            itemBuilder: (context, int index) {
              if (userDataData.getUser()?.role == UserRole.doctor) {
                final personCellEntity = patientInforEntities[index];
                final endDrawerWidgets = <SlidableDrawerWidget>[
                  SlidableDrawerWidget(
                      backgroundColor: AppColor.green9DEEB2,
                      foregroundColor: Colors.white,
                      iconData: Icons.phone,
                      labelText: translation(context).call,
                      onPressed: (context) {
                        return FlutterPhoneDirectCaller.callNumber(
                            personCellEntity.phoneNumber);
                      }),
                  SlidableDrawerWidget(
                      backgroundColor: AppColor.lineDecor,
                      foregroundColor: Colors.white,
                      iconData: Icons.delete_outline_outlined,
                      labelText: translation(context).delete,
                      onPressed: (context) {
                        showWarningDialog(
                            useRootNavigator: true,
                            context: contxt!,
                            message: translation(context).deletePatient,
                            title:
                                translation(context).deletePatientWarningTitle,
                            onClose1: () {
                              Navigator.pop(contxt);
                            },
                            onClose2: () {
                              patientBloc.add(DeletePatientEvent(
                                patientId: personCellEntity.id,
                              ));
                              Navigator.pop(contxt);
                            });
                      })
                ];
                //! SlideAbleForm
                return CustomSlidableWidget(
                  endDrawerWidgets: endDrawerWidgets,
                  iconLeadingCell: Icon(Icons.person_pin,
                      color: AppColor.lineDecor,
                      size: SizeConfig.screenDiagonal * 0.05),
                  textLine1: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    personCellEntity.name,
                    style: AppTextTheme.body2.copyWith(
                        fontSize: SizeConfig.screenDiagonal * 0.0225,
                        fontWeight: FontWeight.w500),
                  ),
                  textLine2: Text(
                      personCellEntity.phoneNumber == ""
                          ? translation(context).notUpdate
                          : personCellEntity.phoneNumber,
                      style: AppTextTheme.body3.copyWith(
                          fontSize: SizeConfig.screenDiagonal * 0.018)),
                  onTapCell: () {
                    Navigator.pushNamed(
                      context,
                      RouteList.patientInfor,
                      arguments: personCellEntity.id,
                    );
                  },
                );
              }
              if (userDataData.getUser()?.role == UserRole.relative) {
                return PatientListCell(
                  patientBloc: patientBloc,
                  patientInforEntity: patientInforEntities[index],
                );
              }
              return null;
            },
          )),
    );
  }
}
