part of 'ocr_scanner_bloc.dart';

class _ViewModel {
  final File? bloodPressureImageFile;
  final File? bloodGlucoseImageFile;
  final File? temperatureImageFile;
  final int? sys;
  final int? dia;
  final int? pulse;
  final double? temperature;
  final int? glucose;
  final int? listBloodPressureLength;
  const _ViewModel(
      {this.bloodGlucoseImageFile,
      this.bloodPressureImageFile,
      this.glucose,
      this.temperature,
      this.temperatureImageFile,
      this.dia,
      this.pulse,
      this.sys,
      this.listBloodPressureLength});

  _ViewModel copyWith(
      {File? bloodPressureImageFile,
      File? bloodGlucoseImageFile,
      File? temperatureImageFile,
      int? sys,
      int? dia,
      int? pulse,
      int? glucose,
      double? temperature,
      int? listBloodPressureLength}) {
    return _ViewModel(
      bloodPressureImageFile:
          bloodPressureImageFile ?? this.bloodPressureImageFile,
      bloodGlucoseImageFile:
          bloodGlucoseImageFile ?? this.bloodGlucoseImageFile,
      temperatureImageFile: temperatureImageFile ?? this.temperatureImageFile,
      sys: sys ?? this.sys,
      dia: dia ?? this.dia,
      pulse: pulse ?? this.pulse,
      temperature: temperature ?? this.temperature,
      glucose: glucose ?? this.glucose,
      listBloodPressureLength:
          listBloodPressureLength ?? this.listBloodPressureLength,
    );
  }
}

// Abstract class
abstract class OCRScannerState {
  // ignore: library_private_types_in_public_api
  final _ViewModel viewModel;
  // Status of the state. OCRScanner "success" "failed" "loading"
  final BlocStatusState status;

  OCRScannerState(this.viewModel, {this.status = BlocStatusState.initial});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  // "T" is generic class. "T" is a child class of OCRScannerState (abstract class)
  T copyWith<T extends OCRScannerState>({
    // ignore: library_private_types_in_public_api
    _ViewModel? viewModel,
    required BlocStatusState status,
  }) {
    return _factories[T == OCRScannerState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
      status,
    );
  }
}

class OCRScannerInitialState extends OCRScannerState {
  OCRScannerInitialState({
    // ignore: library_private_types_in_public_api
    _ViewModel viewModel =
        const _ViewModel(), //ViewModel là dữ liệu trong state
    BlocStatusState status = BlocStatusState.initial, //status của state
  }) : super(viewModel);
}

class GetBloodPressureDataState extends OCRScannerState {
  GetBloodPressureDataState({
    // ignore: library_private_types_in_public_api
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class UploadBloodPressureDataState extends OCRScannerState {
  UploadBloodPressureDataState({
    // ignore: library_private_types_in_public_api
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class GetBloodGlucoseDataState extends OCRScannerState {
  GetBloodGlucoseDataState({
    // ignore: library_private_types_in_public_api
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class GetTemperatureDataState extends OCRScannerState {
  GetTemperatureDataState({
    // ignore: library_private_types_in_public_api
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

final _factories = <Type,
    Function(
  _ViewModel viewModel,
  BlocStatusState status,
)>{
  OCRScannerInitialState: (viewModel, status) => OCRScannerInitialState(
        viewModel: viewModel,
        status: status,
      ),
  GetTemperatureDataState: (viewModel, status) => GetTemperatureDataState(
        viewModel: viewModel,
        status: status,
      ),
  GetBloodGlucoseDataState: (viewModel, status) => GetBloodGlucoseDataState(
        viewModel: viewModel,
        status: status,
      ),
  GetBloodPressureDataState: (viewModel, status) => GetBloodPressureDataState(
        viewModel: viewModel,
        status: status,
      ),
  UploadBloodPressureDataState: (viewModel, status) =>
      UploadBloodPressureDataState(
        viewModel: viewModel,
        status: status,
      ),
};