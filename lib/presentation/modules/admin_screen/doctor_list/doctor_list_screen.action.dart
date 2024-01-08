part of 'doctor_list_screen.dart';

// ignore: library_private_types_in_public_api
extension DoctorListScreenAction on _DoctorListState {
  void _blocListener(BuildContext context, GetDoctorState state) {
    if (state is GetDoctorListState &&
        state.status == BlocStatusState.loading) {
      showToast(translation(context).loadingData);
    }
    if ((state is GetDoctorListState &&
        state.status == BlocStatusState.success)) {
      showToast(translation(context).dataLoaded);
    }
    if (state is GetDoctorListState &&
        state.status == BlocStatusState.failure) {
      showToast(translation(context).loadingError);
    }
    if (state is DeleteDoctorState && state.status == BlocStatusState.loading) {
      showToast(translation(context).deletingDoctoc);
    }
    if (state is DeleteDoctorState && state.status == BlocStatusState.success) {
      showToast(translation(context).deleteDoctorSuccessfully);
      getDoctorBloc.add(GetDoctorListEvent(admindId: widget.id!));
    }

    if (state.status == BlocStatusState.failure &&
        state.viewModel.errorMessage == translation(context).wifiDisconnect) {
      showExceptionDialog(
          context: context,
          message: translation(context).wifiDisconnect,
          titleBtn: translation(context).exit);
    }

    if (state is DeleteDoctorState &&
        state.status == BlocStatusState.failure &&
        state.viewModel.errorMessage ==
            translation(context).cannotDeleteDoctor) {
      showExceptionDialog(
          contentDialogSize: SizeConfig.screenWidth * 0.037,
          context: context,
          message: state.viewModel.errorMessage!,
          titleBtn: translation(context).exit);
    }
  }

  _onWillPop(bool didPop) async {
    bool enableToPop = true;

    if (enableToPop == true) {
      await showWarningDialog(
          context: context,
          message: translation(context).areYouSureToExitApp,
          title: translation(context).exitAppTitle,
          titleBtn1: translation(context).no,
          titleBtn2: translation(context).yes,
          onClose1: () {},
          onClose2: () {
            SystemNavigator.pop();
          });
    }
  }

  Widget formDoctorListScreen(
      {bool isSearching = false,
      bool isLoading = false,
      int? itemCount,
      List<PersonCellEntity>? personCellEntities}) {
    return Expanded(
      child: SmartRefresher(
        header: const WaterDropHeader(),
        controller: _refreshController,
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1000));
          _refreshController.refreshCompleted();
          getDoctorBloc.add(GetDoctorListEvent(admindId: widget.id!));
        },
        child: personCellEntities!.isNotEmpty
            ? ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  height: 8,
                  color: AppColor.backgroundColor,
                ),
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: itemCount ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final personCellEntity = personCellEntities[index];
                  final endDrawerWidgets = <SlidableDrawerWidget>[
                    SlidableDrawerWidget(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        iconData: Icons.phone,
                        labelText: translation(context).call,
                        onPressed: (context) {
                          return FlutterPhoneDirectCaller.callNumber(
                              personCellEntity.phoneNumber);
                        }),
                    SlidableDrawerWidget(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        iconData: Icons.delete_outline_outlined,
                        labelText: translation(context).delete,
                        onPressed: (context) {
                          showWarningDialog(
                              useRootNavigator: true,
                              //! Chỗ này lưu ý context có thể bị out khỏi stack trước đó rồi
                              context: navigationService
                                      .navigatorKey.currentContext ??
                                  context,
                              message: translation(context).deleteDoctor,
                              title:
                                  translation(context).deleteDoctorWarningTitle,
                              titleBtn1: translation(context).no,
                              titleBtn2: translation(context).yes,
                              onClose1: () {
                                //! Chỗ này lưu ý context có thể bị out khỏi stack trước đó rồi
                                Navigator.pop(navigationService
                                        .navigatorKey.currentContext ??
                                    context);
                              },
                              onClose2: () {
                                getDoctorBloc.add(DeleteDoctorEvent(
                                  doctorId: personCellEntity.id,
                                  adminId: userDataData.getUser()?.id,
                                ));

                                //! Chỗ này lưu ý context có thể bị out khỏi stack trước đó rồi
                                Navigator.pop(navigationService
                                        .navigatorKey.currentContext ??
                                    context);
                              });
                        })
                  ];
                  //! SlideAbleForm
                  return CustomSlidableWidget(
                    endDrawerWidgets: endDrawerWidgets,
                    iconLeadingCell: Icon(
                      Icons.person_pin,
                      color: AppColor.lineDecor,
                      size: SizeConfig.screenWidth * 0.11,
                    ),
                    textLine1: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      personCellEntity.name,
                      style: AppTextTheme.body2.copyWith(
                          fontSize: SizeConfig.screenWidth * 0.052,
                          fontWeight: FontWeight.w500),
                    ),
                    textLine2: Text(
                        personCellEntity.phoneNumber == ""
                            ? translation(context).notUpdate
                            : personCellEntity.phoneNumber,
                        style: AppTextTheme.body3),
                    onTapCell: () {
                      Navigator.pushNamed(
                        context,
                        RouteList.doctorInfor,
                        arguments: personCellEntity.id,
                      );
                    },
                  );
                },
              )
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    softWrap: true,
                    textAlign: TextAlign.center,
                    (isSearching == false)
                        ? translation(context).noDoctor
                        : translation(context).wrongSearchDoctor,
                    style: AppTextTheme.body2.copyWith(
                        color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                ],
              )),
      ),
    );
  }
}
