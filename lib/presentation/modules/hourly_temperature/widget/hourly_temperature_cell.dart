// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../domain/entities/hourly_temperature_entity.dart';
import '../../../common_widget/assets.dart';
import '../../../theme/app_text_theme.dart';

class HourlyTemperatureCell extends StatefulWidget {
  final HourlyTemperatureEntity? temperatureEntity;
  const HourlyTemperatureCell({
    Key? key,
    this.temperatureEntity,
  }) : super(key: key);

  @override
  State<HourlyTemperatureCell> createState() => _HourlyTemperatureCellState();
}

class _HourlyTemperatureCellState extends State<HourlyTemperatureCell> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.temperatureEntity?.weatherColor ?? Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            widget.temperatureEntity?.dateDisplay ?? '--',
            style: AppTextTheme.body4,
          ),
          Text(
            widget.temperatureEntity?.temperatureAndHumidityDisplay ?? '--',
            style: AppTextTheme.body4,
          ),
          Text(
            widget.temperatureEntity?.weatherTitle ?? '--',
            style: AppTextTheme.body4,
          ),
          Image.asset(
            widget.temperatureEntity?.weatherIcon ?? Assets.icSunny,
            width: 40,
            height: 40,
          )
        ],
      ),
    );
  }
}
