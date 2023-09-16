part of 'ocr_scanner_bloc.dart';

class _ViewModel {
  final File? bloodPressureImageFile;
  final File? bloodGlucoseImageFile;
  final File? oximeterImageFile;
  final File? temperatureImageFile;
  final BloodPressureEntity? bloodPressureEntity;
  final BloodSugarEntity? bloodSugarEntity;
  final TemperatureEntity? temperatureEntity;

  const _ViewModel({
    this.oximeterImageFile,
    this.bloodGlucoseImageFile,
    this.bloodPressureImageFile,
    this.bloodPressureEntity,
    this.bloodSugarEntity,
    this.temperatureEntity,
    this.temperatureImageFile,
  });

  _ViewModel copyWith({
    File? oximeterImageFile,
    File? bloodPressureImageFile,
    File? bloodGlucoseImageFile,
    File? temperatureImageFile,
    BloodPressureEntity? bloodPressureEntity,
    BloodSugarEntity? bloodSugarEntity,
    TemperatureEntity? temperatureEntity,
  }) {
    return _ViewModel(
      oximeterImageFile: oximeterImageFile?? this.oximeterImageFile,
      bloodPressureImageFile:
          bloodPressureImageFile ?? this.bloodPressureImageFile,
      bloodGlucoseImageFile:
          bloodGlucoseImageFile ?? this.bloodGlucoseImageFile,
      temperatureImageFile: temperatureImageFile ?? this.temperatureImageFile,
      bloodPressureEntity: bloodPressureEntity ?? bloodPressureEntity,
      bloodSugarEntity: bloodSugarEntity ?? bloodSugarEntity,
      temperatureEntity: temperatureEntity ?? temperatureEntity,
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

class UploadBloodGlucoseDataState extends OCRScannerState {
  UploadBloodGlucoseDataState({
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

class UploadTemperatureDataState extends OCRScannerState {
  UploadTemperatureDataState({
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
  UploadBloodGlucoseDataState: (viewModel, status) =>
      UploadBloodGlucoseDataState(
        viewModel: viewModel,
        status: status,
      ),
  UploadTemperatureDataState: (viewModel, status) => UploadTemperatureDataState(
        viewModel: viewModel,
        status: status,
      ),
};
