// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:flutter/material.dart';
import 'package:mobile_health_check/utils/size_config.dart';

import 'package:mobile_health_check/presentation/theme/theme_color.dart';

import '../../../../classes/language.dart';
import '../../../theme/app_text_theme.dart';

Widget settingMenuCell(String selectSetting, BuildContext context) {
  SizeConfig.init(context);
  return Container(
    height: SizeConfig.screenWidth * 0.2,
    width: SizeConfig.screenWidth * 0.9,
    margin: EdgeInsets.only(
        top: SizeConfig.screenWidth * 0.03,
        bottom: SizeConfig.screenWidth * 0.03),
    decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.035),
        boxShadow: [
          BoxShadow(
            blurRadius: SizeConfig.screenWidth * 0.035,
            color: Colors.black12,
          )
        ]),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            width: 10,
          ),
          selectSetting == translation(context).updatePassword
              ? Icon(
                  Icons.lock_outline_rounded,
                  size: SizeConfig.screenWidth * 0.1,
                )
              : selectSetting == translation(context).updateProfile
                  ? Icon(Icons.account_box_rounded,
                      size: SizeConfig.screenWidth * 0.1)
                  : Icon(Icons.language, size: SizeConfig.screenWidth * 0.1),
          const SizedBox(
            width: 10,
          ),
          Text(selectSetting,
              style: AppTextTheme.body1
                  .copyWith(fontSize: SizeConfig.screenWidth * 0.06)),
        ]),
        const Icon(Icons.arrow_forward_ios_rounded, size: 30),
      ],
    ),
  );
}

// ignore: must_be_immutable


  ///

//

 
// ignore: must_be_immutable

