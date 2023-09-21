import 'package:flutter/services.dart';
import 'package:mobile_health_check/presentation/common_widget/assets.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form_for_patient.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';

import '../../../classes/language.dart';
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: PatientCustomScreenForm(
        appBarColor: AppColor.appBarColor,
        title: translation(context).selectEquip,
        isShowAppBar: true,
        isShowLeadingButton: false,
        isShowBottomNayvigationBar: true,
        selectedIndex: 0,
        child: Padding(
          padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.screenWidth * 0.1),
              Text(
                translation(context).selectEquip,
                style: TextStyle(
                    fontSize: SizeConfig.screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 5),
              lineDecor(),
              Container(
                padding: EdgeInsets.only(
                    top: SizeConfig.screenWidth * 0.05,
                    right: SizeConfig.screenWidth * 0.03),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: SizeConfig.screenWidth * 0.04,
                      mainAxisSpacing: SizeConfig.screenWidth * 0.05,
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.2),
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    if (index == 1) {
                      return equipmentCell(
                          cellTitle: translation(context).bloodGlucoseMeter,
                          imagePath: Assets.bloodGlucoseMeter,
                          cellColor: Colors.red[400],
                          subCellColor: Colors.red[100],
                          onTapFunction: () {
                            Navigator.pushNamed(
                              context,
                              RouteList.bloodGlucoseScreen,
                            );
                          });
                    }
                    if (index == 2) {
                      return equipmentCell(
                          cellTitle: translation(context).thermometer,
                          imagePath: Assets.thermometer,
                          cellColor: Colors.blue[400],
                          subCellColor: Colors.blue[100],
                          onTapFunction: () {
                            Navigator.pushNamed(
                              context,
                              RouteList.temperatureScreen,
                            );
                          });
                    }
                    if (index == 3) {
                      return equipmentCell(
                          cellTitle: translation(context).oximeter,
                          imagePath: Assets.oximeter,
                          cellColor: AppColor.oximeter,
                          subCellColor: AppColor.oximeterCell,
                          onTapFunction: () {
                            Navigator.pushNamed(
                              context,
                              RouteList.pushOxiScreen,
                            );
                          });
                    }

                    return equipmentCell(
                        cellTitle: translation(context).bloodPressureMeter,
                        imagePath: Assets.bloodPressureMeter,
                        cellColor: const Color.fromARGB(255, 254, 179, 110),
                        subCellColor: const Color.fromARGB(255, 255, 188, 151),
                        onTapFunction: () {
                          Navigator.pushNamed(
                            context,
                            RouteList.bloodPressureScreen,
                          );
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
        borderRadius:
            BorderRadius.all(Radius.circular(SizeConfig.screenWidth * 0.05)),
        child: Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(SizeConfig.screenWidth * 0.05),
                color: cellColor),
            child: Column(
              children: [
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.screenWidth * 0.05)),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: SizeConfig.screenWidth * 0.35,
                    height: SizeConfig.screenWidth * 0.36,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(SizeConfig.screenWidth * 0.05),
                      color: subCellColor,
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenWidth * 0.04,
                ),
                Text(cellTitle,
                    style: AppTextTheme.title3.copyWith(color: Colors.white)),
              ],
            )),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                // <-- SEE HERE
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
