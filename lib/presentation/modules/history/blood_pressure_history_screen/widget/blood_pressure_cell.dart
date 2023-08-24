import 'package:mobile_health_check/presentation/modules/history/detail_screen/blood_pressure_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../classes/language_constant.dart';
import '../../../../../domain/entities/blood_pressure_entity.dart';
import '../../../../common_widget/assets.dart';
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
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BloodPressureDetailScreen(
                    bloodPressureEntity: widget.response),
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.cardBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          height: screenSize.height * 0.15,
          width: screenSize.width,
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(5),
                        height: screenSize.width * 0.10,
                        width: screenSize.width * 0.10,
                        decoration: const BoxDecoration(
                            color: AppColor.bloodPressureColor,
                            shape: BoxShape.circle),
                        child: Center(
                          child: Image.asset(
                            Assets.bloodPressureicon,
                            fit: BoxFit.cover,
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(translation(context).bloodPressure,
                            style: AppTextTheme.title4.copyWith(
                                color: Colors.black,
                                fontSize: screenSize.width * 0.04)),
                        const SizedBox(height: 2),
                        Text(
                          DateFormat('HH:mm dd/MM/yyyy')
                              .format(widget.response!.updatedDate!),
                          style: AppTextTheme.title5
                              .copyWith(fontSize: screenSize.width * 0.03),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: screenSize.width * 0.37),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${widget.response?.sys}/${widget.response?.dia}',
                        style: AppTextTheme.body1.copyWith(
                          fontSize:
                              screenSize.width * 0.1, // 0,1 xấp xỉ 38 39 40
                        )),
                    Text(
                      'mmHg',
                      style: AppTextTheme.title5.copyWith(
                          fontSize:
                              screenSize.width * 0.03), // 0.03 xấp xỉ 12 13
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${widget.response?.pulse}',
                        style: AppTextTheme.body1.copyWith(
                            fontSize: screenSize.width * 0.08, //0.08 xấp xỉ 30
                            fontWeight: FontWeight.w400)),
                    Text(
                      'bpm',
                      style: AppTextTheme.title5
                          .copyWith(fontSize: screenSize.width * 0.03),
                    ),
                  ],
                ),
              ],
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
