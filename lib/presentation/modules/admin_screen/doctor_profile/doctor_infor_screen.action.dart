part of 'doctor_infor_screen.dart';

// ignore: library_private_types_in_public_api
extension DoctorInforScreenAction on _DoctorInforScreenState {
  void _blocListener(BuildContext context, GetDoctorState state) {
    //? Loading
    if (state.status == BlocStatusState.loading) {
      if (state is GetDoctorInforState) {
        showToast(translation(context).loadingData);
      }
    }
    //? Success
    if (state.status == BlocStatusState.success) {
      if (state is GetDoctorInforState) {
        showToast(translation(context).dataLoaded);
      }
    }
    //? Failure
    if (state.status == BlocStatusState.failure) {
      showToast(translation(context).error);
      showExceptionDialog(
          context: context,
          message: state.viewModel.errorMessage!,
          titleBtn: translation(context).exit);
    }
  }

  Widget infoText({required String? title, required String? content}) {
    return Column(
      children: [
        Text(title ?? "--",
            style: AppTextTheme.body4
                .copyWith(color: Colors.black, fontWeight: FontWeight.w400)),
        const SizedBox(height: 5),
        Text(content ?? "--",
            style: AppTextTheme.body1
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500)),
      ],
    );
  }

  // void showInfor(DoctorInforEntity patientInforEntity) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text(
  //             translation(context).patientIn4,
  //             style: TextStyle(
  //                 color: AppColor.lineDecor,
  //                 fontSize: SizeConfig.screenWidth * 0.06,
  //                 fontWeight: FontWeight.bold),
  //           ),
  //           content: ListView(children: const []),
  //           actions: [
  //             TextButton(
  //               child: Text(translation(context).back),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }
}


// ignore_for_file: public_member_api_docs, sort_constructors_first
