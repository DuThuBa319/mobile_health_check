// ignore_for_file: use_build_context_synchronously

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/assets/assets.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../classes/language.dart';
import '../../../utils/size_config.dart';

import '../../common_widget/common.dart';
import '../../route/route_list.dart';
import '../OCR_scanner/ocr_scanner_bloc/ocr_scanner_bloc.dart';

part 'pick_equipment_screen.action.dart';

class PickEquipmentScreen extends StatefulWidget {
  const PickEquipmentScreen({super.key});

  @override
  State<PickEquipmentScreen> createState() => _PickEquipmentScreenState();
}

class _PickEquipmentScreenState extends State<PickEquipmentScreen> {
  OCRScannerBloc get scannerBloc => BlocProvider.of(context);
  @override
  void initState() {
    super.initState();
    scannerBloc.add(StartUpEvent());
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await [
      // Request camera and microphone permissions
      Permission.camera,
      Permission.microphone,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    // double screenHeight = SizeConfig.screenHeight;
    // double screenWidth = SizeConfig.screenWidth;
    return PopScope(
      canPop: false,
      onPopInvoked: _onWillPop,
      child: CustomScreenForm(
        appBarColor: AppColor.appBarColor,
        title: translation(context).selectEquip,
        isShowAppBar: true,
        isShowLeadingButton: false,
        isShowBottomNayvigationBar: true,
        selectedIndex: 0,
        child: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.screenWidth * 0.03,
              right: SizeConfig.screenWidth * 0.02),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(SizeConfig.screenWidth * 0.02),
                Text(
                  translation(context).selectEquip,
                  style: TextStyle(
                      fontSize: SizeConfig.screenWidth * 0.075,
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
                    physics: const NeverScrollableScrollPhysics(),
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
                              if (userDataData
                                      .localDataManager.preferencesHelper
                                      .getData('BloodSugarEquipModel') ==
                                  null) {
                                selectModelDialog(context,
                                    modelAssets: bloodSugarEquipModel,
                                    measuringTask: MeasuringTask.bloodSugar,
                                    isInHomeScreen: true);
                              } else {
                                Navigator.pushNamed(
                                  context,
                                  RouteList.bloodGlucoseScreen,
                                );
                              }
                            });
                      }
                      if (index == 2) {
                        return equipmentCell(
                            cellTitle: translation(context).thermometer,
                            imagePath: Assets.bodyTemperatureMeter,
                            cellColor: Colors.blue[400],
                            subCellColor: Colors.blue[100],
                            onTapFunction: () {
                              if (userDataData
                                      .localDataManager.preferencesHelper
                                      .getData('TempEquipModel') ==
                                  null) {
                                selectModelDialog(context,
                                    modelAssets: temperatureEquipModel,
                                    measuringTask: MeasuringTask.temperature,
                                    isInHomeScreen: true);
                              } else {
                                Navigator.pushNamed(
                                  context,
                                  RouteList.temperatureScreen,
                                );
                              }
                            });
                      }
                      if (index == 3) {
                        return equipmentCell(
                            cellTitle: translation(context).pulseOximeter,
                            imagePath: Assets.oximeter,
                            cellColor: AppColor.oximeter,
                            subCellColor: AppColor.oximeterCell,
                            onTapFunction: () {
                              Navigator.pushNamed(
                                context,
                                RouteList.spo2Screen,
                              );
                            });
                      }
                      return equipmentCell(
                          cellTitle: translation(context).bloodPressureMeter,
                          imagePath: Assets.bloodPressureMeter,
                          cellColor: const Color.fromARGB(255, 254, 179, 110),
                          subCellColor:
                              const Color.fromARGB(255, 255, 188, 151),
                          onTapFunction: () {
                            if (userDataData.localDataManager.preferencesHelper
                                    .getData('BloodPressureEquipModel') ==
                                null) {
                              selectModelDialog(context,
                                  modelAssets: bloodPressureEquipModel,
                                  measuringTask: MeasuringTask.bloodPressure,
                                  isInHomeScreen: true);
                            } else {
                              Navigator.pushNamed(
                                context,
                                RouteList.bloodPressureScreen,
                              );
                            }
                          });
                    },
                  ),
                ),
                Gap(SizeConfig.screenWidth * 0.05),
                Text(
                  translation(context).contact,
                  style: TextStyle(
                      fontSize: SizeConfig.screenWidth * 0.075,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const Gap(5),
                lineDecor(),
                Gap(SizeConfig.screenWidth * 0.03),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(
                      right: SizeConfig.screenWidth * 0.02,
                      left: 2,
                      bottom: 10),
                  height: SizeConfig.screenHeight * 0.1,
                  child: Center(
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 10, right: 10),
                      leading: Container(
                          decoration: const BoxDecoration(
                              color: AppColor.backgroundColor,
                              shape: BoxShape.circle),
                          height: SizeConfig.screenDiagonal * 0.06,
                          width: SizeConfig.screenDiagonal * 0.06,
                          child: ClipRect(
                            child: Image.asset(Assets.doctor, fit: BoxFit.fill),
                          )),
                      title: Transform.translate(
                        offset: const Offset(-10, 0),
                        child: Text(
                          userDataData.getUser()!.doctor!.name,
                          style: AppTextTheme.body2.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.055,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      subtitle: Transform.translate(
                        offset: const Offset(-10, 0),
                        child: Text(userDataData.getUser()!.doctor!.phoneNumber,
                            style: AppTextTheme.body3.copyWith(
                                fontSize: SizeConfig.screenWidth * 0.04)),
                      ),
                      trailing: InkWell(
                        onTap: () async {
                          await FlutterPhoneDirectCaller.callNumber(
                              userDataData.getUser()!.doctor!.phoneNumber);
                        },
                        child: CircleButton(
                            iconData: Icons.phone,
                            size: SizeConfig.screenDiagonal * 0.06,
                            backgroundColor: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                  height: SizeConfig.screenHeight * 0.015,
                ),
                Text(cellTitle,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextTheme.title3.copyWith(
                        color: Colors.white,
                        fontSize: SizeConfig.screenWidth * 0.037)),
              ],
            )),
      ),
    );
  }
}

