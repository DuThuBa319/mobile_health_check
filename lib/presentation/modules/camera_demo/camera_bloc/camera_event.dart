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
