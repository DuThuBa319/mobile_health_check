// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../presentation/common_widget/assets.dart';
import '../../presentation/common_widget/enum_common.dart';
import '../../presentation/theme/theme_color.dart';

class HourlyTemperatureEntity {
  String? time;
  double? temperature2m;
  int? relativeHumidity2m;
  int? weatherCode;

  HourlyTemperatureEntity({
    this.time,
    this.temperature2m,
    this.relativeHumidity2m,
    this.weatherCode,
  });

  WeatherWithTimeStatus get weatherWithTimeStatus {
    final hour = dateTime!.hour;
    if (hour > 6 && hour <= 18) {
      // Based on WMO Weather interpretation codes (WW)
      switch (weatherCode) {
        case 0:
        case 1:
        case 2:
        case 3:
          return WeatherWithTimeStatus.morningSunny;
        case 80:
        case 81:
        case 82:
          return WeatherWithTimeStatus.morningRainy;
        case 45:
        case 48:
          return WeatherWithTimeStatus.morningFoggy;
        case 95:
        case 96:
          return WeatherWithTimeStatus.morningThunderStorm;
        default:
          return WeatherWithTimeStatus.undefine;
      }
    } else {
      switch (weatherCode) {
        case 0:
        case 1:
        case 2:
        case 3:
          return WeatherWithTimeStatus.nightClear;
        case 80:
        case 81:
        case 82:
          return WeatherWithTimeStatus.nightRainy;
        case 45:
        case 48:
          return WeatherWithTimeStatus.nightFoggy;
        case 95:
        case 96:
          return WeatherWithTimeStatus.nightThunderStorm;
        default:
          return WeatherWithTimeStatus.undefine;
      }
    }
  }

  String get weatherTitle {
    switch (weatherWithTimeStatus) {
      case WeatherWithTimeStatus.morningSunny:
        return 'Sáng - Nắng đẹp';
      case WeatherWithTimeStatus.morningRainy:
        return 'Sáng - Mưa rào';
      case WeatherWithTimeStatus.morningThunderStorm:
        return 'Sáng - Sấm chớp';
      case WeatherWithTimeStatus.morningFoggy:
        return 'Sáng - Sương mù';
      case WeatherWithTimeStatus.nightClear:
        return 'Tối - Trăng sáng';
      case WeatherWithTimeStatus.nightRainy:
        return 'Tối - mưa rào';
      case WeatherWithTimeStatus.nightThunderStorm:
        return 'Tối - Sấm chớp';
      case WeatherWithTimeStatus.nightFoggy:
        return 'Tối - Sương mù';
      default:
        return 'Chưa xác định';
    }
  }

  String get weatherIcon {
    switch (weatherWithTimeStatus) {
      case WeatherWithTimeStatus.morningSunny:
        return Assets.icSunny;
      case WeatherWithTimeStatus.morningRainy:
        return Assets.morningRainy;
      case WeatherWithTimeStatus.morningThunderStorm:
        return Assets.morningThunderStorm;
      case WeatherWithTimeStatus.morningFoggy:
        return Assets.morningFoggy;
      case WeatherWithTimeStatus.nightClear:
        return Assets.icMoon;
      case WeatherWithTimeStatus.nightRainy:
        return Assets.nightRainy;
      case WeatherWithTimeStatus.nightThunderStorm:
        return Assets.nightThunderStorm;
      case WeatherWithTimeStatus.nightFoggy:
        return Assets.nightFoggy;
      default:
        return Assets.icSunny; //undefinde
    }
  }

  DateTime? get dateTime {
    if (time == null) {
      return null;
    } else {
      final parsedDateTime = DateTime.parse(time!);
      final hourMinuteDateTime = DateTime(
        parsedDateTime.year,
        parsedDateTime.month,
        parsedDateTime.day,
        parsedDateTime.hour,
        parsedDateTime.minute,
      );
      return hourMinuteDateTime;
    }
  }

  String get dateDisplay {
    if (dateTime == null) {
      return '';
    } else {
      final month = dateTime!.month.toString();
      final day = dateTime!.day.toString();

      final year = dateTime!.year.toString();
      final hour = dateTime!.hour.toString().padLeft(2, '0');
      final minute = dateTime!.minute.toString().padLeft(2, '0');
      return '$year-$month-$day  ${hour}h:${minute}m';
    }
  }

  // String get temperatureDisplay {
  //   if (temperature2m == null) {
  //     return '-- °C';
  //   } else {
  //     final temperature = temperature2m!.toStringAsFixed(1);
  //     return '$temperature °C';
  //   }
  // }

  String get temperatureAndHumidityDisplay {
    if (temperature2m == null || relativeHumidity2m == null) {
      return '-- °C, --%';
    } else {
      final temperature = temperature2m!.toStringAsFixed(1);
      final humidity = relativeHumidity2m!.toString();
      return '$temperature °C, $humidity%';
    }
  }

  Color get weatherColor {
    switch (weatherWithTimeStatus) {
      case WeatherWithTimeStatus.morningSunny:
        return AppColor.yellowFFF59D;
      case WeatherWithTimeStatus.morningRainy:
        return AppColor.blue81D4FA;
      case WeatherWithTimeStatus.morningThunderStorm:
        return AppColor.graybebebe;
      case WeatherWithTimeStatus.morningFoggy:
        return AppColor.graydcdcdc;

      case WeatherWithTimeStatus.nightClear:
        return const Color.fromARGB(255, 122, 37, 158);
      case WeatherWithTimeStatus.nightRainy:
        return AppColor.blue4169E1;
      case WeatherWithTimeStatus.nightThunderStorm:
        return AppColor.gray767676;
      case WeatherWithTimeStatus.nightFoggy:
        return AppColor.graydcdcdc;
      default:
        return AppColor.graydcdcdc;
    }
  }
}
