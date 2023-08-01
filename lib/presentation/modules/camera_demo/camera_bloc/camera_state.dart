part of 'camera_bloc.dart';

class _ViewModel {
  final File? imageFile;
  const _ViewModel({this.imageFile});

  _ViewModel copyWith({File? imageFile}) {
    return _ViewModel(imageFile: imageFile ?? this.imageFile);
  }
}

// Abstract class
abstract class CameraState {
  // ignore: library_private_types_in_public_api
  final _ViewModel viewModel;
  // Status of the state. Camera "success" "failed" "loading"
  final BlocStatusState status;

  CameraState(this.viewModel, {this.status = BlocStatusState.initial});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  // "T" is generic class. "T" is a child class of CameraState (abstract class)
  T copyWith<T extends CameraState>({
    // ignore: library_private_types_in_public_api
    _ViewModel? viewModel,
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
    _ViewModel viewModel =
        const _ViewModel(), //ViewModel là dữ liệu trong state
    BlocStatusState status = BlocStatusState.initial, //status của state
  }) : super(viewModel);
}

class GetImageState extends CameraState {
  GetImageState({
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
  CameraInitialState: (viewModel, status) => CameraInitialState(
        viewModel: viewModel,
        status: status,
      ),
  GetImageState: (viewModel, status) => GetImageState(
        viewModel: viewModel,
        status: status,
      ),
};
