import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/assets/assets.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../classes/language.dart';
import '../../../utils/size_config.dart';
import '../../common_widget/circle_button.dart';
import '../../common_widget/dialog/dialog_two_button.dart';
import '../../common_widget/line_decor.dart';
import '../../common_widget/screen_form/custom_screen_form.dart';
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
                              Navigator.pushNamed(
                                context,
                                RouteList.bloodGlucoseScreen,
                              );
                            });
                      }
                      if (index == 2) {
                        return equipmentCell(
                            cellTitle: translation(context).thermometer,
                            imagePath: Assets.bodyTemperatureMeter,
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
                            cellTitle: translation(context).spo2,
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
                            Navigator.pushNamed(
                              context,
                              RouteList.bloodPressureScreen,
                            );
                          });
                    },
                  ),
                ),
                Gap(SizeConfig.screenWidth * 0.05),
                Text(
                  translation(context).contact,
                  style: TextStyle(
                      fontSize: SizeConfig.screenWidth * 0.08,
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
                  padding: EdgeInsets.only(
                      top: 7, bottom: 7, right: SizeConfig.screenWidth * 0.02),
                  margin: EdgeInsets.only(
                      right: SizeConfig.screenWidth * 0.02,
                      left: 2,
                      bottom: 10),
                  height: SizeConfig.screenHeight * 0.1,
                  child: Center(
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(left: 10),
                      leading: Container(
                          decoration: const BoxDecoration(
                              color: AppColor.backgroundColor,
                              shape: BoxShape.circle),
                          height: SizeConfig.screenWidth * 0.15,
                          width: SizeConfig.screenWidth * 0.15,
                          child: ClipRect(
                            child: Image.asset(Assets.doctor, fit: BoxFit.fill),
                          )),
                      title: Transform.translate(
                        offset: const Offset(-10, 0),
                        child: Text(
                          userDataData.getUser()!.doctor!.name,
                          style: AppTextTheme.body2.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.052,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      subtitle: Transform.translate(
                        offset: const Offset(-10, 0),
                        child: Text(userDataData.getUser()!.doctor!.phoneNumber,
                            style: AppTextTheme.body3),
                      ),
                      trailing: InkWell(
                        onTap: () async {
                          await FlutterPhoneDirectCaller.callNumber(
                              userDataData.getUser()!.doctor!.phoneNumber);
                        },
                        child: CircleButton(
                            iconData: Icons.phone,
                            size: SizeConfig.screenWidth * 0.15,
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
                  height: SizeConfig.screenWidth * 0.04,
                ),
                Text(cellTitle,
                    softWrap: true,
                    style: AppTextTheme.title3.copyWith(
                        color: Colors.white,
                        fontSize: SizeConfig.screenWidth * 0.040)),
              ],
            )),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showNoticeDialogTwoButton(
            context: context,
            message: translation(context).exitApp,
            title: translation(context).areYouSure,
            titleBtn1: translation(context).no,
            titleBtn2: translation(context).yes,
            onClose1: () {},
            onClose2: () {
              SystemNavigator.pop();
            })) ??
        false;
  }
}
