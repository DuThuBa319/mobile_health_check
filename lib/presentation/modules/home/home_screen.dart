import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/image_picker_widget/custom_image_picker.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../common_widget/assets.dart';
import '../../route/route_list.dart';
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
        appBarColor: const Color(0xff7BD4FF),
        backgroundColor: AppColor.backgroundColor,
        leadingButton: IconButton(
            onPressed: () => Navigator.pushNamed(context, RouteList.userList),
            icon: const Icon(Icons.arrow_back)),
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
                        Color(0xff7BD4FF),
                        AppColor.backgroundColor,

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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                        child: ImagePickerSingle(
                          isOnTapActive: true,
                          isforAvatar: true,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
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
                      indicator: "ĐO HUYẾT ÁP",
                      color: AppColor.bloodPressureEquip),
                  Positioned(
                    left: sreenWidth * 0.73,
                    top: sreenHeight * 0.01,
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
                      indicator: "ĐO THÂN NHIỆT",
                      color: AppColor.bodyTemperatureColor),
                  Positioned(
                    left: sreenWidth * 0.73,
                    top: sreenHeight * 0.01,
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
                      indicator: "ĐO ĐƯỜNG HUYẾT",
                      color: AppColor .bloodGlucosColor),
                  Positioned(
                    left: sreenWidth * 0.73,
                    top: sreenHeight * 0.01,
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
