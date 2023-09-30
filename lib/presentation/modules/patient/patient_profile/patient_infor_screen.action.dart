part of 'patient_infor_screen.dart';

// ignore: library_private_types_in_public_api
extension PatientInforScreenAction on _PatientInforScreenState {
  void _blocListener(BuildContext context, GetPatientState state) {
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
    if (state is RegistRelativeState &&
        state.status == BlocStatusState.loading) {
      showToast(translation(context).waitForSeconds);
    }
    if (state is RegistRelativeState &&
        state.status == BlocStatusState.success) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                translation(context).notification,
                style: TextStyle(
                    color: AppColor.lineDecor,
                    fontSize: SizeConfig.screenWidth * 0.08,
                    fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                height: SizeConfig.screenHeight * 0.15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${translation(context).addRelativeSuccessfully}!",
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: SizeConfig.screenWidth * 0.04,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: SizeConfig.screenWidth * 0.05),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: '${translation(context).account}: ',
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: SizeConfig.screenWidth * 0.05,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: state.viewModel.userName ?? "--",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.screenWidth * 0.05),
                          )
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: '${translation(context).password}: ',
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: SizeConfig.screenWidth * 0.05,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: state.viewModel.password ?? "--",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.screenWidth * 0.05),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text(translation(context).accept),
                  onPressed: () {
                    //Navigator.pop(context);
                    Navigator.pushNamed(context, RouteList.patientInfor,
                        arguments: state.viewModel.patientInforEntity?.id);
                  },
                ),
              ],
            );
          });
    }
  }

  void showInfor(PatientInforEntity patientInforEntity) {
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
            content: ListView(children: [
              in4Cell(
                  "${translation(context).name}: ", patientInforEntity.name),
              in4Cell("${translation(context).phoneNumber}: ",
                  patientInforEntity.phoneNumber),
              in4Cell(
                  "${translation(context).age}: ",
                  (patientInforEntity.age == 0)
                      ? translation(context).notUpdate
                      : "${patientInforEntity.age}"),
              in4Cell(
                "${translation(context).gender}: ",
                patientInforEntity.gender == false ? "Nam" : "nữ",
              ),
              in4Cell(
                  "${translation(context).height}: ",
                  (patientInforEntity.height?.toInt() == 0)
                      ? "${translation(context).notUpdate} (cm)"
                      : "${patientInforEntity.height?.toInt()} (cm)"),
              in4Cell(
                  "${translation(context).weight}: ",
                  (patientInforEntity.weight?.toInt() == 0)
                      ? "${translation(context).notUpdate} (kg)"
                      : "${patientInforEntity.weight?.toInt()} (kg)"),
              in4Cell("${translation(context).address}: ",
                  "${patientInforEntity.address}"),
            ]),
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

  Widget in4Cell(String titile, String text) {
    return Container(
        margin: EdgeInsets.only(top: SizeConfig.screenWidth * 0.03),
        padding: EdgeInsets.only(
            top: SizeConfig.screenWidth * 0.03,
            left: SizeConfig.screenWidth * 0.02),
        height: SizeConfig.screenHeight * 0.13,
        decoration: BoxDecoration(
          color: AppColor.cardBackground,
          borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.035),
        ),
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                  text: titile,
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: SizeConfig.screenWidth * 0.06,
                      fontWeight: FontWeight.w500)),
              TextSpan(
                text: text,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.screenWidth * 0.05),
              )
            ],
          ),
        ));
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
                        if (naviagte == "bloodPressureHistory") {
                          Navigator.pushNamed(
                              context, RouteList.bloodPressureHistory,
                              arguments: widget.patientId ?? widget.patientId!);
                        }

                        if (naviagte == "bloodSugarHistory") {
                          Navigator.pushNamed(
                              context, RouteList.bloodSugarHistory,
                              arguments: widget.patientId ?? widget.patientId!);
                        }
                        if (naviagte == "oximeterHistory") {
                          Navigator.pushNamed(context, RouteList.spo2History,
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
              naviagte == "bloodPressureHistory"
                  ? Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: SizeConfig.screenWidth * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Text("SYS: ",
                                  style: AppTextTheme.title3.copyWith(
                                      fontSize: SizeConfig.screenWidth * 0.065,
                                      fontWeight: FontWeight.w500,
                                      color: bloodPressureEntity?.statusColor)),
                              Text("PUL: ",
                                  style: AppTextTheme.title3.copyWith(
                                      fontSize: SizeConfig.screenWidth * 0.065,
                                      fontWeight: FontWeight.w500,
                                      color: bloodPressureEntity?.statusColor)),
                            ],
                          ),
                          Column(
                            children: [
                              RichText(
                                textAlign: TextAlign.end,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "${bloodPressureEntity?.sys}",
                                        style: AppTextTheme.title3.copyWith(
                                            fontSize:
                                                SizeConfig.screenWidth * 0.065,
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
                              RichText(
                                textAlign: TextAlign.end,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "${bloodPressureEntity?.pulse}",
                                        style: AppTextTheme.title3.copyWith(
                                            fontSize:
                                                SizeConfig.screenWidth * 0.065,
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
                  : naviagte == "bloodSugarHistory"
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
                      : naviagte == "oximeterHistory"
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
                                                      color: AppColor.oximeter,
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



