import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';

import '../../../classes/language.dart';
import '../../../common/singletons.dart';
import '../../../utils/size_config.dart';
import '../../modules/notification_onesignal/bloc/notification_bloc.dart';
import '../../route/route_list.dart';
import '../enum_common.dart';

class CustomScreenForm extends StatefulWidget {
  final bool? isShowBottomNayvigationBar;
  final bool isShowAppBar;
  final Color? appBarColor;
  final Color? backgroundColor;
  final Color? appComponentColor;
  final bool isShowLeadingButton;
  final Widget? leadingButton;
  final int? selectedIndex;
  final String? title;
  final Widget child;
  final bool? isScrollable;
  final bool isShowRightButon;
  final Widget? rightButton;
  final String? unreadCount;
  final String? messageBody;
  final NotificationBloc? notificationBloc;
  final Widget? floatActionButton;
  const CustomScreenForm(
      {super.key,
      this.notificationBloc,
      this.messageBody,
      this.unreadCount,
      this.appBarColor = Colors.black,
      this.backgroundColor = Colors.white,
      this.appComponentColor = Colors.white,
      this.isShowBottomNayvigationBar,
      this.isShowAppBar = true,
      required this.child,
      this.isShowLeadingButton = false,
      this.leadingButton,
      this.selectedIndex = -1,
      this.isScrollable = false,
      this.title,
      this.isShowRightButon = false,
      this.rightButton,
      this.floatActionButton});

  @override
  State<CustomScreenForm> createState() => _CustomScreenFormState();
}

class _CustomScreenFormState extends State<CustomScreenForm> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    // ignore: unused_element

    return Scaffold(
      backgroundColor: widget.backgroundColor,
//app bar ---------------------------------------
      appBar: widget.isShowAppBar
          ? AppBar(
              toolbarHeight: SizeConfig.screenHeight * 0.055,
              backgroundColor: widget.appBarColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: widget.isShowLeadingButton
                  ? widget.leadingButton ??
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: SizeConfig.screenHeight * 0.04,
                          color: widget.appComponentColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                  : null,
              centerTitle: true,
              title: Text(
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                widget.title!,
                style: AppTextTheme.title1.copyWith(
                    color: widget.appComponentColor,
                    fontSize: SizeConfig.screenDiagonal < 1350
                        ? SizeConfig.screenWidth * 0.065
                        : SizeConfig.screenWidth * 0.058),
              ),
              actions: [
                (userDataData.getUser()?.role == UserRole.admin ||
                        userDataData.getUser()?.role == UserRole.doctor)
                    ? widget.isShowRightButon
                        ? widget.rightButton ??
                            SizedBox(
                              height: SizeConfig.screenWidth * 0.005,
                              width: SizeConfig.screenWidth * 0.005,
                            )
                        : SizedBox(
                            height: SizeConfig.screenWidth * 0.005,
                            width: SizeConfig.screenWidth * 0.005,
                          )
                    : SizedBox(
                        height: SizeConfig.screenWidth * 0.005,
                        width: SizeConfig.screenWidth * 0.005,
                      )
              ],
            )
          : null,
// body --------------------------------------
      body: SafeArea(
          child: widget.isScrollable == true
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: widget.child,
                )
              : widget.child),
// bottom app bar -------------------------
      bottomNavigationBar: widget.isShowBottomNayvigationBar == true
          ? BottomAppBar(
              height: SizeConfig.screenHeight * 0.08,
              surfaceTintColor: AppColor.white,
              color: AppColor.white,
              elevation: 40,
              notchMargin: 5,
              child: Row(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  iconBottomBar(
                      label: (userDataData.getUser()?.role == UserRole.patient)
                          ? translation(context).selectEquip
                          : translation(context).homeScreen,
                      iconData: Icons.home_filled,
                      isSelected: widget.selectedIndex == 0 ? true : false,
                      iconIndex: 0),
                  iconBottomBar(
                      label: translation(context).settingScreen,
                      iconData: Icons.settings_sharp,
                      isSelected: widget.selectedIndex == 1 ? true : false,
                      iconIndex: 1),
                ],
              ),
            )
          : null,

      floatingActionButton: (userDataData.getUser()?.role == UserRole.doctor ||
              userDataData.getUser()?.role == UserRole.admin)
          ? widget.floatActionButton
          : null,
    );
  }

  Widget iconBottomBar(
      {String? label,
      required IconData iconData,
      required bool isSelected,
      required int iconIndex}) {
    return GestureDetector(
      onTap: () {
        _onItemTapped(iconIndex);
      },
      child: Container(
        color: Colors.white,
        height: SizeConfig.screenHeight * 0.055,
        width: SizeConfig.screenWidth * 0.45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              iconData,
              color: isSelected
                  ? const Color.fromARGB(255, 123, 211, 255)
                  : AppColor.gray767676,
              size: SizeConfig.screenHeight * 0.02,
            ),
            label != null
                ? Text(
                    label,
                    style: TextStyle(
                        color: isSelected
                            ? const Color.fromARGB(255, 123, 211, 255)
                            : AppColor.gray767676,
                        fontSize: SizeConfig.screenHeight * 0.018,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index == 0 && index != widget.selectedIndex) {
      if ((userDataData.getUser()!.role == UserRole.doctor ||
          userDataData.getUser()!.role == UserRole.relative)) {
        Navigator.pushNamedAndRemoveUntil(
            context,
            RouteList.patientList,
            arguments: userDataData.getUser()!.id!,
            (route) => false);
      } else if (userDataData.getUser()!.role == UserRole.admin) {
        Navigator.pushNamedAndRemoveUntil(
            context,
            RouteList.doctorList,
            arguments: userDataData.getUser()!.id!,
            (route) => false);
      } else if (userDataData.getUser()!.role == UserRole.patient) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteList.selectEquip, (route) => false);
      }
    }
    if (index == 1 && index != widget.selectedIndex) {
      if (widget.selectedIndex == 0) {
        Navigator.pushNamed(context, RouteList.settingMenu);
      } else {
        Navigator.pushReplacementNamed(context, RouteList.settingMenu);
      }
    }
  }
}
