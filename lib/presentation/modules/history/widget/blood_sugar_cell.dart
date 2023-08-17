import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../classes/language_constant.dart';
import '../../../../domain/entities/blood_sugar_entity.dart';
import '../../../common_widget/assets.dart';
import '../../../theme/app_text_theme.dart';
import '../../../theme/theme_color.dart';
import '../bloc/history_bloc.dart';
import '../sub_screen/blood_sugar_detail.dart';

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
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BloodSugarDetailScreen(bloodSugarEntity: widget.response),
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
          padding: const EdgeInsets.only(top: 10, left: 12, right: 12),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(5),
                    height: screenSize.width * 0.10,
                    width: screenSize.width * 0.10,
                    decoration: const BoxDecoration(
                        color: AppColor.bodyTemperatureColor,
                        shape: BoxShape.circle),
                    child: Image.asset(
                      Assets.bloodSugar,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(translation(context).bloodSugar,
                        style: AppTextTheme.title4
                            .copyWith(color: Colors.black, fontSize: 17)),
                    const SizedBox(height: 2),
                    Text(
                      DateFormat('HH:mm dd/MM/yyyy')
                          .format(widget.response!.updatedDate!),
                      style: AppTextTheme.title5.copyWith(fontSize: 13),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Row(
                  children: [
                    Text('${widget.response!.bloodSugar}',
                        style: AppTextTheme.body1.copyWith(
                            fontSize: 50, fontWeight: FontWeight.w400)),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('mg/dL',
                          style: AppTextTheme.title5.copyWith(fontSize: 15)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
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
