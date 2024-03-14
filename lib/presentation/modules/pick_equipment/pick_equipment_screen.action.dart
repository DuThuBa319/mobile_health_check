part of 'pick_equipment_screen.dart';

// ignore: library_private_types_in_public_api
extension PickEquipmentScreenAction on _PickEquipmentScreenState {
  _onWillPop(bool didPop) async {
    bool enableToPop = true;

    if (enableToPop == true) {
      await showWarningDialog(
          contentDialogSize: SizeConfig.screenDiagonal < 1350
              ? SizeConfig.screenWidth * 0.04
              : SizeConfig.screenWidth * 0.045,
          context: context,
          message: translation(context).areYouSureToExitApp,
          title: translation(context).exitAppTitle,
          onClose1: () {},
          onClose2: () {
            SystemNavigator.pop();
          });
    }
  }
}
