part of 'camera_bloc.dart';

@immutable
abstract class CameraEvent {}

class GetImageEvent extends CameraEvent {
  final CameraController controller;
  final BuildContext context;
  final MeasuringTask task;
  GetImageEvent(
      {required this.controller, required this.context, required this.task});
}

class CameraInitializedEvent extends CameraEvent {
  final CameraController controller;
  final BuildContext context;
  final MeasuringTask task;
  final double zoomValue;
  CameraInitializedEvent(
      {required this.controller,
      required this.context,
      required this.task,
      required this.zoomValue});
}

class CameraStoppedEvent extends CameraEvent {
  final CameraController controller;
  final BuildContext context;
  final MeasuringTask task;
  CameraStoppedEvent(
      {required this.controller, required this.context, required this.task});
}

class CameraUpdateUiEvent extends CameraEvent {
  final double? exposureValue;
  CameraUpdateUiEvent({this.exposureValue});
}
