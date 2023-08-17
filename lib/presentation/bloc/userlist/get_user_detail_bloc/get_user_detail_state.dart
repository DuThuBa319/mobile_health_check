// part of 'get_user_detail_bloc.dart';

// // ViewModel is used for store all properties which want to be stored, processed and updated, chứa dữ liệu của 1 state
// class _ViewModel {
//   final UserEntity? userDetailEntity;
//   const _ViewModel({
//     this.userDetailEntity,
//   });

//   // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
//   _ViewModel copyWith({
//     UserEntity? userDetailEntity,
//   }) {
//     return _ViewModel(
//         userDetailEntity: userDetailEntity ?? this.userDetailEntity);
//   }
// }

// // Abstract class
// abstract class GetUserDetailState {
//   final _ViewModel viewModel;
//   // Status of the state. GetUserDetail "success" "failed" "loading"
//   final BlocStatusState status;

//   GetUserDetailState(this.viewModel, {this.status = BlocStatusState.initial});

//   // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
//   // "T" is generic class. "T" is a child class of GetUserDetailState (abstract class)
//   T copyWith<T extends GetUserDetailState>({
//     _ViewModel? viewModel,
//     required BlocStatusState status,
//   }) {
//     return _factories[T == GetUserDetailState ? runtimeType : T]!(
//       viewModel ?? this.viewModel,
//       status,
//     );
//   }
// }

// class GetUserDetailInitialState extends GetUserDetailState {
//   GetUserDetailInitialState({
//     _ViewModel viewModel =
//         const _ViewModel(), //ViewModel là dữ liệu trong state
//     BlocStatusState status = BlocStatusState.initial, //status của state
//   }) : super(viewModel);
// }

// class GetDetailUserState extends GetUserDetailState {
//   GetDetailUserState({
//     _ViewModel viewModel = const _ViewModel(),
//     BlocStatusState status = BlocStatusState.initial,
//   }) : super(viewModel, status: status);
// }

// class UpdateUserState extends GetUserDetailState {
//   UpdateUserState({
//     _ViewModel viewModel = const _ViewModel(),
//     BlocStatusState status = BlocStatusState.initial,
//   }) : super(viewModel, status: status);
// }

// class DeleteUserState extends GetUserDetailState {
//   DeleteUserState({
//     _ViewModel viewModel = const _ViewModel(),
//     BlocStatusState status = BlocStatusState.initial,
//   }) : super(viewModel, status: status);
// }

// final _factories = <
//     Type,
//     Function(
//   _ViewModel viewModel,
//   BlocStatusState status,
// )>{
//   GetUserDetailInitialState: (viewModel, status) => GetUserDetailInitialState(
//         viewModel: viewModel,
//         status: status,
//       ),
//   GetDetailUserState: (viewModel, status) => GetDetailUserState(
//         viewModel: viewModel,
//         status: status,
//       ),
//   UpdateUserState: (viewModel, status) => UpdateUserState(
//         viewModel: viewModel,
//         status: status,
//       ),
//   DeleteUserState: (viewModel, status) => DeleteUserState(
//         viewModel: viewModel,
//         status: status,
//       ),
// };
