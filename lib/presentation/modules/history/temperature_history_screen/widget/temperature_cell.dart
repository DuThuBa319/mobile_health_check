import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_health_check/presentation/route/route_list.dart';

import '../../../../../classes/language.dart';
import '../../../../../domain/entities/temperature_entity.dart';
import '../../../../../utils/size_config.dart';
import '../../../../../assets/assets.dart';
import '../../../../common_widget/dialog/show_toast.dart';
import '../../../../theme/app_text_theme.dart';
import '../../../../theme/theme_color.dart';
import '../../history_bloc/history_bloc.dart';

class TemperatureCellWidget extends StatefulWidget {
  final HistoryBloc? historyBloc;
  final TemperatureEntity? response;
  const TemperatureCellWidget({super.key, this.historyBloc, this.response});

  @override
  State<TemperatureCellWidget> createState() => _TemperatureCellWidgetState();
}

class _TemperatureCellWidgetState extends State<TemperatureCellWidget> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RouteList.bodyTemperatureDetail,
              arguments: widget.response);
          showToast(translation(context).waitForSeconds);
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.cardBackground,
            borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.02),
          ),
          height: SizeConfig.screenHeight * 0.15,
          width: SizeConfig.screenWidth,
          margin: EdgeInsets.fromLTRB(
              SizeConfig.screenWidth * 0.02,
              SizeConfig.screenWidth * 0.02,
              SizeConfig.screenWidth * 0.015,
              SizeConfig.screenWidth * 0.02),
          padding: EdgeInsets.only(
              top: SizeConfig.screenHeight * 0.01,
              left: SizeConfig.screenWidth * 0.02,
              right: SizeConfig.screenWidth * 0.025,
              bottom: SizeConfig.screenHeight * 0.015),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(5),
                        height: SizeConfig.screenWidth * 0.11,
                        width: SizeConfig.screenWidth * 0.11,
                        decoration: const BoxDecoration(
                          color: AppColor.bodyTemperatureColor,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          Assets.temperature,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(translation(context).bodyTemperature,
                            style: AppTextTheme.title4.copyWith(
                                color: Colors.black,
                                fontSize: SizeConfig.screenWidth * 0.045)),
                        Text(
                          DateFormat('hh:mm dd/MM/yyyy')
                              .format(widget.response!.updatedDate!),
                          style: AppTextTheme.title5.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.03),
                        )
                      ],
                    )
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text: '${widget.response?.temperature}',
                                style: AppTextTheme.body1.copyWith(
                                    color: widget.response?.statusColor,
                                    fontSize: SizeConfig.screenWidth * 0.1,
                                    fontWeight: FontWeight.w400)),
                            TextSpan(
                                text: "°",
                                style: AppTextTheme.body1.copyWith(
                                    color: const Color(0xff615A5A),
                                    fontSize: SizeConfig.screenWidth * 0.1,
                                    fontWeight: FontWeight.w500)),
                            TextSpan(
                                text: 'C',
                                style: AppTextTheme.body1.copyWith(
                                    color: const Color(0xff615A5A),
                                    fontSize: SizeConfig.screenWidth * 0.08,
                                    fontWeight: FontWeight.w500))
                          ]))
                    ],
                  ),
                )
              ]),
        ));
  }

  // Widget statusContainer({
  //   double width = 61,
  //   double height = 22,
  //   String statusText = 'Cao',
  //   EdgeInsetsGeometry margin = const EdgeInsets.only(bottom: 7, top: 8),
  //   Color color = Colors.grey,
  // }) =>
  //     Container(
  //       width: width,
  //       height: height,
  //       margin: margin,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(8),
  //         color: color,
  //       ),
  //       child: Text(
  //         statusText,
  //         textAlign: TextAlign.center,
  //         style: const TextStyle(
  //           color: Colors.white,
  //           fontWeight: FontWeight.w600,
  //           fontSize: 12,
  //           height: 1.6,
  //         ),
  //       ),
  //     );
}
