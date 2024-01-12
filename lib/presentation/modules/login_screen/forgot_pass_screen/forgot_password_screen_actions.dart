// ignore_for_file: use_build_context_synchronously

part of 'forgot_password_screen.dart';

// ignore: library_private_types_in_public_api
extension ForgotPassAction on _ForgotPassState {
  Future<void> _blocListener(
      BuildContext context, LoginState state) async {
    //? Loading
    if (state.status == BlocStatusState.loading) {
      if (state is ResetPasswordState) {
        showLoadingDialog(context: context);
      }
    }
    //? Success
    if (state.status == BlocStatusState.success) {
      if (state is ResetPasswordState) {
        showSuccessDialog(
            onClose: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            contentDialogSize: SizeConfig.screenWidth * 0.04,
            context: context,
            message:
                "${translation(context).resetPassSuccessText} ${_phoneNumberController.text}. ${translation(context).tryLoggingAgain}",
            title: translation(context).resetPasswordSuccessfully,
            titleBtn: translation(context).exit);
      }
    }
    //? Failure
    if (state.status == BlocStatusState.failure) {
      if (state is ResetPasswordState) {
        if (state.viewModel.errorMessage ==
                translation(context).wrongPhoneNumber ||
            state.viewModel.errorMessage ==
                translation(context).pleaseEnterPhoneNumber) {
          Navigator.pop(context);
        }
        if (state.viewModel.errorMessage !=
                translation(context).wrongPhoneNumber &&
            state.viewModel.errorMessage !=
                translation(context).pleaseEnterPhoneNumber) {
          showExceptionDialog(
              context: context,
              message: translation(context).error,
              titleBtn: translation(context).exit);
        }
        if (state.viewModel.errorMessage ==
            translation(context).wifiDisconnect) {
          showExceptionDialog(
              context: context,
              message: translation(context).wifiDisconnect,
              titleBtn: translation(context).exit);
        }
      }
    }
  }
}
