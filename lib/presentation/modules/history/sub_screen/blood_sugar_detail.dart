import 'package:common_project/domain/entities/blood_sugar_entity.dart';
import 'package:common_project/function.dart';
import 'package:common_project/presentation/common_widget/common_button.dart';
import 'package:common_project/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                        .format(widget.bloodSugarEntity!.updatedDate!)),
                    Text(DateFormat('hh:mm')
                        .format(widget.bloodSugarEntity!.updatedDate!))
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
                            // const Text('Systolic'),
                            const SizedBox(height: 5),
                            Text(
                              'mg/dL',
                              style: AppTextTheme.title4
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 25),
                            Text(
                                widget.bloodSugarEntity!.bloodSugar!.toString(),
                                style: AppTextTheme.title1.copyWith(
                                    color: const Color.fromARGB(
                                        255, 107, 106, 106),
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
                        
                        Column(
                          children: [
                          
                            const SizedBox(height: 25),
                            Text(widget.bloodSugarEntity!.imageLink!.toString(),
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
                        const Icon(
                          Icons.favorite,
                        ),
                        // color: widget.bloodSugarEntity!.statusColor),
                        Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            // decoration: BoxDecoration(
                            //     color: widget.bloodSugarEntity!.statusColor,
                            //     borderRadius: BorderRadius.circular(5)),
                            height: 8,
                            width: SizeConfig.screenWidth * 0.72),
                        const Icon(
                          Icons.favorite,
                        )
                        // color: widget.bloodSugarEntity!.statusColor),
                      ],
                    ),
                    const SizedBox(height: 25),
                    // Text(widget.bloodSugarEntity!.,
                    //     style: AppTextTheme.body2.copyWith(
                    //         color: widget.bloodSugarEntity!.statusColor,
                    //         fontWeight: FontWeight.w700)),
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
