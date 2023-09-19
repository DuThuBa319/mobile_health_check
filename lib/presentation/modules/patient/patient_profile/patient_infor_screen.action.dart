part of 'patient_infor_screen.dart';

// ignore: library_private_types_in_public_api
extension PatientInforScreenAction on _PatientInforScreenState {
 void _blocListener(BuildContext context, GetPatientState state) {
    // logger.d('change state', state);
    // _refreshController
    //   ..refreshCompleted()
    //   ..loadComplete();
    if (state is GetPatientInforState &&
        state.status == BlocStatusState.loading) {
      showToast(translation(context).loadingData);
    }
    if (state is GetPatientInforState &&
        state.status == BlocStatusState.success) {
      showToast(translation(context).dataLoaded);
    }
    if (state is GetPatientInforState &&
        state.status == BlocStatusState.failure) {
      showToast(translation(context).loadingError);
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

  Widget homeCell({
    BloodPressureEntity? bloodPressureEntity,
    BloodSugarEntity? bloodSugarEntity,
    TemperatureEntity? temperatureEntity,
    DateTime? dateTime,
    required String naviagte,
    required String imagePath,
    required String indicator,
    required Color color,
    int? sys,
    int? dia,
    double? bloodSugar,
    double? bodyTemperature,
    int? pulse,
  }) {
    SizeConfig.init(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.05),
        boxShadow: const [
          BoxShadow(
            blurRadius: 15,
            color: Colors.black12,
          )
        ],
      ),
      height: SizeConfig.screenHeight * 0.15,
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.fromLTRB(SizeConfig.screenWidth * 0.04, 0, 12, 10),
      padding: const EdgeInsets.only(top: 10, left: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              height: SizeConfig.screenWidth * 0.25,
              width: SizeConfig.screenWidth * 0.25,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.fitWidth,
              )),
          const SizedBox(
            width: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: SizeConfig.screenWidth * 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(indicator,
                        style: AppTextTheme.title3.copyWith(
                          color: Colors.black,
                          fontSize: SizeConfig.screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                        )),
                    GestureDetector(
                      child: SizedBox(
                        width: SizeConfig.screenWidth * 0.25,
                        height: SizeConfig.screenWidth * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(translation(context).watchHistory,
                                style: AppTextTheme.body5.copyWith(
                                  color: Colors.blue,
                                  fontSize: SizeConfig.screenWidth * 0.03,
                                  decoration: TextDecoration.underline,
                                )),
                          ],
                        ),
                      ),
                      onTap: () {
                        if (naviagte == "bloodPressureHistory") {
                          Navigator.pushNamed(
                              context, RouteList.bloodPressureHistory,
                              arguments: widget.patientId ?? widget.patientId!);
                        }

                        if (naviagte == "bloodSugarHistory") {
                          Navigator.pushNamed(
                              context, RouteList.bloodSugarHistory,
                              arguments: widget.patientId ?? widget.patientId!);
                        } else if (naviagte == "bodyTemperatureColor") {
                          Navigator.pushNamed(
                              context, RouteList.temperatureHistory,
                              arguments: widget.patientId ?? widget.patientId!);
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                DateFormat('HH:mm dd/MM/yyyy').format(dateTime ?? dateTime!),
                style: AppTextTheme.title5
                    .copyWith(fontSize: SizeConfig.screenWidth * 0.025),
              ),
              const SizedBox(
                height: 8,
              ),
              naviagte == "bloodPressureHistory"
                  ? Container(
                      margin: EdgeInsets.only(
                          top: 5, left: SizeConfig.screenWidth * 0.1),
                      width: SizeConfig.screenWidth * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  "${bloodPressureEntity?.sys}/${bloodPressureEntity?.dia}",
                                  style: AppTextTheme.title3.copyWith(
                                      fontSize: SizeConfig.screenWidth * 0.1,
                                      fontWeight: FontWeight.w500,
                                      color: bloodPressureEntity?.statusColor)),
                              Text("mmHg",
                                  style: AppTextTheme.title3.copyWith(
                                      color: const Color(0xff615A5A),
                                      fontSize: SizeConfig.screenWidth * 0.04,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.05,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${bloodPressureEntity?.pulse}",
                                  style: AppTextTheme.title3.copyWith(
                                      color: bloodPressureEntity?.statusColor,
                                      fontSize: SizeConfig.screenWidth * 0.06,
                                      fontWeight: FontWeight.w500)),
                              Text("bpm",
                                  style: AppTextTheme.title3.copyWith(
                                      color: const Color(0xff615A5A),
                                      fontSize: SizeConfig.screenWidth * 0.04,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                        ],
                      ),
                    )
                  : naviagte == "bloodSugarHistory"
                      ? Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.screenWidth * 0.0,
                              left: SizeConfig.screenWidth * 0.1),
                          width: SizeConfig.screenWidth * 0.5,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text:
                                              "${bloodSugarEntity?.bloodSugar}",
                                          style: AppTextTheme.title3.copyWith(
                                              color:
                                                  bloodSugarEntity?.statusColor,
                                              fontSize:
                                                  SizeConfig.screenWidth * 0.1,
                                              fontWeight: FontWeight.w500)),
                                      TextSpan(
                                          text: " mg/dL",
                                          style: AppTextTheme.title3.copyWith(
                                              color: const Color(0xff615A5A),
                                              fontSize:
                                                  SizeConfig.screenWidth * 0.04,
                                              fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                )
                              ]))
                      : Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.screenWidth * 0.0,
                              left: SizeConfig.screenWidth * 0.1),
                          width: SizeConfig.screenWidth * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text:
                                            "${temperatureEntity?.temperature}",
                                        style: AppTextTheme.title3.copyWith(
                                            color:
                                                temperatureEntity?.statusColor,
                                            fontSize:
                                                SizeConfig.screenWidth * 0.1,
                                            fontWeight: FontWeight.w500)),
                                    TextSpan(
                                        text: "°",
                                        style: AppTextTheme.title3.copyWith(
                                            color: const Color(0xff615A5A),
                                            fontSize:
                                                SizeConfig.screenWidth * 0.1,
                                            fontWeight: FontWeight.w500)),
                                    TextSpan(
                                        text: "C",
                                        style: AppTextTheme.title3.copyWith(
                                            color: const Color(0xff615A5A),
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500))
                                  ]))
                            ],
                          ),
                        )
            ],
          ),
          const SizedBox(height: 2)
        ],
      ),
    );
  }
}



// ignore_for_file: public_member_api_docs, sort_constructors_first



