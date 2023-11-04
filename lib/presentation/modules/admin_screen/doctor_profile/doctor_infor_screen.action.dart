part of 'doctor_infor_screen.dart';

// ignore: library_private_types_in_public_api
extension DoctorInforScreenAction on _DoctorInforScreenState {
  void _blocListener(BuildContext context, GetDoctorState state) {
    if ((state is GetDoctorInforState &&
            state.status == BlocStatusState.loading) ||
        (state is ResetDoctorPasswordState &&
            state.status == BlocStatusState.loading)) {
      showToast(translation(context).loadingData);
    }
    if (state is GetDoctorInforState &&
        state.status == BlocStatusState.success) {
      showToast(translation(context).dataLoaded);
    }

    if (state is ResetDoctorPasswordState &&
        state.status == BlocStatusState.success) {
      showToast(translation(context).resetDoctorPasswordSuccessfully);
    }

    if ((state is GetDoctorInforState &&
            state.status == BlocStatusState.failure) ||
        (state is ResetDoctorPasswordState &&
            state.status == BlocStatusState.failure)) {
      showToast(translation(context).error);
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

  void showInfor(DoctorInforEntity patientInforEntity) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              translation(context).patientIn4,
              style: TextStyle(
                  color: AppColor.lineDecor,
                  fontSize: SizeConfig.screenWidth * 0.06,
                  fontWeight: FontWeight.bold),
            ),
            content: ListView(children: const []),
            actions: [
              TextButton(
                child: Text(translation(context).back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}


// ignore_for_file: public_member_api_docs, sort_constructors_first
