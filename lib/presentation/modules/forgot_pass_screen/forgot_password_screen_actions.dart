// ignore_for_file: use_build_context_synchronously

part of 'forgot_password_screen.dart';

// ignore: library_private_types_in_public_api
extension ForgotPassAction on _ForgotPassState {
  Future<void> _blocForgotPassListener(
      BuildContext context, LoginState state) async {
    if (state is ResetPasswordState &&
        state.status == BlocStatusState.loading) {
      showLoadingDialog(context: context);
    }

    if (state is ResetPasswordState &&
        state.status == BlocStatusState.failure &&
        ((state.viewModel.errorMessage1 ==
                translation(context).wrongPhoneNumber) ||
            (state.viewModel.errorMessage1 ==
                translation(context).pleaseEnterPhoneNumber))) {
      Navigator.pop(context);
    }

    if (state is ResetPasswordState &&
        state.status == BlocStatusState.success) {
      showNoticeDialog(
          onClose: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          context: context,
          message: translation(context).resetPasswordSuccessfully,
          title: translation(context).notification,
          titleBtn: translation(context).exit);
    }

    if (state is WifiDisconnectState &&
        state.status == BlocStatusState.success) {
      showNoticeDialog(
          context: context,
          message: translation(context).wifiDisconnect,
          title: translation(context).notification,
          titleBtn: translation(context).exit);
    }
  }
}
