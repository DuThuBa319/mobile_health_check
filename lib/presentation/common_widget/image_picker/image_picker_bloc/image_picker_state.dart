part of 'image_picker_bloc.dart';

// ViewModel is used for store all properties which want to be stored, processed and updated
class _ViewModel {
  final List<File>? imageFiles;
  final List<String>? imageUrls;
  const _ViewModel({
    this.imageFiles,
    this.imageUrls,
  });

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  _ViewModel copyWith({
    List<File>? imageFiles,
    List<String>? imageUrls,
  }) {
    return _ViewModel(
      imageFiles: imageFiles ?? this.imageFiles,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }
}

// Abstract class
abstract class ImagePickerState {
  final _ViewModel viewModel;
  // Status of the state. Schedule "success" "failed" "loading"
  final BlocStatusState status;

  ImagePickerState(this.viewModel, {this.status = BlocStatusState.initial});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  // "T" is generic class. "T" is a child class of ImagePickerState (abstract class)
  T copyWith<T extends ImagePickerState>({
    _ViewModel? viewModel,
    required BlocStatusState status,
  }) {
    return _factories[T == ImagePickerState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
      status,
    );
  }
}

class ImagePickerInitialState extends ImagePickerState {
  ImagePickerInitialState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel);
}

class GetImageState extends ImagePickerState {
  GetImageState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class LoadImageState extends ImagePickerState {
  LoadImageState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
  BlocStatusState status,
)>{
  ImagePickerInitialState: (viewModel, status) => ImagePickerInitialState(
        viewModel: viewModel,
        status: status,
      ),
  GetImageState: (viewModel, status) => GetImageState(
        viewModel: viewModel,
        status: status,
      ),
  LoadImageState: (viewModel, status) => LoadImageState(
        viewModel: viewModel,
        status: status,
      ),
};
