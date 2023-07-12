part of 'image_picker_bloc.dart';

@immutable
abstract class ImagePickerEvent {}

class GetImageEvent extends ImagePickerEvent {
  GetImageEvent({this.source});
  final ImageSource? source;
}

class DeleteImageEvent extends ImagePickerEvent {
  DeleteImageEvent({this.index});
  final int? index;
}

class ReplaceImageEvent extends ImagePickerEvent {
  ReplaceImageEvent({this.source, this.index});
  ImageSource? source;
  int? index;
}

class LoadImageEvent extends ImagePickerEvent {
  LoadImageEvent({this.imageFiles});
  final List<File>? imageFiles;
}
