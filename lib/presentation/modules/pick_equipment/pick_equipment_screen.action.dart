part of 'pick_equipment_screen.dart';

extension PickEquipmentScreenAction on _PickEquipmentScreenState {
  _onWillPop(bool didPop) async {
    bool enableToPop = true;

    if (enableToPop == true) {
      await showWarningDialog(
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
