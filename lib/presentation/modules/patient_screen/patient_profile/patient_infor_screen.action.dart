part of 'patient_infor_screen.dart';

// ignore: library_private_types_in_public_api
extension PatientInforScreenAction on _PatientInforScreenState {
  void _blocListener(BuildContext context, GetPatientState state) {
    if (state is GetPatientInforState &&
            state.status == BlocStatusState.loading ||
        state is ResetPasswordCustomerState &&
            state.status == BlocStatusState.loading) {
      showToast(translation(context).loadingData);
    }

    if (state is GetPatientInforState &&
        state.status == BlocStatusState.success) {
      showToast(translation(context).dataLoaded);
    }

    if (state is ResetPasswordCustomerState &&
        state.status == BlocStatusState.success) {
      showToast(translation(context).resetPatientPasswordSuccessfully);
    }

    if (state is GetPatientInforState &&
            state.status == BlocStatusState.failure ||
        state is ResetPasswordCustomerState &&
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
    Spo2Entity? spo2Entity,
    BloodPressureEntity? bloodPressureEntity,
    BloodSugarEntity? bloodSugarEntity,
    TemperatureEntity? temperatureEntity,
    DateTime? dateTime,
    required String navigate,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(indicator,
                            style: AppTextTheme.title3.copyWith(
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth * 0.032,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          DateFormat('HH:mm dd/MM/yyyy')
                              .format(dateTime ?? dateTime!),
                          style: AppTextTheme.title5.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.025),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Container(
                        height: SizeConfig.screenHeight * 0.025,
                        width: SizeConfig.screenWidth * 0.2,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 205, 87),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(translation(context).watchHistory,
                              style: AppTextTheme.body5.copyWith(
                                  color: Colors.white,
                                  fontSize: SizeConfig.screenWidth * 0.03,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                      onTap: () {
                        if (navigate == "bloodPressureHistory") {
                          Navigator.pushNamed(
                              context, RouteList.bloodPressureHistory,
                              arguments: widget.patientId);
                        }

                        if (navigate == "bloodSugarHistory") {
                          Navigator.pushNamed(
                              context, RouteList.bloodSugarHistory,
                              arguments: widget.patientId);
                        }
                        if (navigate == "oximeterHistory") {
                          Navigator.pushNamed(context, RouteList.spo2History,
                              arguments: widget.patientId);
                        } else if (navigate == "bodyTemperatureColor") {
                          Navigator.pushNamed(
                              context, RouteList.temperatureHistory,
                              arguments: widget.patientId);
                        }
                      },
                    ),
                  ],
                ),
              ),
              navigate == "bloodPressureHistory"
                  ? Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: SizeConfig.screenWidth * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: SizeConfig.screenWidth * 0.20),
                              RichText(
                                textAlign: TextAlign.end,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "SYS: ",
                                        style: AppTextTheme.title3.copyWith(
                                            fontSize:
                                                SizeConfig.screenWidth * 0.05,
                                            fontWeight: FontWeight.w500,
                                            color: bloodPressureEntity
                                                ?.statusColor)),
                                    TextSpan(
                                        text: "${bloodPressureEntity?.sys}",
                                        style: AppTextTheme.title3.copyWith(
                                            fontSize:
                                                SizeConfig.screenWidth * 0.075,
                                            fontWeight: FontWeight.w600,
                                            color: bloodPressureEntity
                                                ?.statusColor)),
                                    TextSpan(
                                        text: " mmHg",
                                        style: AppTextTheme.title3.copyWith(
                                            color: const Color(0xff615A5A),
                                            fontSize:
                                                SizeConfig.screenWidth * 0.04,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: SizeConfig.screenWidth * 0.20),
                              RichText(
                                textAlign: TextAlign.end,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "PUL: ",
                                        style: AppTextTheme.title3.copyWith(
                                            fontSize:
                                                SizeConfig.screenWidth * 0.05,
                                            fontWeight: FontWeight.w500,
                                            color: bloodPressureEntity
                                                ?.statusColor)),
                                    TextSpan(
                                        text: "${bloodPressureEntity?.pulse}",
                                        style: AppTextTheme.title3.copyWith(
                                            fontSize:
                                                SizeConfig.screenWidth * 0.075,
                                            fontWeight: FontWeight.w600,
                                            color: bloodPressureEntity
                                                ?.statusColor)),
                                    TextSpan(
                                        text: " bpm",
                                        style: AppTextTheme.title3.copyWith(
                                            color: const Color(0xff615A5A),
                                            fontSize:
                                                SizeConfig.screenWidth * 0.04,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : navigate == "bloodSugarHistory"
                      ? Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.025,
                          ),
                          width: SizeConfig.screenWidth * 0.6,
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
                      : navigate == "oximeterHistory"
                          ? Container(
                              margin: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.02,
                              ),
                              width: SizeConfig.screenWidth * 0.6,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.end,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "${spo2Entity?.spo2}",
                                              style: AppTextTheme.title3
                                                  .copyWith(
                                                      color: spo2Entity
                                                          ?.statusColor,
                                                      //     spo2Entity?.statusColor,
                                                      fontSize: SizeConfig
                                                              .screenWidth *
                                                          0.12,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                          TextSpan(
                                              text: " %",
                                              style: AppTextTheme.title3
                                                  .copyWith(
                                                      color: const Color(
                                                          0xff615A5A),
                                                      fontSize: SizeConfig
                                                              .screenWidth *
                                                          0.06,
                                                      fontWeight:
                                                          FontWeight.w500))
                                        ],
                                      ),
                                    )
                                  ]))
                          : Container(
                              margin: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.025,
                              ),
                              width: SizeConfig.screenWidth * 0.6,
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
                                                color: temperatureEntity
                                                    ?.statusColor,
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        0.1,
                                                fontWeight: FontWeight.w500)),
                                        TextSpan(
                                            text: "°",
                                            style: AppTextTheme.title3.copyWith(
                                                color: const Color(0xff615A5A),
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        0.1,
                                                fontWeight: FontWeight.w500)),
                                        TextSpan(
                                            text: "C",
                                            style: AppTextTheme.title3.copyWith(
                                                color: const Color(0xff615A5A),
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        0.08,
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
