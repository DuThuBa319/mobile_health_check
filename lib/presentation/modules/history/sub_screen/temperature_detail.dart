import 'package:common_project/domain/entities/temperature_entity.dart';
import 'package:common_project/function.dart';
import 'package:common_project/presentation/common_widget/common_button.dart';
import 'package:common_project/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../theme/theme_color.dart';

class TemperatureDetailScreen extends StatefulWidget {
  final TemperatureEntity? temperatureEntity;
  const TemperatureDetailScreen({super.key, this.temperatureEntity});

  @override
  State<TemperatureDetailScreen> createState() =>
      _TemperatureDetailScreenState();
}

class _TemperatureDetailScreenState extends State<TemperatureDetailScreen> {
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
            child: Column(children: [
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
                          .format(widget.temperatureEntity!.updatedDate!)),
                      Text(DateFormat('hh:mm')
                          .format(widget.temperatureEntity!.updatedDate!))
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
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 5),
                            const SizedBox(height: 25),
                            Text(
                                widget.temperatureEntity!.temperature!
                                    .toString(),
                                style: AppTextTheme.title1.copyWith(
                                    color: const Color.fromARGB(
                                        255, 107, 106, 106),
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
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
                    )
                  ]))
            ])));
  }
}
