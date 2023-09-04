import 'package:mobile_health_check/presentation/common_widget/dialog/show_toast.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:flutter/material.dart';

import '../../../classes/language.dart';
import '../../../classes/language_constant.dart';
import '../../../main.dart';
import '../../common_widget/common_button.dart';
import '../../common_widget/line_decor.dart';
import '../../route/route_list.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/theme_color.dart';

class SettingLanguage extends StatefulWidget {
  const SettingLanguage({super.key});

  @override
  State<SettingLanguage> createState() => _SettingLanguageState();
}

class _SettingLanguageState extends State<SettingLanguage> {
  bool select1 = false;
  bool select2 = false;

  @override
  Widget build(BuildContext context) {
    final sreenHeight = MediaQuery.of(context).size.height;
    final sreenWidth = MediaQuery.of(context).size.width;
    Language? selectedLanguage;
    return CustomScreenForm(
        title: translation(context).setting,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: false,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.backgroundColor,
        leadingButton: IconButton(
            onPressed: () => Navigator.pushNamed(context, RouteList.setting),
            icon: const Icon(Icons.arrow_back)),
        selectedIndex: 2,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                top: sreenHeight * 0.05, left: sreenWidth * 0.05),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.language_outlined, size: 40),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(translation(context).selectLanguage,
                          style: AppTextTheme.body0.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 32)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  lineDecor(),
                  SizedBox(height: sreenHeight * 0.01),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 15),
                          margin: const EdgeInsets.only(top: 15, bottom: 15),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: sreenHeight * 0.1,
                          width: sreenWidth * 0.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(Language.languageList()[0].name,
                                  style: AppTextTheme.body1.copyWith()),
                              GestureDetector(
                                  child: Container(
                                    height: sreenHeight * 0.05,
                                    width: sreenHeight * 0.05,
                                    decoration: BoxDecoration(
                                      color: select1 == false
                                          ? Colors.white
                                          : Colors.blue,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 3,
                                          color: select1 == false
                                              ? AppColor.topGradient
                                              : AppColor.backgroundColor),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      select1 = true;
                                      select2 = false;
                                    });
                                  }),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 15),
                          margin: const EdgeInsets.only(top: 15, bottom: 15),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: sreenHeight * 0.1,
                          width: sreenWidth * 0.7,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(Language.languageList()[1].name,
                                    style: AppTextTheme.body1.copyWith()),
                                GestureDetector(
                                    child: Container(
                                      height: sreenHeight * 0.05,
                                      width: sreenHeight * 0.05,
                                      decoration: BoxDecoration(
                                        color: select2 == false
                                            ? Colors.white
                                            : Colors.blue,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 3,
                                            color: select2 == false
                                                ? AppColor.topGradient
                                                : AppColor.backgroundColor),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        select2 = true;
                                        select1 = false;
                                      });
                                    })
                              ]),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: CommonButton(
                      height: sreenHeight * 0.07,
                      width: sreenWidth * 0.7,
                      title: translation(context).save,
                      buttonColor: AppColor.saveSetting,
                      onTap: () async {
                        if (select1 == true && select2 == false) {
                          selectedLanguage = Language(1, ENGLISH, 'en');
                          Locale locale =
                              await setLocale(selectedLanguage!.languageCode);
                          // ignore: use_build_context_synchronously
                          MyApp.setLocale(context, locale);
                          showToast("Change language successfully");
                          Navigator.pushNamed(context, RouteList.setting);
                        } else if (select2 == true && select1 == false) {
                          selectedLanguage = Language(2, VIETNAMESE, 'vi');
                          Locale locale =
                              await setLocale(selectedLanguage!.languageCode);
                          // ignore: use_build_context_synchronously
                          MyApp.setLocale(context, locale);
                          showToast("Đổi ngôn ngữ thành công");

                          Navigator.pushNamed(context, RouteList.setting);
                        }
                      },
                    ),
                  )
                ]),
          ),
        ));
  }
}
