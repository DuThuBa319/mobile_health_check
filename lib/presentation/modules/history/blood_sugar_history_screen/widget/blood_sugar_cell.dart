import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_health_check/function.dart';

import '../../../../../classes/language_constant.dart';
import '../../../../../domain/entities/blood_sugar_entity.dart';
import '../../../../common_widget/assets.dart';
import '../../../../common_widget/dialog/show_toast.dart';
import '../../../../theme/app_text_theme.dart';
import '../../../../theme/theme_color.dart';
import '../../detail_screen/blood_sugar_detail.dart';
import '../../history_bloc/history_bloc.dart';

class BloodSugarCellWidget extends StatefulWidget {
  final HistoryBloc? historyBloc;
  final BloodSugarEntity? response;
  const BloodSugarCellWidget({super.key, this.historyBloc, this.response});

  @override
  State<BloodSugarCellWidget> createState() => _BloodSugarCellWidgetState();
}

class _BloodSugarCellWidgetState extends State<BloodSugarCellWidget> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BloodSugarDetailScreen(bloodSugarEntity: widget.response),
              ));
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
              SizeConfig.screenWidth * 0.02,
              SizeConfig.screenWidth * 0.02),
          padding: EdgeInsets.only(
              top: SizeConfig.screenWidth * 0.02, left: 12, right: 12),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(5),
                    height: SizeConfig.screenWidth * 0.1,
                    width: SizeConfig.screenWidth * 0.1,
                    decoration: const BoxDecoration(
                        color: AppColor.bodyTemperatureColor,
                        shape: BoxShape.circle),
                    child: Image.asset(
                      Assets.bloodSugar,
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.01,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(translation(context).bloodSugar,
                        style: AppTextTheme.title4.copyWith(
                            color: Colors.black,
                            fontSize: SizeConfig.screenWidth * 0.045)),
                    const SizedBox(height: 2),
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
            SizedBox(
              height: SizeConfig.screenWidth * 0.06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: '${widget.response!.bloodSugar}',
                          style: AppTextTheme.title3.copyWith(
                              color: widget.response?.statusColor,
                              fontSize: SizeConfig.screenWidth * 0.1,
                              fontWeight: FontWeight.w500)),
                      TextSpan(
                          text: " mg/dL",
                          style: AppTextTheme.title3.copyWith(
                              color: const Color(0xff615A5A),
                              fontSize: SizeConfig.screenWidth * 0.05,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                )
              ],
            ),
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
