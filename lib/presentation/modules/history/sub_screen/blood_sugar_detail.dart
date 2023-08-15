import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/common_button.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../classes/language_constant.dart';
import '../../../../domain/entities/blood_sugar_entity.dart';
import '../../../common_widget/screen_form/image_picker_widget/custom_image_picker.dart';
import '../../../theme/theme_color.dart';

class BloodSugarDetailScreen extends StatefulWidget {
  final BloodSugarEntity? bloodSugarEntity;
  const BloodSugarDetailScreen({super.key, this.bloodSugarEntity});

  @override
  State<BloodSugarDetailScreen> createState() => _BloodSugarDetailScreenState();
}

class _BloodSugarDetailScreenState extends State<BloodSugarDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 30, 12, 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.topGradient,
            AppColor.backgroundColor // Colors.white, // Xanh nhạt nhất
            // Xanh đậm nhất
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // Thay đổi begin và end để điều chỉnh hướng chuyển đổi màu
        ),
      ),
      child: DefaultTextStyle(
        style: AppTextTheme.body2,
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.07,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                     translation(context).time,
                      style: AppTextTheme.body1.copyWith(fontSize: 20),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy')
                          .format(widget.bloodSugarEntity!.updatedDate!),
                      style: AppTextTheme.body1.copyWith(fontSize: 20),
                    ),
                    Text(
                      DateFormat('HH:mm')
                          .format(widget.bloodSugarEntity!.updatedDate!),
                      style: AppTextTheme.body1.copyWith(fontSize: 20),
                    )
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            const ImagePickerSingle(
              imagePath: null,
              isOnTapActive: true,
              isforAvatar: false,
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.26,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(translation(context).bloodSugar,
                        style: AppTextTheme.title2
                            .copyWith(fontSize: 28, color: Colors.black)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.23,
                        ),
                        Text(widget.bloodSugarEntity!.bloodSugar!.toString(),
                            style: AppTextTheme.body0.copyWith(
                              fontSize: 80,
                              color: widget.bloodSugarEntity!.statusColor,
                            )),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.04,
                        ),
                        Icon(
                          Icons.water_drop_rounded,
                          size: 100,
                          color: widget.bloodSugarEntity!.statusColor,
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(widget.bloodSugarEntity!.comment,
                          style: AppTextTheme.body2.copyWith(
                              color: widget.bloodSugarEntity!.statusColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 20)),
                    ),
                  ],
                )),
            const SizedBox(height: 40),
            CommonButton(
              height: SizeConfig.screenHeight * 0.07,
              title: translation(context).back,
              buttonColor: Colors.red,
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
