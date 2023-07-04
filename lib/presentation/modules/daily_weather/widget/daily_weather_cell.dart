// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:common_project/domain/entities/daily_weather_entity.dart';
import 'package:flutter/material.dart';

import '../../../common_widget/assets.dart';
import '../../../theme/app_text_theme.dart';

class DailyWeatherCell extends StatefulWidget {
  final DailyWeatherEntity? weatherEntity;
  const DailyWeatherCell({
    Key? key,
    this.weatherEntity,
  }) : super(key: key);

  @override
  State<DailyWeatherCell> createState() => _DailyWeatherCellState();
}

class _DailyWeatherCellState extends State<DailyWeatherCell> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.weatherEntity?.weatherColor ?? Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            widget.weatherEntity?.dateDisplay ?? '--',
            style: AppTextTheme.title4,
          ),
          Text(
            widget.weatherEntity?.weatherTitle ?? '--',
            style: AppTextTheme.body3,
          ),
          Image.asset(
            widget.weatherEntity?.weatherIcon ?? Assets.icSunny,
            width: 50,
            height: 50,
          )
        ],
      ),
    );
  }
}
