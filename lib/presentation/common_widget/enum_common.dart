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

const baseUrl = 'https://mobilehealthcare.azurewebsites.net/';
Map<String, String> url = {
  'baseUrl': 'https://mobilehealthcare.azurewebsites.net/',
  'bloodPressureURL':
      'https://flask-server.azurewebsites.net/api/bloodpressure?code=VsvpcH9u0z8Wlo4EBEqBg9LlUE0x37h65w5QZdu2Pb74AzFux8d7gQ%3D%3D',
  'testURL': '',
  'bloodSugarURL':
      'https://flask-server.azurewebsites.net/api/bloodglucose?code=7s34g-FdGx_VRWYQHkCvb55Zv4mkXOgECRhsqmnzqtBrAzFua74kWA%3D%3D',
  'tempURL':
      'https://flask-server.azurewebsites.net/api/bodytemperature?code=Za4DcoO9bc5IMMUnBDMqWR8QY8r9dvg4VoMD_tdph7xrAzFuE31tfA%3D%3D',
  'oxiURL':
      'https://flask-server.azurewebsites.net/api/oxygen?code=dbUecZAtJzt_snPDrNohMJr27Tj5u0y5LvDodmFlnFxtAzFukHuD_w%3D%3D'
};

enum UserRole { doctor, patient, relative, admin }
