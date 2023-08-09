import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/common_button.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
            AppColor.appBarColor,
            Color(0xFFE6F7FF),
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
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Icon(
            //       Icons.arrow_back,
            //       color: Colors.black,
            //       size: 30,
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 40,
            ),
            Text('Your Blood Pressure Reading:',
                style: AppTextTheme.title1.copyWith(color: Colors.white)),
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
                    const Text('Time'),
                    Text(DateFormat('dd/MM/yyyy')
                        .format(widget.bloodPressureEntity!.updatedDate!)),
                    Text(DateFormat('HH:mm')
                        .format(widget.bloodPressureEntity!.updatedDate!))
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.26,
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
                            const Text('Systolic'),
                            const SizedBox(height: 5),
                            Text(
                              'mmHg',
                              style: AppTextTheme.title4
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 25),
                            Text(widget.bloodPressureEntity!.sys!.toString(),
                                style: AppTextTheme.title1.copyWith(
                                    color: const Color.fromARGB(
                                        255, 107, 106, 106),
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Diastolic'),
                            const SizedBox(height: 5),
                            Text(
                              'mmHg',
                              style: AppTextTheme.title4
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 25),
                            Text(widget.bloodPressureEntity!.dia!.toString(),
                                style: AppTextTheme.title1.copyWith(
                                    color: const Color.fromARGB(
                                        255, 107, 106, 106),
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Pulse'),
                            const SizedBox(height: 5),
                            Text(
                              'bpm',
                              style: AppTextTheme.title4
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 25),
                            Text(widget.bloodPressureEntity!.pulse!.toString(),
                                style: AppTextTheme.title1.copyWith(
                                    color: const Color.fromARGB(
                                        255, 107, 106, 106),
                                    fontWeight: FontWeight.w800)),
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
                    const SizedBox(height: 25),
                    Text(widget.bloodPressureEntity!.comment,
                        style: AppTextTheme.body2.copyWith(
                            color: widget.bloodPressureEntity!.statusColor,
                            fontWeight: FontWeight.w700)),
                  ],
                )),
            const SizedBox(height: 30),
            CommonButton(
              height: SizeConfig.screenHeight * 0.07,
              title: 'Exit',
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
