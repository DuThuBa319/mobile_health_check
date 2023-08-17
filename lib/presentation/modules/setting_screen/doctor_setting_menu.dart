import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/image_picker_widget/custom_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/modules/setting_screen/widget_setting.dart';

import '../../../classes/language_constant.dart';
import '../../common_widget/common_button.dart';
import '../../common_widget/line_decor.dart';
import '../../route/route_list.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/theme_color.dart';

class SettingMenu extends StatefulWidget {
  const SettingMenu({super.key});

  @override
  State<SettingMenu> createState() => _SettingMenuState();
}

class _SettingMenuState extends State<SettingMenu> {
  @override
  Widget build(BuildContext context) {
    final sreenHeight = MediaQuery.of(context).size.height;
    final sreenWidth = MediaQuery.of(context).size.width;
    return CustomScreenForm(
        title: translation(context).setting,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: true,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.topGradient,
        leadingButton: IconButton(
            onPressed: () => Navigator.pushNamed(context, RouteList.userList),
            icon: const Icon(Icons.arrow_back)),
        selectedIndex: 2,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Center(
                    child: ImagePickerSingle(
                      imagePath: null,
                      isOnTapActive: true,
                      isforAvatar: true,
                    ),
                  ),
                  Center(
                      child: Text("Dr.Tên Bác Sĩ",
                          style: AppTextTheme.body0
                              .copyWith(fontWeight: FontWeight.bold))),
                  Center(
                      child: Text("+84 0395651845", style: AppTextTheme.body3)),
                  const SizedBox(height: 50),
                  lineDecor(),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, RouteList.settingDrPassword),
                    child: settingMenuCell(translation(context).updatePassword,
                        sreenHeight * 0.1, sreenWidth * 0.9),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, RouteList.settingDrPhone),
                    child: settingMenuCell(
                        translation(context).updatePhoneNumber,
                        sreenHeight * 0.1,
                        sreenWidth * 0.9),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, RouteList.settingLanguage),
                    child: settingMenuCell(translation(context).language,
                        sreenHeight * 0.1, sreenWidth * 0.9),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: CommonButton(
                        height: sreenHeight * 0.07,
                        title: translation(context).logOut,
                        buttonColor: AppColor.saveSetting,
                        onTap: null),
                  )
                ]),
          ),
        ));
  }
}
