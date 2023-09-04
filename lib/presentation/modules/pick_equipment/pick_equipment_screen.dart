import 'package:mobile_health_check/presentation/common_widget/assets.dart';
import 'package:mobile_health_check/presentation/common_widget/enum_common.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form_for_patient.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';

import '../../../function.dart';
import '../../common_widget/line_decor.dart';
import '../../route/route_list.dart';
part 'pick_equipment_screen.action.dart';

class PickEquipmentScreen extends StatefulWidget {
  const PickEquipmentScreen({super.key});

  @override
  State<PickEquipmentScreen> createState() => _PickEquipmentScreenState();
}

class _PickEquipmentScreenState extends State<PickEquipmentScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    // double screenHeight = SizeConfig.screenHeight;
    // double screenWidth = SizeConfig.screenWidth;
    return PatientCustomScreenForm(
      appBarColor: AppColor.appBarColor,
      title: 'Select Equipment',
      isShowAppBar: true,
      isShowLeadingButton: true,
      isShowBottomNayvigationBar: true,
      selectedIndex: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              'Chọn thiết bị',
              style: TextStyle(
                  fontSize: SizeConfig.screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 5),
            lineDecor(),
            Container(
              padding: const EdgeInsets.only(top: 20, right: 12),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.2),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  if (index == 1) {
                    return equipmentCell(
                        cellTitle: 'Blood Glucose Meter',
                        imagePath: Assets.bloodGlucoseMeter,
                        cellColor: Colors.red[400],
                        subCellColor: Colors.red[100],
                        onTapFunction: () {
                          Navigator.pushNamed(context, RouteList.scanScreen,
                              arguments: MeasuringTask.bloodSugar);
                        });
                  }
                  if (index == 2) {
                    return equipmentCell(
                        cellTitle: 'Thermometer',
                        imagePath: Assets.thermometer,
                        cellColor: Colors.blue[400],
                        subCellColor: Colors.blue[100],
                        onTapFunction: () {
                          Navigator.pushNamed(context, RouteList.scanScreen,
                              arguments: MeasuringTask.temperature);
                        });
                  }
                  return equipmentCell(
                      cellTitle: 'Blood Pressure Meter',
                      imagePath: Assets.bloodPressureMeter,
                      cellColor: const Color.fromARGB(255, 254, 179, 110),
                      subCellColor: const Color.fromARGB(255, 255, 188, 151),
                      onTapFunction: () {
                        Navigator.pushNamed(context, RouteList.scanScreen,
                            arguments: MeasuringTask.bloodPressure);
                      });
                },
              ),
            ),
            // const SizedBox(height: 100),
            // CommonButton(
            //   height: 80,
            //   title: 'Upload',
            //   onTap: upload,
            // )
          ],
        ),
      ),
    );
  }

  Widget equipmentCell(
      {Color? cellColor,
      required String imagePath,
      required String cellTitle,
      Color? subCellColor,
      required Function onTapFunction}) {
    return GestureDetector(
      onTap: () {
        onTapFunction();
      },
      child: Material(
        elevation: 5,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: cellColor),
            child: Column(
              children: [
                Material(
                  elevation: 10,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: SizeConfig.screenWidth * 0.35,
                    height: SizeConfig.screenWidth * 0.36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: subCellColor,
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(cellTitle,
                    style: AppTextTheme.title3.copyWith(color: Colors.white)),
              ],
            )),
      ),
    );
  }
}
