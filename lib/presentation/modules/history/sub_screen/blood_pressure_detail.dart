import 'package:common_project/function.dart';
import 'package:common_project/presentation/common_widget/common_button.dart';
import 'package:common_project/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

import '../../../theme/theme_color.dart';

class BloodPressureDetailScreen extends StatefulWidget {
  const BloodPressureDetailScreen({super.key});

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
    return Expanded(
        child: Container(
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
        style: AppTextTheme.body3,
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Your Blood Pressure Reading History'),
            const SizedBox(
              height: 40,
            ),
            Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.07,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [Text('Time'), Text('11111'), Text('AAAAAA')],
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text('Time'),
                            Text('Time'),
                            Text('Time'),
                          ],
                        ),
                        Column(
                          children: [
                            Text('11111'),
                            Text('11111'),
                            Text('11111'),
                          ],
                        ),
                        Column(
                          children: [
                            Text('AAAAAA'),
                            Text('AAAAAA'),
                            Text('AAAAAA'),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.favorite),
                        Container(
                            color: Colors.green,
                            width: SizeConfig.screenHeight * 0.3),
                        const Icon(Icons.favorite),
                      ],
                    ),
                    const Text('Good Blood Pressure'),
                  ],
                )),
            CommonButton(
                height: SizeConfig.screenHeight * 0.07,
                title: 'Exit',
                buttonColor: Colors.red)
          ],
        ),
      ),
    ));
  }
}
