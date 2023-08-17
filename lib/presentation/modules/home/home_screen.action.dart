part of 'home_screen.dart';

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

  Widget infoText({required String title, required String content}) {
    return Column(
      children: [
        Text(title,
            style: AppTextTheme.body4
                .copyWith(color: Colors.black, fontWeight: FontWeight.w400)),
        const SizedBox(height: 5),
        Text(content,
            style: AppTextTheme.body1
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget homeCell(
      {required String naviagte,
      required String imagePath,
      required String indicator,
      required Color color}) {
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
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    GestureDetector(
                      child: Text(translation(context).watchHistory,
                          style: AppTextTheme.body5.copyWith(
                              color: Colors.blue,
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1)),
                      onTap: () {
                        if (naviagte == "bloodPressureHistory") {
                          Navigator.pushNamed(
                              context, RouteList.bloodPressureHistory);
                        }
                        if (naviagte == "bloodSugarHistory") {
                          Navigator.pushNamed(
                              context, RouteList.bloodSugarHistory);
                        } else if (naviagte == "bodyTemperatureColor") {
                          Navigator.pushNamed(
                              context, RouteList.temperatureHistory);
                        }
                      },
                    ),
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
