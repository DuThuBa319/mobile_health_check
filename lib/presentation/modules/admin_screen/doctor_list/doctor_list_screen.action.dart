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
    if (state is DeleteDoctorState && state.status == BlocStatusState.success) {
      showToast(translation(context).deleteDoctorSuccessfully);
    }

    if (state is WifiDisconnectState &&
        state.status == BlocStatusState.success) {
      showNoticeDialog(
          context: context,
          message: translation(context).wifiDisconnect,
          title: translation(context).notification,
          titleBtn: translation(context).exit);
    }
  }

  Future<bool> _onWillPop() async {
    return (await showNoticeDialogTwoButton(
            context: context,
            message: translation(context).exitApp,
            title: translation(context).areYouSure,
            titleBtn1: translation(context).no,
            titleBtn2: translation(context).yes,
            onClose1: () {},
            onClose2: () {
              Navigator.pop(context);
            })) ??
        false;
  }

  Widget formDoctorListScreen(
      {bool? isloading,
      int? itemCount,
      List<PersonCellEntity>? personCellEntities}) {
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
                    hintText: translation(context).searchDoctor,
                    hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: SizeConfig.screenWidth * 0.05),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      color: Colors.black,
                      onPressed: () {
                        getDoctorBloc.add(
                          FilterDoctorEvent(
                              searchText: filterKeyword.text, id: widget.id!),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            (isloading == true)
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
                        getDoctorBloc.add(GetDoctorListEvent());
                      },
                      child: ListView.separated(
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
                          final personCellEntity = personCellEntities?[index];
                          return SlideAbleForm(
                            isDoctorCell: true,
                            doctorBloc: getDoctorBloc,
                            personCellEntity: personCellEntity,
                          );
                        },
                      ),
                    ),
                  )
          ]),
    );
  }
}