class BannerIndicator extends StatelessWidget {
  final bool isActive;
  const BannerIndicator({
    super.key,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: isActive
            ? SizeConfig.screenWidth * 0.04
            : SizeConfig.screenWidth * 0.02,
        height: SizeConfig.screenWidth * 0.02,
        margin: EdgeInsets.only(right: SizeConfig.screenWidth * 0.01),
        decoration: BoxDecoration(
            color: isActive ? AppColor.appBarColor : Colors.grey,
            borderRadius: BorderRadius.circular(20)));
  }
}

Future<dynamic> selectModelDialog(BuildContext context,
    {required List<String> modelAssets,
    required MeasuringTask measuringTask,
    bool isInHomeScreen = false}) {
  int selectedIndex = 0;
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(translation(context).selectProduct,
                style: const TextStyle(
                    color: AppColor.black, fontWeight: FontWeight.w500)),
            content: Container(
              margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.015),
              padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.015),
              height: SizeConfig.screenHeight * 0.3,
              width: SizeConfig.screenWidth * 0.84,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.cardBackgroundColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: SizeConfig.screenHeight * 0.2,
                    width: SizeConfig.screenWidth * 0.84,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColor.cardBackgroundColor,
                    ),
                    child: PageView.builder(
                        onPageChanged: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        controller: PageController(viewportFraction: 0.7),
                        itemCount: modelAssets.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                right: SizeConfig.screenWidth * 0.05),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.screenWidth * 0.05),
                              color: selectedIndex == index
                                  ? AppColor.lineDecor
                                  : AppColor.appBarColor,
                              image: DecorationImage(
                                  image: AssetImage(
                                    modelAssets[index],
                                  ),
                                  fit: BoxFit.fitWidth),
                            ),
                          );
                        }),
                  ),
                  Gap(SizeConfig.screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                          modelAssets.length,
                          (index) => BannerIndicator(
                                isActive: index == selectedIndex,
                              )),
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    translation(context).back,
                    style: const TextStyle(
                        color: AppColor.black, fontWeight: FontWeight.w500),
                  )),
              TextButton(
                child: Text(translation(context).select,
                    style: const TextStyle(
                        color: AppColor.black, fontWeight: FontWeight.w500)),
                onPressed: () {
                  Navigator.pop(context);
                  switch (measuringTask) {
                    case MeasuringTask.bloodPressure:
                      userDataData.localDataManager.preferencesHelper
                          .saveData('BloodPressureEquipModel', selectedIndex);
                      if (isInHomeScreen) {
                        Navigator.pushNamed(
                          context,
                          RouteList.bloodPressureScreen,
                        );
                      }
                      break;
                    case MeasuringTask.temperature:
                      userDataData.localDataManager.preferencesHelper
                          .saveData('TempEquipModel', selectedIndex);
                      if (isInHomeScreen) {
                        Navigator.pushNamed(
                          context,
                          RouteList.temperatureScreen,
                        );
                      }
                      break;
                    case MeasuringTask.bloodSugar:
                      userDataData.localDataManager.preferencesHelper
                          .saveData('BloodSugarEquipModel', selectedIndex);

                      if (isInHomeScreen) {
                        Navigator.pushNamed(
                          context,
                          RouteList.bloodGlucoseScreen,
                        );
                      }
                      break;

                    default:
                      break;
                  }
                },
              ),
            ],
          );
        });
      });
}
