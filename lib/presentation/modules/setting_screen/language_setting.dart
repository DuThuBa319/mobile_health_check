// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../classes/language.dart';
import '../../../classes/language_constant.dart';
import '../../../common/singletons.dart';
import '../../../utils/size_config.dart';
import '../../../main.dart';

import '../../common_widget/common.dart';
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
                        size: SizeConfig.screenWidth * 0.1),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(translation(context).selectLanguage,
                        style: AppTextTheme.body0.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.screenWidth * 0.06)),
                  ],
                ),
                lineDecor(
                    spaceTop: SizeConfig.screenHeight * 0.01,
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
                            bottom: SizeConfig.screenWidth * 0.05),
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
                        notificationData.saveLocale(1);
                        MyApp.setLocale(context, locale);
                        Navigator.pop(context);
                        return;
                      }
                      if (selectVn) {
                        selectedLanguage = Language(2, VIETNAMESE, 'vi');
                        Locale locale =
                            await setLocale(selectedLanguage!.languageCode);
                        notificationData.saveLocale(2);
                        MyApp.setLocale(context, locale);
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
