import 'package:mobile_health_check/presentation/common_widget/dialog/show_toast.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/modules/setting_screen/widget_setting.dart';

import '../../../classes/language_constant.dart';
import '../../common_widget/common_button.dart';
import '../../common_widget/line_decor.dart';
import '../../route/route_list.dart';
import '../../theme/theme_color.dart';

class SettingDrPhone extends StatefulWidget {
  const SettingDrPhone({super.key});

  @override
  State<SettingDrPhone> createState() => _SettingDrPhoneState();
}

class _SettingDrPhoneState extends State<SettingDrPhone> {
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
            onPressed: () => Navigator.pushNamed(context, RouteList.setting),
            icon: const Icon(Icons.arrow_back)),
        selectedIndex: 2,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: sreenHeight * 0.08),
                  lineDecor(),
                  settingPhoneCell(translation(context).oldPhoneNumber,
                      sreenHeight * 0.1, sreenWidth * 0.9),
                  settingPhoneCell(
                    translation(context).newPhoneNumber,
                    sreenHeight * 0.1,
                    sreenWidth * 0.9,
                  ),
                  SizedBox(height: sreenHeight * 0.01),
                  Center(
                    child: CommonButton(
                        height: sreenHeight * 0.07,
                        title: translation(context).save,
                        buttonColor: AppColor.saveSetting,
                        onTap: () {
                          showToast("Save PhoneNumber Successfully");
                        }),
                  )
                ]),
          ),
        ));
  }
}
