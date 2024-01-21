import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_health_check/presentation/common_widget/enum_common.dart';
import 'package:mobile_health_check/utils/size_config.dart';
import 'package:mobile_health_check/presentation/route/route_list.dart';

import '../../../../../classes/language.dart';
import '../../../../../domain/entities/spo2_entity.dart';
import '../../../../../assets/assets.dart';
import '../../../../common_widget/dialog/show_toast.dart';
import '../../../../theme/app_text_theme.dart';
import '../../../../theme/theme_color.dart';
import '../../history_bloc/history_bloc.dart';

class Spo2CellWidget extends StatefulWidget {
  final HistoryBloc? historyBloc;
  final Spo2Entity? response;
  const Spo2CellWidget({super.key, this.historyBloc, this.response});

  @override
  State<Spo2CellWidget> createState() => _Spo2CellWidgetState();
}

class _Spo2CellWidgetState extends State<Spo2CellWidget> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RouteList.spo2Detail,
              arguments: widget.response);
          showToast( context: context,
                            status: ToastStatus.loading,
                            toastString:translation(context).waitForSeconds);
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
            SizeConfig.screenHeight * 0.01,
            SizeConfig.screenWidth * 0.015,
            SizeConfig.screenHeight * 0.01,
          ),
          padding: EdgeInsets.only(
              top: SizeConfig.screenHeight * 0.01,
              left: SizeConfig.screenWidth * 0.02,
              right: SizeConfig.screenWidth * 0.025,
              bottom: SizeConfig.screenHeight * 0.005),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(5),
                    height: SizeConfig.screenDiagonal * 0.045,
                    width: SizeConfig.screenDiagonal * 0.045,
                    decoration: const BoxDecoration(
                        color: AppColor.bloodPressureColor,
                        shape: BoxShape.circle),
                    child: Image.asset(
                      Assets.oxi,
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.01,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(translation(context).oximeter,
                        style: AppTextTheme.title4.copyWith(
                          color: Colors.black,
                          fontSize: SizeConfig.screenDiagonal * 0.018,
                        )),
                    Text(
                      DateFormat('HH:mm dd/MM/yyyy')
                          .format(widget.response!.updatedDate!),
                      style: AppTextTheme.title5.copyWith(
                          fontSize: SizeConfig.screenDiagonal * 0.015),
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
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: '${widget.response!.spo2}',
                            style: AppTextTheme.title3.copyWith(
                                // color: widget.response?.statusColor,
                                color: widget.response?.statusColor,
                                fontSize: SizeConfig.screenDiagonal * 0.055,
                                fontWeight: FontWeight.w500)),
                        TextSpan(
                            text: " %",
                            style: AppTextTheme.title3.copyWith(
                                color: const Color(0xff615A5A),
                                fontSize: SizeConfig.screenDiagonal * 0.035,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  )
                ],
              ),
            ),
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
