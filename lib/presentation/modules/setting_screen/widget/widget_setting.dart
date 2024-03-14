// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:flutter/material.dart';
import 'package:mobile_health_check/utils/size_config.dart';

import 'package:mobile_health_check/presentation/theme/theme_color.dart';

import '../../../../classes/language.dart';
import '../../../theme/app_text_theme.dart';

Widget settingMenuCell(String selectSetting, BuildContext context) {
  SizeConfig.init(context);
  return Container(
    height: SizeConfig.screenDiagonal < 1350
        ? SizeConfig.screenWidth * 0.2
        : SizeConfig.screenWidth * 0.175,
    width: SizeConfig.screenWidth,
    margin: EdgeInsets.only(
        top: SizeConfig.screenWidth * 0.025,
        bottom: SizeConfig.screenWidth * 0.025),
    decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.035),
        boxShadow: [
          BoxShadow(
            blurRadius: SizeConfig.screenWidth * 0.03,
            color: Colors.black12,
          )
        ]),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: SizeConfig.screenDiagonal < 1350
                      ? SizeConfig.screenWidth * 0.012
                      : SizeConfig.screenWidth * 0.02),
              selectSetting == translation(context).updatePassword
                  ? Icon(
                      Icons.lock_outline_rounded,
                      size: SizeConfig.screenDiagonal < 1350
                          ? SizeConfig.screenDiagonal * 0.04
                          : SizeConfig.screenDiagonal * 0.045,
                    )
                  : selectSetting == translation(context).updateProfile
                      ? Icon(
                          Icons.account_box_rounded,
                          size: SizeConfig.screenDiagonal < 1350
                              ? SizeConfig.screenDiagonal * 0.04
                              : SizeConfig.screenDiagonal * 0.045,
                        )
                      : Icon(
                          Icons.language,
                          size: SizeConfig.screenDiagonal < 1350
                              ? SizeConfig.screenDiagonal * 0.04
                              : SizeConfig.screenDiagonal * 0.045,
                        ),
              SizedBox(width: SizeConfig.screenWidth * 0.012),
              Text(selectSetting,
                  style: AppTextTheme.body1
                      .copyWith(fontSize: SizeConfig.screenWidth * 0.06)),
            ]),
        Icon(Icons.arrow_forward_ios_rounded,
            size: SizeConfig.screenDiagonal * 0.025),
      ],
    ),
  );
}

// ignore: must_be_immutable


  ///

//

 
// ignore: must_be_immutable

