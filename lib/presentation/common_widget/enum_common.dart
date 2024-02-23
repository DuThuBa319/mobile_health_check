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

const baseUrl = 'https://mobilehealthcareapplication.azurewebsites.net';
Map<String, String> url = {
  'baseUrl': 'https://mobilehealthcareapplication.azurewebsites.net',
  'bloodPressureURL':
      'https://healthcareflaskserver.azurewebsites.net/api/bloodpressure?code=Y_yOotpq8N47XkQt72U3YbXsCpYswimJyD53RdfK9QyqAzFuh9FZmw%3D%3D',
  'testURL':
      'https://healthcareflaskserver.azurewebsites.net/api/bloodglucose?code=ThrTxAvwncnoT4Oom96r9PfautLJmWE3aj9oWJ3CoZ7SAzFucK_3sg%3D%3D',
  'bloodSugarURL':
      'https://healthcareflaskserver.azurewebsites.net/api/bloodglucose?code=ThrTxAvwncnoT4Oom96r9PfautLJmWE3aj9oWJ3CoZ7SAzFucK_3sg%3D%3D',
  'tempURL':
      'https://healthcareflaskserver.azurewebsites.net/api/bodytemperature?code=Z78LX0hzvK6Xwo-ZXzuKBbhqMXPMMKkQ3wQvsshTnQQVAzFucGdW1g%3D%3D',
  'oxiURL':
      'https://healthcareflaskserver.azurewebsites.net/api/oxygen?code=IZw7K5c8YQRodIXKkZRCpwtitnOQMYsNfhbKZNzNWg3iAzFuOithlA%3D%3D'
};

enum UserRole { doctor, patient, relative, admin }

enum ToastStatus { loading, success, error }
