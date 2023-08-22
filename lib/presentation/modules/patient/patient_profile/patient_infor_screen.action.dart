part of 'patient_infor_screen.dart';

extension HomeAction on _HomeScreenState {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                // <-- SEE HERE
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
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
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 15,
            color: Colors.black12,
          )
        ],
      ),
      height: screenSize.height * 0.15,
      width: screenSize.width,
      margin: const EdgeInsets.fromLTRB(15, 0, 12, 10),
      padding: const EdgeInsets.only(top: 10, left: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              height: screenSize.width * 0.25,
              width: screenSize.width * 0.25,
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
                width: screenSize.width * 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(indicator,
                        style: AppTextTheme.title3.copyWith(
                            color: Colors.black,
                            fontSize: screenSize.width * 0.035,
                            fontWeight: FontWeight.bold)),
                    GestureDetector(
                      child: Text(translation(context).watchHistory,
                          style: AppTextTheme.body5.copyWith(
                              color: Colors.blue,
                              fontSize: screenSize.width * 0.03,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1)),
                      onTap: () {
                        if (naviagte == "bloodPressureHistory") {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return BlocProvider<HistoryBloc>(
                                create: (context) => getIt<HistoryBloc>(),
                                child: BloodPressureHistoryScreen(
                                  id: widget.id ?? widget.id!,
                                ));
                          }));
                        }

                        if (naviagte == "bloodSugarHistory") {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return BlocProvider<HistoryBloc>(
                                create: (context) => getIt<HistoryBloc>(),
                                child: BloodSugarHistoryScreen(
                                  id: widget.id ?? widget.id!,
                                ));
                          }));
                        } else if (naviagte == "bodyTemperatureColor") {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return BlocProvider<HistoryBloc>(
                                create: (context) => getIt<HistoryBloc>(),
                                child: TemperatureHistoryScreen(
                                  id: widget.id ?? widget.id!,
                                ));
                          }));
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
                    .copyWith(fontSize: screenSize.width * 0.025),
              ),
              const SizedBox(
                height: 8,
              ),
              naviagte == "bloodPressureHistory"
                  ? Container(
                      margin:
                          EdgeInsets.only(top: 5, left: screenSize.width * 0.1),
                      width: screenSize.width * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("$sys/$dia",
                                  style: AppTextTheme.title3.copyWith(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w500)),
                              Text("mmHg",
                                  style: AppTextTheme.title3.copyWith(
                                      color: const Color(0xff615A5A),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                          SizedBox(
                            width: screenSize.width * 0.05,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("$pulse",
                                  style: AppTextTheme.title3.copyWith(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500)),
                              Text("bpm",
                                  style: AppTextTheme.title3.copyWith(
                                      color: const Color(0xff615A5A),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                        ],
                      ),
                    )
                  : naviagte == "bloodSugarHistory"
                      ? Container(
                          margin: EdgeInsets.only(
                              top: 20, left: screenSize.width * 0.1),
                          width: screenSize.width * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("$bloodSugar",
                                  style: AppTextTheme.title3.copyWith(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w500)),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, left: 5),
                                child: Text("mg/dL",
                                    style: AppTextTheme.title3.copyWith(
                                        color: const Color(0xff615A5A),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                              )
                            ],
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(
                              top: 20, left: screenSize.width * 0.1),
                          width: screenSize.width * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("$bodyTemperature",
                                  style: AppTextTheme.title3.copyWith(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w500)),
                              Text("°",
                                  style: AppTextTheme.title3.copyWith(
                                      color: const Color(0xff615A5A),
                                      fontSize: 35,
                                      fontWeight: FontWeight.w500)),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text("C",
                                    style: AppTextTheme.title3.copyWith(
                                        color: const Color(0xff615A5A),
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500)),
                              )
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



