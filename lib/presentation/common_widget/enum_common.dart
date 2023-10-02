import 'dart:io';

enum BlocStatusState { initial, loading, success, failure }

enum WeatherStatus { sunny, rainy, foggy, thunderStorm, undefine }

enum WeatherWithTimeStatus {
  morningSunny,
  morningRainy,
  morningThunderStorm,
  morningFoggy,
  nightRainy,
  nightFoggy,
  nightThunderStorm,
  undefine,
  nightClear
}

enum Splash { loGo }

enum MeasuringTask { temperature, bloodPressure, bloodSugar, oximeter }

class CroppedImage {
  File croppedImage;
  bool flashOn;
  CroppedImage(this.croppedImage, this.flashOn);
}
const baseUrl = 'https://healthcareapplicationcloud.azurewebsites.net';
