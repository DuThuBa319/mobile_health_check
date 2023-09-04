part of 'camera_bloc.dart';

class ViewModel {
  final File? imageFile;
  final CameraController? cameraController;
  const ViewModel({this.imageFile, this.cameraController});

  ViewModel copyWith({File? imageFile, CameraController? cameraController}) {
    return ViewModel(
        imageFile: imageFile ?? this.imageFile,
        cameraController: cameraController ?? this.cameraController);
  }
}

// Abstract class
abstract class CameraState {
  // ignore: library_private_types_in_public_api
  final ViewModel viewModel;
  // Status of the state. Camera "success" "failed" "loading"
  final BlocStatusState status;

  CameraState(this.viewModel, {this.status = BlocStatusState.initial});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  // "T" is generic class. "T" is a child class of CameraState (abstract class)
  T copyWith<T extends CameraState>({
    // ignore: library_private_types_in_public_api
    ViewModel? viewModel,
    required BlocStatusState status,
  }) {
    return _factories[T == CameraState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
      status,
    );
  }
}

class CameraInitialState extends CameraState {
  CameraInitialState({
    // ignore: library_private_types_in_public_api
    ViewModel viewModel = const ViewModel(), //ViewModel là dữ liệu trong state
    BlocStatusState status = BlocStatusState.initial, //status của state
  }) : super(viewModel);
}

class CameraReadyState extends CameraState {
  CameraReadyState({
    // ignore: library_private_types_in_public_api
    ViewModel viewModel = const ViewModel(), //ViewModel là dữ liệu trong state
    BlocStatusState status = BlocStatusState.initial, //status của state
  }) : super(viewModel, status: status);
}

class CameraStoppedState extends CameraState {
  CameraStoppedState({
    // ignore: library_private_types_in_public_api
    ViewModel viewModel = const ViewModel(), //ViewModel là dữ liệu trong state
    BlocStatusState status = BlocStatusState.initial, //status của state
  }) : super(viewModel, status: status);
}

class GetImageState extends CameraState {
  GetImageState({
    // ignore: library_private_types_in_public_api
    ViewModel viewModel = const ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class UpdateUiState extends CameraState {
  UpdateUiState({
    // ignore: library_private_types_in_public_api
    ViewModel viewModel = const ViewModel(), //ViewModel là dữ liệu trong state
    BlocStatusState status = BlocStatusState.initial, //status của state
  }) : super(viewModel, status: status);
}

final _factories = <Type,
    Function(
  ViewModel viewModel,
  BlocStatusState status,
)>{
  CameraInitialState: (viewModel, status) => CameraInitialState(
        viewModel: viewModel,
        status: status,
      ),
  CameraStoppedState: (viewModel, status) => CameraStoppedState(
        viewModel: viewModel,
        status: status,
      ),
  GetImageState: (viewModel, status) => GetImageState(
        viewModel: viewModel,
        status: status,
      ),
  CameraReadyState: (viewModel, status) => CameraReadyState(
        viewModel: viewModel,
        status: status,
      ),
  UpdateUiState: (viewModel, status) => UpdateUiState(
        viewModel: viewModel,
        status: status,
      ),
};
