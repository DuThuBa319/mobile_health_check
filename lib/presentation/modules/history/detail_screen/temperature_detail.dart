import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/common_button.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../classes/language_constant.dart';
import '../../../../domain/entities/temperature_entity.dart';
import '../../../common_widget/screen_form/image_picker_widget/custom_image_picker.dart';
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
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(12, SizeConfig.screenWidth * 0.08, 12, 10),
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
              SizedBox(
                height: SizeConfig.screenWidth * 0.1,
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
                        style: AppTextTheme.body1
                            .copyWith(fontSize: SizeConfig.screenWidth * 0.06),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy')
                            .format(widget.temperatureEntity!.updatedDate!),
                        style: AppTextTheme.body1
                            .copyWith(fontSize: SizeConfig.screenWidth * 0.06),
                      ),
                      Text(
                        DateFormat('HH:mm')
                            .format(widget.temperatureEntity!.updatedDate!),
                        style: AppTextTheme.body1
                            .copyWith(fontSize: SizeConfig.screenWidth * 0.06),
                      )
                    ],
                  )),
              SizedBox(
                height: SizeConfig.screenWidth * 0.08,
              ),
              CustomImagePicker(
                imagePath: widget.temperatureEntity?.imageLink ??
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMtf5HimrPTRa-LtN6UAlm2-YJD8vtj7C3Kg&usqp=CAU",
                isOnTapActive: true,
                isforAvatar: false,
              ),
              SizedBox(
                height: SizeConfig.screenWidth * 0.08,
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
                      Text(translation(context).bodyTemperature,
                          style: AppTextTheme.title2.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.075,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: SizeConfig.screenHeight * 0.005),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      "${widget.temperatureEntity!.temperature ?? widget.temperatureEntity!.temperature!}°",
                                  style: AppTextTheme.body0.copyWith(
                                    letterSpacing: -4,
                                    fontSize: SizeConfig.screenWidth * 0.2,
                                    color:
                                        widget.temperatureEntity!.statusColor,
                                  )),
                              TextSpan(
                                  text: 'C',
                                  style: AppTextTheme.body0.copyWith(
                                    fontSize: SizeConfig.screenWidth * 0.15,
                                    color:
                                        widget.temperatureEntity!.statusColor,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      // Row(

                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: [
                      //     Text(
                      //         "${widget.TemperatureEntity!.Temperature ?? widget.TemperatureEntity!.Temperature!}",
                      //         style: AppTextTheme.body0.copyWith(
                      //           letterSpacing: -4,
                      //           fontSize: SizeConfig.screenWidth * 0.2,
                      //           color: widget.TemperatureEntity!.statusColor,
                      //         )),
                      //     const SizedBox(
                      //       width: 2,
                      //     ),
                      //     Text('mg/dL',
                      //         style: AppTextTheme.body0.copyWith(
                      //           fontSize: SizeConfig.screenWidth * 0.08,
                      //           color: widget.TemperatureEntity!.statusColor,
                      //         )),
                      //   ],
                      // ),
                      SizedBox(height: SizeConfig.screenWidth * 0.05),
                      Center(
                        child: Text(
                            widget.temperatureEntity!.statusComment(context),
                            style: AppTextTheme.body2.copyWith(
                                color: widget.temperatureEntity!.statusColor,
                                fontWeight: FontWeight.w700,
                                fontSize: SizeConfig.screenWidth * 0.06)),
                      ),
                    ],
                  )),
              SizedBox(height: SizeConfig.screenWidth * 0.05),
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
      ),
    );
  }
}
