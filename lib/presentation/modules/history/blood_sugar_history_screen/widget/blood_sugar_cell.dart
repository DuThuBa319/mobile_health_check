import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_health_check/presentation/common_widget/enum_common.dart';
import 'package:mobile_health_check/utils/size_config.dart';

import '../../../../../classes/language.dart';
import '../../../../../domain/entities/blood_sugar_entity.dart';
import '../../../../../assets/assets.dart';
import '../../../../common_widget/dialog/show_toast.dart';
import '../../../../route/route_list.dart';
import '../../../../theme/app_text_theme.dart';
import '../../../../theme/theme_color.dart';
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
          Navigator.pushNamed(context, RouteList.bloodSugarDetail,
              arguments: widget.response);
          showToast(
              context: context,
              status: ToastStatus.loading,
              toastString: translation(context).waitForSeconds);
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
            SizeConfig.screenWidth * 0.02,
            SizeConfig.screenHeight * 0.01,
          ),
          padding: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.01,
            left: SizeConfig.screenWidth * 0.02,
            right: SizeConfig.screenWidth * 0.025,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(SizeConfig.screenWidth * 0.01),
                        height: SizeConfig.screenDiagonal * 0.045,
                        width: SizeConfig.screenDiagonal * 0.045,
                        decoration: const BoxDecoration(
                            color: AppColor.bodyTemperatureColor,
                            shape: BoxShape.circle),
                        child: Image.asset(
                          Assets.bloodSugar,
                          fit: BoxFit.fitWidth,
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
                              fontSize: SizeConfig.screenDiagonal * 0.018,
                            )),
                        Text(
                          DateFormat('HH:mm dd/MM/yyyy')
                              .format(widget.response!.updatedDate!),
                          style: AppTextTheme.title5.copyWith(
                            fontSize: SizeConfig.screenDiagonal * 0.015,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Expanded(
                  child: Transform.translate(
                    offset: Offset(0, -SizeConfig.screenHeight * 0.005),
                    child: Row(
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
                                      fontSize:
                                          SizeConfig.screenDiagonal * 0.05,
                                      fontWeight: FontWeight.w500)),
                              TextSpan(
                                  text: " mg/dL",
                                  style: AppTextTheme.title3.copyWith(
                                      color: const Color(0xff615A5A),
                                      fontSize:
                                          SizeConfig.screenDiagonal * 0.022,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
        ));
  }
}
