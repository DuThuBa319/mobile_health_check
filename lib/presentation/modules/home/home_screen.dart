import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/image_picker_widget/custom_image_picker.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../../classes/language_constant.dart';
import '../../common_widget/assets.dart';
import '../../common_widget/line_decor.dart';
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
        title: translation(context).patientIn4,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: true,
        isShowLeadingButton: true,
        appBarColor: const Color(0xff7BD4FF),
        backgroundColor: AppColor.cardBackground,
        leadingButton: IconButton(
            onPressed: () => Navigator.pushNamed(context, RouteList.userList),
            icon: const Icon(Icons.arrow_back)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: sreenHeight * 0.32,
                  width: sreenWidth,
                  decoration: BoxDecoration(
                    // color: const Color.fromARGB(255, 123, 211, 255),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff7BD4FF),
                        Color(0xffDBF3FF),

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
                          imagePath: null,
                          isOnTapActive: true,
                          isforAvatar: true,
                        ),
                      ),
                      SizedBox(
                        height: sreenHeight * 0.02,
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
                      SizedBox(
                        height: sreenHeight * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          infoText(
                              title: translation(context).weight,
                              content: '72 kg'),
                          infoText(
                              title: translation(context).age, content: '67'),
                          infoText(
                              title: translation(context).height,
                              content: '176 cm'),
                        ],
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translation(context).lastUpdate,
                      style: AppTextTheme.body0
                          .copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    lineDecor(),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  homeCell(
                      naviagte: "bloodPressureHistory",
                      imagePath: Assets.bloodPressureMeter,
                      indicator: translation(context).bloodPressure,
                      color: AppColor.bloodPressureEquip),
                  homeCell(
                      naviagte: "bodyTemperatureColor",
                      imagePath: Assets.bodyTemperatureMeter,
                      indicator: translation(context).bodyTemperature,
                      color: AppColor.bodyTemperatureColor),
                  homeCell(
                      naviagte: "bloodSugarHistory",
                      imagePath: Assets.bloodGlucoseMeter,
                      indicator: translation(context).bloodSugar,
                      color: AppColor.bloodGlucosColor),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
