import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../classes/language_constant.dart';
import '../../../../domain/entities/temperature_entity.dart';
import '../../../common_widget/assets.dart';
import '../../../theme/app_text_theme.dart';
import '../../../theme/theme_color.dart';
import '../bloc/history_bloc.dart';
import '../sub_screen/temperature_detail.dart';

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
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TemperatureDetailScreen(temperatureEntity: widget.response),
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.cardBackground,
            borderRadius: BorderRadius.circular(10),
            // boxShadow: const [
            //   BoxShadow(
            //     blurRadius: 15,
            //     color: AppColor.backgroundColor,
            //   )
            // ]
          ),
          height: screenSize.height * 0.15,
          width: screenSize.width,
          padding: const EdgeInsets.only(top: 10, left: 12, right: 12),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(5),
                        height: screenSize.width * 0.13,
                        width: screenSize.width * 0.13,
                        decoration: BoxDecoration(
                          color: AppColor.bodyTemperatureColor,
                          borderRadius: BorderRadius.circular(30),
                          // boxShadow: const [
                          //   BoxShadow(
                          //     blurRadius: 10,
                          //     color: Colors.black26,
                          //   )
                          // ]
                        ),
                        child: Image.asset(
                          Assets.temperature,
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(translation(context).bodyTemperature,
                            style: AppTextTheme.title4
                                .copyWith(color: Colors.black, fontSize: 17)),
                        const SizedBox(height: 2),
                        Text(
                          DateFormat('hh:mm dd/MM/yyyy')
                              .format(widget.response!.updatedDate!),
                          style: AppTextTheme.title5.copyWith(fontSize: 13),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: screenSize.width * 0.62),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${widget.response?.temperature}',
                        style: AppTextTheme.body1.copyWith(
                          fontSize: 40,
                        )),
                    Text('°C',
                        style: AppTextTheme.body1.copyWith(
                            fontSize: 30, fontWeight: FontWeight.w400)),
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
