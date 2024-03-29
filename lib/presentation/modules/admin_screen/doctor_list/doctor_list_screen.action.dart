part of 'doctor_list_screen.dart';

// ignore: library_private_types_in_public_api
extension DoctorListScreenAction on _DoctorListState {
  void _blocListener(BuildContext context, GetDoctorState state) {
    //? loading
    if (state.status == BlocStatusState.loading) {
      if (state is GetDoctorListState) {}
      if (state is DeleteDoctorState) {
        showToast(
            context: context,
            status: ToastStatus.loading,
            toastString: translation(context).deletingDoctoc);
      }
    }

    //? Success
    if (state.status == BlocStatusState.success) {
      if (state is GetDoctorListState) {
        showToast(
            context: context,
            status: ToastStatus.success,
            toastString: translation(context).dataLoaded);
      }
      if (state is DeleteDoctorState) {
        showToast(
            context: context,
            status: ToastStatus.success,
            toastString: translation(context).deleteDoctorSuccessfully);
        getDoctorBloc.add(GetDoctorListEvent(admindId: widget.id!));
      }
    }

    //? Failure
    if (state.status == BlocStatusState.failure) {
      if (state is! DeleteDoctorState && state is! RegistDoctorState) {
        showToast(
            context: context,
            status: ToastStatus.error,
            toastString: state.viewModel.errorMessage);
      }

      if (state is DeleteDoctorState) {
        showExceptionDialog(
            contentDialogSize: SizeConfig.screenDiagonal < 1350
                ? SizeConfig.screenWidth * 0.045
                : SizeConfig.screenWidth * 0.04,
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
          contentDialogSize: SizeConfig.screenDiagonal < 1350
              ? SizeConfig.screenWidth * 0.04
              : SizeConfig.screenWidth * 0.045,
          context: context,
          message: translation(context).areYouSureToExitApp,
          title: translation(context).exitAppTitle,
          onClose1: () {},
          onClose2: () {
            SystemNavigator.pop();
          });
    }
  }

  Widget formDoctorListScreen(
      {BuildContext? contxt,
      int? itemCount,
      required List<PersonCellEntity> personCellEntities}) {
    return Expanded(
      child: SmartRefresher(
          header: const WaterDropHeader(),
          controller: _refreshController,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            _refreshController.refreshCompleted();
            getDoctorBloc.add(GetDoctorListEvent(admindId: widget.id!));
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
              final personCellEntity = personCellEntities[index];
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
                          contentDialogSize: SizeConfig.screenDiagonal < 1350
                              ? SizeConfig.screenWidth * 0.04
                              : SizeConfig.screenWidth * 0.045,
                          useRootNavigator: true,
                          context: contxt!,
                          message: translation(context).deleteDoctor,
                          title: translation(context).deleteDoctorWarningTitle,
                          onClose1: () {
                            Navigator.pop(contxt);
                          },
                          onClose2: () {
                            getDoctorBloc.add(DeleteDoctorEvent(
                              doctorId: personCellEntity.id,
                              adminId: userDataData.getUser()?.id,
                            ));
                            Navigator.pop(contxt);
                          });
                    })
              ];
              //! SlideAbleForm
              return CustomSlidableWidget(
                endDrawerWidgets: endDrawerWidgets,
                iconLeadingCell: Transform.translate(
                  offset: Offset(
                      0,
                      SizeConfig.screenDiagonal < 1350
                          ? 0
                          : -SizeConfig.screenHeight * 0.0055),
                  child: Icon(Icons.person_pin,
                      color: AppColor.lineDecor,
                      size: SizeConfig.screenDiagonal * 0.045),
                ),
                textLine1: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  personCellEntity.name,
                  style: AppTextTheme.body2.copyWith(
                      fontSize: SizeConfig.screenDiagonal < 1350
                          ? SizeConfig.screenWidth * 0.055
                          : SizeConfig.screenWidth * 0.045,
                      fontWeight: FontWeight.w500),
                ),
                textLine2: Text(
                    personCellEntity.phoneNumber == ""
                        ? translation(context).notUpdate
                        : personCellEntity.phoneNumber,
                    style: AppTextTheme.body3.copyWith(
                      fontSize: SizeConfig.screenDiagonal < 1350
                          ? SizeConfig.screenWidth * 0.04
                          : SizeConfig.screenWidth * 0.035,
                    )),
                onTapCell: () {
                  Navigator.pushNamed(
                    context,
                    RouteList.doctorInfor,
                    arguments: personCellEntity.id,
                  );
                },
              );
            },
          )),
    );
  }
}
