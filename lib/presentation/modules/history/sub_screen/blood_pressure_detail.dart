import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/common_button.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/image_picker_widget/custom_image_picker.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../classes/language_constant.dart';
import '../../../../domain/entities/blood_pressure_entity.dart';
import '../../../theme/theme_color.dart';

class BloodPressureDetailScreen extends StatefulWidget {
  final BloodPressureEntity? bloodPressureEntity;
  const BloodPressureDetailScreen({super.key, this.bloodPressureEntity});

  @override
  State<BloodPressureDetailScreen> createState() =>
      _BloodPressureDetailScreenState();
}

class _BloodPressureDetailScreenState extends State<BloodPressureDetailScreen> {
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
            AppColor.backgroundColor
            // Colors.white, // Xanh nhạt nhất
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
                          .format(widget.bloodPressureEntity!.updatedDate!),
                      style: AppTextTheme.body1.copyWith(fontSize: 20),
                    ),
                    Text(
                      DateFormat('HH:mm')
                          .format(widget.bloodPressureEntity!.updatedDate!),
                      style: AppTextTheme.body1.copyWith(fontSize: 20),
                    )
                  ],
                )),

            // Container(
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(25)),
            //     width: SizeConfig.screenHeight * 0.35,
            //     height: SizeConfig.screenHeight * 0.35,
            //     child: ),
            const SizedBox(
              height: 30,
            ),
            ImagePickerSingle(
              imagePath: widget.bloodPressureEntity?.imageLink,
              isOnTapActive: true,
              isforAvatar: false,
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.28,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text('SYS',
                                style: AppTextTheme.title2.copyWith(
                                    fontSize: 24, color: Colors.black)),
                            const SizedBox(height: 5),
                            Text(
                              'mmHg',
                              style: AppTextTheme.title5.copyWith(fontSize: 15),
                            ),
                            const SizedBox(height: 25),
                            Text(widget.bloodPressureEntity!.sys.toString(),
                                style: AppTextTheme.title1.copyWith(
                                    color:
                                        const Color.fromARGB(255, 94, 93, 93),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 35)),
                          ],
                        ),
                        Column(
                          children: [
                            Text('DIA',
                                style: AppTextTheme.title2.copyWith(
                                    fontSize: 24, color: Colors.black)),
                            const SizedBox(height: 5),
                            Text(
                              'mmHg',
                              style: AppTextTheme.title5.copyWith(fontSize: 15),
                            ),
                            const SizedBox(height: 25),
                            Text(widget.bloodPressureEntity!.dia.toString(),
                                style: AppTextTheme.title1.copyWith(
                                    color:
                                        const Color.fromARGB(255, 94, 93, 93),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 35)),
                          ],
                        ),
                        Column(
                          children: [
                            Text('PUL',
                                style: AppTextTheme.title2.copyWith(
                                    fontSize: 24, color: Colors.black)),
                            const SizedBox(height: 5),
                            Text(
                              'bpm',
                              style: AppTextTheme.title5.copyWith(fontSize: 15),
                            ),
                            const SizedBox(height: 25),
                            Text(widget.bloodPressureEntity!.pulse.toString(),
                                style: AppTextTheme.title1.copyWith(
                                    color:
                                        const Color.fromARGB(255, 94, 93, 93),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 35)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Icon(Icons.favorite,
                            color: widget.bloodPressureEntity!.statusColor),
                        Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: widget.bloodPressureEntity!.statusColor,
                                borderRadius: BorderRadius.circular(5)),
                            height: 8,
                            width: SizeConfig.screenWidth * 0.72),
                        Icon(Icons.favorite,
                            color: widget.bloodPressureEntity!.statusColor),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(widget.bloodPressureEntity!.comment,
                        style: AppTextTheme.body2.copyWith(
                            color: widget.bloodPressureEntity!.statusColor,
                            fontWeight: FontWeight.w700)),
                  ],
                )),
            const SizedBox(height: 20),
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
