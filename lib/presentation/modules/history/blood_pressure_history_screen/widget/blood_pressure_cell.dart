import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../classes/language.dart';
import '../../../../../domain/entities/blood_pressure_entity.dart';
import '../../../../../function.dart';
import '../../../../common_widget/assets.dart';
import '../../../../common_widget/dialog/show_toast.dart';
import '../../../../route/route_list.dart';
import '../../../../theme/app_text_theme.dart';
import '../../../../theme/theme_color.dart';

import '../../history_bloc/history_bloc.dart';

class BloodPressureCellWidget extends StatefulWidget {
  final HistoryBloc? historyBloc;
  final BloodPressureEntity? response;
  const BloodPressureCellWidget({super.key, this.historyBloc, this.response});

  @override
  State<BloodPressureCellWidget> createState() =>
      _BloodPressureCellWidgetState();
}

class _BloodPressureCellWidgetState extends State<BloodPressureCellWidget> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RouteList.bloodPressuerDetail,
              arguments: widget.response);
          showToast(translation(context).waitForSeconds);
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.cardBackground,
            borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.03),
          ),
          height: SizeConfig.screenHeight * 0.15,
          width: SizeConfig.screenWidth,
          margin: EdgeInsets.fromLTRB(
              SizeConfig.screenWidth * 0.02,
              SizeConfig.screenWidth * 0.02,
              SizeConfig.screenWidth * 0.015,
              SizeConfig.screenWidth * 0.02),
          padding: EdgeInsets.only(
            top: SizeConfig.screenWidth * 0.02,
            left: SizeConfig.screenWidth * 0.02,
            right: SizeConfig.screenWidth * 0.02,
          ),
          child: Column(children: [
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.all(5),
                    height: SizeConfig.screenWidth * 0.1,
                    width: SizeConfig.screenWidth * 0.1,
                    decoration: const BoxDecoration(
                        color: AppColor.bloodPressureColor,
                        shape: BoxShape.circle),
                    child: Center(
                      child: Image.asset(
                        Assets.bloodPressureicon,
                        fit: BoxFit.cover,
                      ),
                    )),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.02,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(translation(context).bloodPressure,
                        style: AppTextTheme.title4.copyWith(
                            color: Colors.black,
                            fontSize: SizeConfig.screenWidth * 0.045)),
                    Text(
                      DateFormat('HH:mm dd/MM/yyyy')
                          .format(widget.response!.updatedDate!),
                      style: AppTextTheme.title5
                          .copyWith(fontSize: SizeConfig.screenWidth * 0.03),
                    )
                  ],
                )
              ],
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${widget.response?.sys}',
                          style: AppTextTheme.body1.copyWith(
                              color: widget.response?.statusColor,
                              fontSize: SizeConfig.screenWidth *
                                  0.09, // 0,1 xấp xỉ 38 39 40
                              fontWeight: FontWeight.w500)),
                      Text(
                        textAlign: TextAlign.end,

                        'mmHg',
                        style: AppTextTheme.title5.copyWith(
                            fontSize: SizeConfig.screenWidth * 0.035,
                            fontWeight: FontWeight.w500), // 0.03 xấp xỉ 12 13
                      ),
                    ],
                  ),
                  SizedBox(width: SizeConfig.screenWidth * 0.05),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${widget.response?.pulse}',
                        style: AppTextTheme.body1.copyWith(
                          color: widget.response?.statusColor,
                          fontSize:
                              SizeConfig.screenWidth * 0.075, //0.08 xấp xỉ 30
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.end,
                        'bpm',
                        style: AppTextTheme.title5.copyWith(
                            fontSize: SizeConfig.screenWidth * 0.035,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 2)
                    ],
                  ),
                ],
              ),
            )
          ]),
        ));
  }

  Widget statusContainer({
    double width = 61,
    double height = 22,
    String statusText = 'Cao',
    EdgeInsetsGeometry margin = const EdgeInsets.only(bottom: 7, top: 8),
    Color color = Colors.grey,
  }) =>
      Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Text(
          statusText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
            height: 1.6,
          ),
        ),
      );
}
