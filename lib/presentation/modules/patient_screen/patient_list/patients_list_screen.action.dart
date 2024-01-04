part of 'patients_list_screen.dart';

// ignore: library_private_types_in_public_api
extension PatientListScreenAction on _PatientListState {
  void _blocListener(BuildContext context, GetPatientState state) {
    if (state is GetPatientListState &&
        state.status == BlocStatusState.loading) {
      showToast(translation(context).loadingData);
    }
    if (state is GetPatientListState &&
        state.status == BlocStatusState.success) {
      showToast(translation(context).dataLoaded);
    }
    if (state is GetPatientListState &&
        state.status == BlocStatusState.failure) {
      showToast(translation(context).loadingError);
    }

    if (state is DeletePatientState &&
        state.status == BlocStatusState.loading) {
      showToast(translation(context).deletingPatient);
    }

    if ((state is DeletePatientState &&
        state.status == BlocStatusState.success)) {
      showToast(translation(context).deletePatientSuccessfully);
      patientBloc.add(GetPatientListEvent(userId: widget.id));
    }

    if (state.status == BlocStatusState.failure &&
        state.viewModel.errorMessage == translation(context).wifiDisconnect) {
      showExceptionDialog(
          context: context,
          message: translation(context).wifiDisconnect,
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

  Widget formPatientListScreen(
      {bool isSearching = false,
      int? unreadCount,
      bool isLoading = false,
      int? itemCount,
      List<PatientInforEntity>? patientInforEntities}) {
    patientInforEntities ??= [];
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.035,
        right: SizeConfig.screenWidth * 0.035,
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                translation(context).patientList,
                style: TextStyle(
                    fontSize: SizeConfig.screenWidth * 0.07,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: SizeConfig.screenWidth * 0.09,
                height: SizeConfig.screenWidth * 0.09,
                margin: EdgeInsets.only(
                  right: SizeConfig.screenWidth * 0.02,
                ),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(100, 22, 44, 33),
                    borderRadius:
                        BorderRadius.circular(SizeConfig.screenWidth * 0.030)),
                child: Center(
                  child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteList.notification,
                            arguments: userDataData.getUser()!.id);
                      },
                      child: badges.Badge(
                        position: badges.BadgePosition.topEnd(
                            top: -8, end: -SizeConfig.screenWidth * 0.035),
                        badgeContent: unreadCount == null
                            ? null
                            : Text("$unreadCount",
                                style: TextStyle(
                                    fontSize: SizeConfig.screenWidth * 0.03,
                                    color: Colors.white)),
                        child: const Icon(Icons.notifications_none_rounded,
                            color: Colors.white),
                      )),
                ),
              )
            ]),
            lineDecor(spaceBottom: SizeConfig.screenWidth * 0.03, spaceTop: 5),
            Container(
              margin: EdgeInsets.only(
                left: 2,
                right: 2,
                top: SizeConfig.screenWidth * 0.01,
                bottom: SizeConfig.screenWidth * 0.05,
              ),
              decoration: BoxDecoration(
                boxShadow: const [BoxShadow(color: Colors.black26)],
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: SizedBox(
                child: TextField(
                  controller: filterKeyword,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(SizeConfig.screenWidth * 0.03),
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
                              searchText: filterKeyword.text, id: widget.id),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            (isLoading == true)
                ? const Expanded(
                    child: Center(
                      child: Loading(brightness: Brightness.light),
                    ),
                  )
                : Expanded(
                    child: SmartRefresher(
                      header: const WaterDropHeader(),
                      controller: _refreshController,
                      onRefresh: () async {
                        await Future.delayed(
                            const Duration(milliseconds: 1000));
                        _refreshController.refreshCompleted();
                        patientBloc.add(GetPatientListEvent(userId: widget.id));
                      },
                      child: (patientInforEntities.isNotEmpty)
                          ? ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(
                                height: 8,
                                color: AppColor.backgroundColor,
                              ),
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: itemCount ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                final patientInforEntity =
                                    patientInforEntities?[index];
                                return (userDataData.getUser()?.role ==
                                        UserRole.doctor)
                                    ?
                                    //! SlideAbleForm
                                    SlideAbleForm(
                                        lableAction1: translation(context).call,
                                        lableAction2:
                                            translation(context).delete,
                                        iconAction1: Icons.phone,
                                        iconAction2:
                                            Icons.delete_outline_outlined,
                                        widthLeadingIconCell:
                                            SizeConfig.screenWidth * 0.11,
                                        iconLeadingCell: Icon(
                                          Icons.person_pin,
                                          color: AppColor.lineDecor,
                                          size: SizeConfig.screenWidth * 0.11,
                                        ),
                                        textLine1: Text(
                                          patientInforEntity?.name ?? '',
                                          style: AppTextTheme.body2.copyWith(
                                              fontSize: SizeConfig.screenWidth *
                                                  0.052,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        textLine2: Text(
                                            patientInforEntity?.phoneNumber ==
                                                    ""
                                                ? translation(context).notUpdate
                                                : patientInforEntity!
                                                    .phoneNumber,
                                            style: AppTextTheme.body3),
                                        onTapCell: () {
                                          Navigator.pushNamed(
                                            context,
                                            RouteList.patientInfor,
                                            arguments: patientInforEntity?.id,
                                          );
                                        },
                                        onAction1: () {
                                          return FlutterPhoneDirectCaller
                                              .callNumber(patientInforEntity!
                                                  .phoneNumber);
                                        },
                                        onAction2: () {
                                          NavigationService navigationService =
                                              injector<NavigationService>();
                                          showWarningDialog(
                                              useRootNavigator: true,
                                              //! Chỗ này lưu ý context có thể bị out khỏi stack trước đó rồi
                                              context: navigationService
                                                      .navigatorKey
                                                      .currentContext ??
                                                  context,
                                              message: translation(context)
                                                  .deletePatient,
                                              title: translation(context)
                                                  .deletePatientWarningTitle,
                                              titleBtn1:
                                                  translation(context).no,
                                              titleBtn2:
                                                  translation(context).yes,
                                              onClose1: () {
                                                //! Chỗ này lưu ý context có thể bị out khỏi stack trước đó rồi
                                                Navigator.pop(navigationService
                                                        .navigatorKey
                                                        .currentContext ??
                                                    context);
                                              },
                                              onClose2: () {
                                                patientBloc
                                                    .add(DeletePatientEvent(
                                                  patientId:
                                                      patientInforEntity!.id,
                                                ));
                                                //! Chỗ này lưu ý context có thể bị out khỏi stack trước đó rồi
                                                Navigator.pop(navigationService
                                                        .navigatorKey
                                                        .currentContext ??
                                                    context);
                                              });
                                        },
                                      )

                                    //? SlideAbleForm(
                                    //     isPatientCell: true,
                                    //     patientBloc: patientBloc,
                                    //     patientInforEntity: patientInforEntity,
                                    //   )

                                    //! PatientList Cell không có slidable
                                    : PatientListCell(
                                        patientBloc: patientBloc,
                                        patientInforEntity: patientInforEntity,
                                      );
                              },
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  (isSearching == false)
                                      ? translation(context).noPatient
                                      : translation(context).wrongSearchPatient,
                                  style: AppTextTheme.body2.copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                    ),
                  ),
          ]),
    );
  }
}
