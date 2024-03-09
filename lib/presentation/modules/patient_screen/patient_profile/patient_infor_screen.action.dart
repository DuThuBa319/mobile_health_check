part of 'patient_infor_screen.dart';

// ignore: library_private_types_in_public_api
extension PatientInforScreenAction on _PatientInforScreenState {
  void _blocListener(BuildContext context, GetPatientState state) {
    //? Loading
    if (state.status == BlocStatusState.loading) {
      if (state is RemoveRelationshipRaPState) {
        showToast(
            context: context,
            status: ToastStatus.loading,
            toastString: translation(context).deletingRelative);
      }
    }
    //? Success
    if (state.status == BlocStatusState.success) {
      if (state is GetPatientInforState) {
        showToast(
            context: context,
            status: ToastStatus.success,
            toastString: translation(context).dataLoaded);
      }
      if (state is RemoveRelationshipRaPState) {
        showToast(
            context: context,
            status: ToastStatus.success,
            toastString: translation(context).deleteRelativeSuccessfully);
      }
    }
    //? Failure
    if (state.status == BlocStatusState.failure) {
      showToast(
          context: context,
          status: ToastStatus.error,
          toastString: translation(context).wifiDisconnect);
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
    context,
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
    return Center(
      child: Container(
        padding: EdgeInsets.only(
            bottom: SizeConfig.screenHeight * 0.005,
            top: SizeConfig.screenHeight * 0.005),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.03),
          boxShadow: const [
            BoxShadow(
              blurRadius: 15,
              color: Colors.black12,
            )
          ],
        ),
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenDiagonal < 1350
            ? SizeConfig.screenHeight * 0.15
            : SizeConfig.screenHeight * 0.18,
        margin: EdgeInsets.only(
          bottom: 10,
          left: SizeConfig.screenWidth * 0.03,
          right: SizeConfig.screenWidth * 0.03,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(),
            Container(
                padding: EdgeInsets.all(SizeConfig.screenWidth * 0.008),
                height: SizeConfig.screenDiagonal < 1350
                    ? SizeConfig.screenHeight * 0.125
                    : SizeConfig.screenHeight * 0.135,
                width: SizeConfig.screenDiagonal < 1350
                    ? SizeConfig.screenHeight * 0.125
                    : SizeConfig.screenHeight * 0.135,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 0.02),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fitWidth,
                )),
            Transform.translate(
              offset: Offset(
                  SizeConfig.screenDiagonal < 1350
                      ? SizeConfig.screenHeight * 0.005
                      : SizeConfig.screenHeight * 0.002,
                  SizeConfig.screenDiagonal < 1350
                      ? SizeConfig.screenHeight * 0.005
                      : SizeConfig.screenHeight * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.9 -
                        SizeConfig.screenHeight * 0.13,
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
                                  fontSize: SizeConfig.screenDiagonal < 1350
                                      ? SizeConfig.screenHeight * 0.017
                                      : SizeConfig.screenHeight * 0.022,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(
                              DateFormat('HH:mm dd/MM/yyyy')
                                  .format(dateTime ?? dateTime!),
                              style: AppTextTheme.title5.copyWith(
                                  fontSize: SizeConfig.screenHeight * 0.018),
                            ),
                          ],
                        ),
                        GestureDetector(
                          child: Container(
                            height: SizeConfig.screenDiagonal > 1350
                                ? SizeConfig.screenHeight * 0.032
                                : SizeConfig.screenHeight * 0.025,
                            width: SizeConfig.screenWidth * 0.17,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 205, 87),
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.screenWidth * 0.01)),
                            child: Center(
                              child: Text(translation(context).watchHistory,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextTheme.body5.copyWith(
                                      color: Colors.white,
                                      fontSize: SizeConfig.screenWidth * 0.03,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          onTap: () {
                            switch (navigate) {
                              case "bloodPressureHistory":
                                Navigator.pushNamed(
                                    context, RouteList.bloodPressureHistory,
                                    arguments: widget.patientId);
                                break;
                              case "bloodSugarHistory":
                                Navigator.pushNamed(
                                    context, RouteList.bloodSugarHistory,
                                    arguments: widget.patientId);
                                break;
                              case "oximeterHistory":
                                Navigator.pushNamed(
                                    context, RouteList.spo2History,
                                    arguments: widget.patientId);
                                break;
                              case "bodyTemperatureColor":
                                Navigator.pushNamed(
                                    context, RouteList.temperatureHistory,
                                    arguments: widget.patientId);
                                break;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  navigate == "bloodPressureHistory"
                      ? Expanded(
                          child: SizedBox(
                            width: SizeConfig.screenWidth * 0.9 -
                                SizeConfig.screenHeight * 0.13,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.end,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "SYS: ",
                                              style: AppTextTheme.title3
                                                  .copyWith(
                                                      fontSize: SizeConfig
                                                              .screenWidth *
                                                          0.05,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: bloodPressureEntity
                                                          ?.statusColor)),
                                          TextSpan(
                                              text:
                                                  "${bloodPressureEntity?.sys}",
                                              style: AppTextTheme.title3
                                                  .copyWith(
                                                      fontSize: SizeConfig
                                                              .screenWidth *
                                                          0.055,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: bloodPressureEntity
                                                          ?.statusColor)),
                                          TextSpan(
                                              text: " mmHg",
                                              style: AppTextTheme.title3
                                                  .copyWith(
                                                      color: const Color(
                                                          0xff615A5A),
                                                      fontSize: SizeConfig
                                                              .screenWidth *
                                                          0.04,
                                                      fontWeight:
                                                          FontWeight.w500))
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      textAlign: TextAlign.end,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "PUL: ",
                                              style: AppTextTheme.title3
                                                  .copyWith(
                                                      fontSize: SizeConfig
                                                              .screenWidth *
                                                          0.05,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: bloodPressureEntity
                                                          ?.statusColor)),
                                          TextSpan(
                                              text:
                                                  "${bloodPressureEntity?.pulse}",
                                              style: AppTextTheme.title3
                                                  .copyWith(
                                                      fontSize: SizeConfig
                                                              .screenWidth *
                                                          0.055,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: bloodPressureEntity
                                                          ?.statusColor)),
                                          TextSpan(
                                              text: " bpm",
                                              style: AppTextTheme.title3
                                                  .copyWith(
                                                      color: const Color(
                                                          0xff615A5A),
                                                      fontSize: SizeConfig
                                                              .screenWidth *
                                                          0.04,
                                                      fontWeight:
                                                          FontWeight.w500))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : navigate == "bloodSugarHistory"
                          ? Container(
                              width: SizeConfig.screenWidth * 0.9 -
                                  SizeConfig.screenHeight * 0.13,
                              margin: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.025,
                              ),
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
                                              style: AppTextTheme.title3
                                                  .copyWith(
                                                      color: bloodSugarEntity
                                                          ?.statusColor,
                                                      fontSize: SizeConfig
                                                              .screenDiagonal *
                                                          0.045,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                          TextSpan(
                                              text: " mg/dL",
                                              style: AppTextTheme.title3
                                                  .copyWith(
                                                      color: const Color(
                                                          0xff615A5A),
                                                      fontSize: SizeConfig
                                                              .screenDiagonal *
                                                          0.018,
                                                      fontWeight:
                                                          FontWeight.w500))
                                        ],
                                      ),
                                    )
                                  ]))
                          : navigate == "oximeterHistory"
                              ? Container(
                                  margin: EdgeInsets.only(
                                    top: SizeConfig.screenHeight * 0.02,
                                  ),
                                  width: SizeConfig.screenWidth * 0.9 -
                                      SizeConfig.screenHeight * 0.13,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                                                  .screenDiagonal *
                                                              0.048,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                              TextSpan(
                                                  text: " %",
                                                  style: AppTextTheme.title3
                                                      .copyWith(
                                                          color: const Color(
                                                              0xff615A5A),
                                                          fontSize: SizeConfig
                                                                  .screenDiagonal *
                                                              0.03,
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
                                  width: SizeConfig.screenWidth * 0.9 -
                                      SizeConfig.screenHeight * 0.13,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    "${temperatureEntity?.temperature}",
                                                style: AppTextTheme
                                                    .title3
                                                    .copyWith(
                                                        color:
                                                            temperatureEntity
                                                                ?.statusColor,
                                                        fontSize: SizeConfig
                                                                .screenDiagonal *
                                                            0.045,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                            TextSpan(
                                                text: "°",
                                                style: AppTextTheme.title3
                                                    .copyWith(
                                                        color:
                                                            const Color(
                                                                0xff615A5A),
                                                        fontSize: SizeConfig
                                                                .screenDiagonal *
                                                            0.045,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                            TextSpan(
                                                text: "C",
                                                style: AppTextTheme.title3
                                                    .copyWith(
                                                        color:
                                                            const Color(
                                                                0xff615A5A),
                                                        fontSize: SizeConfig
                                                                .screenDiagonal *
                                                            0.035,
                                                        fontWeight:
                                                            FontWeight.w500))
                                          ]))
                                    ],
                                  ),
                                )
                ],
              ),
            ),
            const SizedBox()
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
