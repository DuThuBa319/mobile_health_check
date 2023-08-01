import 'package:common_project/presentation/common_widget/common_button.dart';
import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../common_widget/image_picker/image_picker_bloc/image_picker_bloc.dart';
import '../../route/route_list.dart';
import '../../theme/theme_color.dart';
import '../OCR_scanner/OCR_scanner_screen.dart';
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonButton(
                  title: 'Shopping Cart',
                  height: 80,
                  onTap: goToShoppingScreen,
                ),
                CommonButton(
                    title: 'User List',
                    height: 80,
                    buttonColor: Colors.amber,
                    onTap: goToUserList),
                CommonButton(
                  title: 'Daily Weather',
                  height: 80,
                  buttonColor: Colors.orange,
                  onTap: goToDailyWeatherScreen,
                ),
                CommonButton(
                  title: 'Hourly Temperature',
                  height: 80,
                  buttonColor: Colors.red,
                  onTap: goToHourlyTemperatureScreen,
                )
              ],
            ),
          )),
    );
  }
}
