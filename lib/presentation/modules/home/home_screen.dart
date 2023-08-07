import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';
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
        title: 'Home',
        isShowAppBar: true,
        isShowBottomNayvigationBar: true,
        isShowLeadingButton: true,
        appBarColor: AppColor.appBarColor,
        backgroundColor: AppColor.backgroundColor,
        leadingButton: const Icon(Icons.menu),
        selectedIndex: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.29,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  // color: const Color.fromARGB(255, 123, 211, 255),
                  gradient: const LinearGradient(
                    colors: [
                      AppColor.appBarColor,
                      Color(0xFFE6F7FF),
                      // Colors.white, // Xanh nhạt nhất
                      // Xanh đậm nhất
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // Thay đổi begin và end để điều chỉnh hướng chuyển đổi màu
                  ),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 100.0)),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: ClipOval(child: Image.asset(Assets.oldMan))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Trong Khang',
                        style: AppTextTheme.body2.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('Ho Chi Minh city',
                        style: AppTextTheme.body4.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        infoText(title: 'Weight', content: '72 kg'),
                        infoText(title: 'Age', content: '67'),
                        infoText(title: 'Height', content: '176 cm'),
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: 15),
            Padding(
                padding: const EdgeInsets.only(left: 12, top: 10),
                child: Text(
                  'Latest Readings',
                  style: AppTextTheme.body2
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                )),
            const SizedBox(height: 200),
            Padding(
                padding: const EdgeInsets.only(left: 12, top: 10),
                child: Text(
                  'Trends',
                  style: AppTextTheme.body2
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                )),
          ],
        ),
      ),
    );
  }

  Widget infoText({required String title, required String content}) {
    return Column(
      children: [
        Text(title,
            style: AppTextTheme.body5
                .copyWith(color: Colors.black, fontWeight: FontWeight.w400)),
        const SizedBox(height: 5),
        Text(content,
            style: AppTextTheme.body2
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
