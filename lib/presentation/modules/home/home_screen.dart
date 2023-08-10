import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:common_project/presentation/route/route_list.dart';
import 'package:common_project/presentation/theme/app_text_theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../common_widget/assets.dart';
import '../../theme/theme_color.dart';
part 'home_screen.action.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final sreenHeight = MediaQuery.of(context).size.height;
    final sreenWidth = MediaQuery.of(context).size.width;

    // RefreshController refreshController =
    //     RefreshController(initialRefresh: true);
    // Future<void> onRefresh() async {
    //   // monitor network fetch
    //   await Future.delayed(const Duration(milliseconds: 1000));
    //   // if failed,use refreshFailed()
    //   refreshController.refreshCompleted();
    // }
    return WillPopScope(
      onWillPop: _onWillPop,
      child: CustomScreenForm(
        title: 'Thông tin bệnh nhân',
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: true,
        isShowLeadingButton: true,
        appBarColor: AppColor.circleBackground,
        backgroundColor: AppColor.backgroundColor,
        rightButton: null,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  height: sreenHeight * 0.31,
                  width: sreenWidth,
                  decoration: BoxDecoration(
                    // color: const Color.fromARGB(255, 123, 211, 255),
                    gradient: const LinearGradient(
                      colors: [
                        AppColor.circleBackground,
                        AppColor.circleBackground,
                        // Colors.white, // Xanh nhạt nhất
                        // Xanh đậm nhất
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      // Thay đổi begin và end để điều chỉnh hướng chuyển đổi màu
                    ),
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 100)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: ClipOval(
                                    child: Image.asset(Assets.oldMan))),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Nguyễn Văn A',
                        style: AppTextTheme.body1.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('Ho Chi Minh city',
                          style: AppTextTheme.body3.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          infoText(title: 'Cân nặng', content: '72 kg'),
                          infoText(title: 'Tuổi', content: '67'),
                          infoText(title: 'Chiều cao', content: '176 cm'),
                        ],
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chỉ số cập nhật gần nhất',
                      style: AppTextTheme.body0
                          .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    lineDecor(),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  homeCell(
                      imagePath: Assets.bloodPressureMeter,
                      indicator: "Đo huyết áp",
                      color: AppColor.bloodPressureColor),
                  Positioned(
                    left: sreenWidth * 0.70,
                    child: GestureDetector(
                        child: historyLook(),
                        onTap: () => Navigator.pushReplacementNamed(
                            context, RouteList.bloodPressureHistory)),
                  ),
                ],
              ),
              Stack(
                children: [
                  homeCell(
                      imagePath: Assets.bodyTemperatureMeter,
                      indicator: "Đo thân nhiệt",
                      color: AppColor.bodyTemperatureColor),
                  Positioned(
                    left: sreenWidth * 0.70,
                    child: GestureDetector(
                        child: historyLook(),
                        onTap: () => Navigator.pushReplacementNamed(
                            context, RouteList.temperatureHistory)),
                  ),
                ],
              ),
              Stack(
                children: [
                  homeCell(
                      imagePath: Assets.bloodGlucoseMeter,
                      indicator: "Đo đường huyết",
                      color: AppColor.bloodGlucosColor),
                  Positioned(
                    left: sreenWidth * 0.70,
                    child: GestureDetector(
                        child: historyLook(),
                        onTap: () => Navigator.pushReplacementNamed(
                            context, RouteList.bloodSugarHistory)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
