part of 'ocr_scanner_bloc.dart';

@immutable
abstract class OCRScannerEvent {}

class GetDataEvent extends OCRScannerEvent {
  final BuildContext context;
  GetDataEvent({required this.context});
}
