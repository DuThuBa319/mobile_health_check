part of 'patient_infor_screen.dart';

// ignore: library_private_types_in_public_api
extension PatientInforScreenAction on _PatientInforScreenState {
  void _blocListener(BuildContext context, GetPatientState state) {
    //? Loading
    if (state.status == BlocStatusState.loading) {
      if (state is GetPatientInforState) {
        showToast(translation(context).loadingData);
      }
      if (state is RemoveRelationshipRaPState) {
        showToast(translation(context).deletingRelative);
      }
    }
    //? Success
    if (state.status == BlocStatusState.success) {
      if (state is GetPatientInforState) {
        showToast(translation(context).dataLoaded);
      }
      if (state is RemoveRelationshipRaPState) {
        showToast(translation(context).deleteRelativeSuccessfully);
      }
    }
    //? Failure
    if (state.status == BlocStatusState.failure) {
      showToast(translation(context).loadingError);
      if (state.viewModel.isWifiDisconnect == true) {
        showExceptionDialog(
            context: context,
            message: translation(context).wifiDisconnect,
            titleBtn: translation(context).exit);
      } else {
        showExceptionDialog(
            context: context,
            message: state.viewModel.errorMessage!,
            titleBtn: translation(context).exit);
      }
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
        width: SizeConfig.screenWidth * 0.92,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(top: 10, left: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(5),
                height: SizeConfig.screenHeight * 0.12,
                width: SizeConfig.screenHeight * 0.12,
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
                                fontSize: SizeConfig.screenDiagonal * 0.014,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                            DateFormat('HH:mm dd/MM/yyyy')
                                .format(dateTime ?? dateTime!),
                            style: AppTextTheme.title5.copyWith(
                              fontSize: SizeConfig.screenDiagonal * 0.013,
                            ),
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
                                    fontSize: SizeConfig.screenDiagonal * 0.013,
                                    fontWeight: FontWeight.w600)),
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
                    ? Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: SizeConfig.screenWidth * 0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: SizeConfig.screenWidth * 0.22),
                                RichText(
                                  textAlign: TextAlign.end,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "SYS: ",
                                          style: AppTextTheme.title3.copyWith(
                                              fontSize:
                                                  SizeConfig.screenDiagonal *
                                                      0.022,
                                              fontWeight: FontWeight.w500,
                                              color: bloodPressureEntity
                                                  ?.statusColor)),
                                      TextSpan(
                                          text: "${bloodPressureEntity?.sys}",
                                          style: AppTextTheme.title3.copyWith(
                                              fontSize:
                                                  SizeConfig.screenDiagonal *
                                                      0.025,
                                              fontWeight: FontWeight.w600,
                                              color: bloodPressureEntity
                                                  ?.statusColor)),
                                      TextSpan(
                                          text: " mmHg",
                                          style: AppTextTheme.title3.copyWith(
                                              color: const Color(0xff615A5A),
                                              fontSize:
                                                  SizeConfig.screenDiagonal *
                                                      0.018,
                                              fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: SizeConfig.screenWidth * 0.22),
                                RichText(
                                  textAlign: TextAlign.end,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "PUL: ",
                                          style: AppTextTheme.title3.copyWith(
                                              fontSize:
                                                  SizeConfig.screenDiagonal *
                                                      0.022,
                                              fontWeight: FontWeight.w500,
                                              color: bloodPressureEntity
                                                  ?.statusColor)),
                                      TextSpan(
                                          text: "${bloodPressureEntity?.pulse}",
                                          style: AppTextTheme.title3.copyWith(
                                              fontSize:
                                                  SizeConfig.screenDiagonal *
                                                      0.0225,
                                              fontWeight: FontWeight.w600,
                                              color: bloodPressureEntity
                                                  ?.statusColor)),
                                      TextSpan(
                                          text: " bpm",
                                          style: AppTextTheme.title3.copyWith(
                                              color: const Color(0xff615A5A),
                                              fontSize:
                                                  SizeConfig.screenDiagonal *
                                                      0.018,
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
                                                color: bloodSugarEntity
                                                    ?.statusColor,
                                                fontSize:
                                                    SizeConfig.screenDiagonal *
                                                        0.045,
                                                fontWeight: FontWeight.w500)),
                                        TextSpan(
                                            text: " mg/dL",
                                            style: AppTextTheme.title3.copyWith(
                                                color: const Color(0xff615A5A),
                                                fontSize:
                                                    SizeConfig.screenDiagonal *
                                                        0.018,
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
                                                                .screenDiagonal *
                                                            0.048,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                            TextSpan(
                                                text: " %",
                                                style: AppTextTheme.title3
                                                    .copyWith(
                                                        color:
                                                            const Color(
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
                                              style: AppTextTheme.title3
                                                  .copyWith(
                                                      color: temperatureEntity
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
                                                      color: const Color(
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
                                                      color: const Color(
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
            const SizedBox()
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
