// ignore_for_file: use_build_context_synchronously

import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:flutter/material.dart';

import '../../../classes/language.dart';
import '../../../classes/language_constant.dart';
import '../../../common/singletons.dart';
import '../../../function.dart';
import '../../../main.dart';
import '../../common_widget/rectangle_button.dart';
import '../../common_widget/line_decor.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/theme_color.dart';

class SettingLanguage extends StatefulWidget {
  const SettingLanguage({super.key});

  @override
  State<SettingLanguage> createState() => _SettingLanguageState();
}

class _SettingLanguageState extends State<SettingLanguage> {
  bool selectEn = false;
  bool selectVn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (notificationData.localeId == 1) {
      setState(() {
        selectEn = true;
        selectVn = false;
      });
    } else if (notificationData.localeId == 2) {
      setState(() {
        selectEn = false;
        selectVn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    Language? selectedLanguage;
    return CustomScreenForm(
        title: translation(context).setting,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: false,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.backgroundColor,
        selectedIndex: 2,
        isScrollable: true,
        child: Container(
          margin: EdgeInsets.only(
              top: SizeConfig.screenHeight * 0.05,
              left: SizeConfig.screenWidth * 0.05),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.language_outlined,
                        size: SizeConfig.screenWidth * 0.12),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(translation(context).selectLanguage,
                        style: AppTextTheme.body0.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.screenWidth * 0.08)),
                  ],
                ),
                lineDecor(
                    spaceTop: SizeConfig.screenHeight * 0.02,
                    spaceBottom: SizeConfig.screenHeight * 0.01),
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.05,
                            right: SizeConfig.screenWidth * 0.04),
                        margin: EdgeInsets.only(
                            top: SizeConfig.screenWidth * 0.04,
                            bottom: SizeConfig.screenWidth * 0.04),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(
                              SizeConfig.screenWidth * 0.05),
                        ),
                        height: SizeConfig.screenHeight * 0.1,
                        width: SizeConfig.screenWidth * 0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Language.languageList()[0].name,
                                style: AppTextTheme.body1.copyWith()),
                            GestureDetector(
                                child: Container(
                                  height: SizeConfig.screenHeight * 0.05,
                                  width: SizeConfig.screenHeight * 0.05,
                                  decoration: BoxDecoration(
                                    color:
                                        (selectEn == true && selectVn == false)
                                            ? Colors.blue
                                            : Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 3,
                                        color: (selectEn == true &&
                                                selectVn == false)
                                            ? AppColor.backgroundColor
                                            : AppColor.topGradient),
                                  ),
                                ),
                                onTap: () async {
                                  selectedLanguage = Language(1, ENGLISH, 'en');
                                  // await notificationData
                                  //     .saveLocale(selectedLanguage!.id);
                                  setState(() {
                                    selectEn = true;
                                    selectVn = false;
                                  });
                                  // print(notificationData.localeId);
                                }),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.05,
                            right: SizeConfig.screenWidth * 0.04),
                        margin: EdgeInsets.only(
                            top: SizeConfig.screenWidth * 0.04,
                            bottom: SizeConfig.screenWidth * 0.04),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(
                              SizeConfig.screenWidth * 0.05),
                        ),
                        height: SizeConfig.screenHeight * 0.1,
                        width: SizeConfig.screenWidth * 0.7,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(Language.languageList()[1].name,
                                  style: AppTextTheme.body1.copyWith()),
                              GestureDetector(
                                  child: Container(
                                    height: SizeConfig.screenHeight * 0.05,
                                    width: SizeConfig.screenHeight * 0.05,
                                    decoration: BoxDecoration(
                                      color: (selectEn == false &&
                                              selectVn == true)
                                          ? Colors.blue
                                          : Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 3,
                                          color: (selectEn == false &&
                                                  selectVn == true)
                                              ? AppColor.backgroundColor
                                              : AppColor.topGradient),
                                    ),
                                  ),
                                  onTap: () async {
                                    selectedLanguage =
                                        Language(2, VIETNAMESE, 'vi');
                                    // await notificationData
                                    //     .saveLocale(selectedLanguage!.id);
                                    // print(notificationData.localeId);
                                    setState(() {
                                      selectEn = false;
                                      selectVn = true;
                                    });
                                  })
                            ]),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: RectangleButton(
                    height: SizeConfig.screenHeight * 0.07,
                    width: SizeConfig.screenWidth * 0.7,
                    title: translation(context).save,
                    buttonColor: AppColor.saveSetting,
                    onTap: () async {
                      if (selectEn) {
                        selectedLanguage = Language(1, ENGLISH, 'en');
                        Locale locale =
                            await setLocale(selectedLanguage!.languageCode);
                        // showLoadingDialog(context: context);
                        // await Future.delayed(const Duration(
                        //     milliseconds: 2000)); // Wait for 1 second
                        MyApp.setLocale(context, locale);
                        Navigator.pop(context);
                        return;
                      }
                      if (selectVn) {
                        selectedLanguage = Language(2, VIETNAMESE, 'vi');
                        Locale locale =
                            await setLocale(selectedLanguage!.languageCode);
                        MyApp.setLocale(context, locale);
                        // showLoadingDialog(context: context);
                        // await Future.delayed(const Duration(
                        //     milliseconds: 1500)); // Wait for 1 second
                        Navigator.pop(context);
                        return;
                      }
                    },
                  ),
                )
              ]),
        ));
  }
}
