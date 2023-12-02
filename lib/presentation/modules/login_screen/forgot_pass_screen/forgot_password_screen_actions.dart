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
        state.status == BlocStatusState.failure) {
      if ((state.viewModel.errorMessage ==
              translation(context).wrongPhoneNumber) ||
          (state.viewModel.errorMessage ==
              translation(context).pleaseEnterPhoneNumber)) {
        Navigator.pop(context);
        if (state.viewModel.errorMessage ==
            translation(context).wifiDisconnect) {
          showExceptionDialog(
              context: context,
              message: translation(context).wifiDisconnect,
              titleBtn: translation(context).exit);
        }
      }
      if ((state.viewModel.errorMessage !=
              translation(context).wrongPhoneNumber &&
          state.viewModel.errorMessage !=
              translation(context).pleaseEnterPhoneNumber)) {
        showExceptionDialog(
            context: context,
            message: translation(context).error,
            titleBtn: translation(context).exit);
      }
    }

    if (state is ResetPasswordState &&
        state.status == BlocStatusState.success) {
      showSuccessDialog(
          onClose: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          context: context,
          message: translation(context).resetPassSuccessText,
          title: translation(context).resetPasswordSuccessfully,
          titleBtn: translation(context).exit);
    }
  }
}

