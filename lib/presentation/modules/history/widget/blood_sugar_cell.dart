import 'package:common_project/domain/entities/blood_sugar_entity.dart';
import 'package:common_project/presentation/modules/history/bloc/history_bloc.dart';
import 'package:common_project/presentation/modules/history/sub_screen/blood_sugar_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common_widget/assets.dart';
import '../../../theme/app_text_theme.dart';
import '../../../theme/theme_color.dart';

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
            color: const Color.fromARGB(255, 193, 232, 255),
            borderRadius: BorderRadius.circular(20),
            // boxShadow: const [
            //   BoxShadow(
            //     blurRadius: 15,
            //     color: Colors.black26,
            //   )
            // ]
          ),
          height: screenSize.height * 0.15,
          width: screenSize.width,
          margin: const EdgeInsets.fromLTRB(0, 10, 20, 10),
          padding: const EdgeInsets.only(top: 10, left: 12, right: 12),
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
                        decoration: BoxDecoration(
                            color: AppColor.bloodPressureColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.black26,
                              )
                            ]),
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
                        Text('ĐO HUYẾT ÁP',
                            style: AppTextTheme.title4
                                .copyWith(color: Colors.black)),
                        const SizedBox(height: 2),
                        Text(
                          DateFormat('hh:mm dd/MM/yyyy')
                              .format(widget.response!.updatedDate!),
                          style: AppTextTheme.title5.copyWith(fontSize: 10),
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
                SizedBox(width: screenSize.width * 0.65),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${widget.response!.bloodSugar}',
                        style: AppTextTheme.body1.copyWith(
                            fontSize: 30, fontWeight: FontWeight.w400)),
                    Text('mg/dL',
                        style: AppTextTheme.body1.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w400)),
                  ],
                ),
                const SizedBox(width: 20),
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
