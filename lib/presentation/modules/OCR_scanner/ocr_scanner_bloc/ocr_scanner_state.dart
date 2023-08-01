part of 'ocr_scanner_bloc.dart';

class _ViewModel {
  final File? imageFile;
  final int? sys;
  final int? dia;
  final int? pulse;
  const _ViewModel({this.imageFile, this.dia, this.pulse, this.sys});

  _ViewModel copyWith({File? imageFile, int? sys, int? dia, int? pulse}) {
    return _ViewModel(
      imageFile: imageFile ?? this.imageFile,
      sys: sys ?? this.sys,
      dia: dia ?? this.dia,
      pulse: pulse ?? this.pulse,
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

class GetDataState extends OCRScannerState {
  GetDataState({
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
  GetDataState: (viewModel, status) => GetDataState(
        viewModel: viewModel,
        status: status,
      ),
};
