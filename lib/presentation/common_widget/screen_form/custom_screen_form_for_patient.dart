import 'package:badges/badges.dart' as badges;
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';

import '../../../classes/language_constant.dart';
import '../../../common/singletons.dart';
import '../../../function.dart';
import '../../route/route_list.dart';

class PatientCustomScreenForm extends StatefulWidget {
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
  final int? unreadCount;

  const PatientCustomScreenForm({
    super.key,
    this.unreadCount,
    this.appBarColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.appComponentColor = Colors.white,
    this.isShowBottomNayvigationBar,
    this.isShowAppBar = true,
    required this.child,
    this.isShowLeadingButton = false,
    this.leadingButton,
    this.selectedIndex,
    this.isScrollable = false,
    this.title,
    this.isShowRightButon = false,
    this.rightButton,
  });

  @override
  State<PatientCustomScreenForm> createState() =>
      _PatientCustomScreenFormState();
}

class _PatientCustomScreenFormState extends State<PatientCustomScreenForm> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: widget.backgroundColor,
//app bar ---------------------------------------
      appBar: widget.isShowAppBar
          ? AppBar(
              backgroundColor: widget.appBarColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: widget.isShowLeadingButton
                  ? widget.leadingButton ??
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: SizeConfig.screenWidth * 0.08,
                          color: widget.appComponentColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                  : null,
              centerTitle: true,
              title: Text(
                widget.title!,
                style: AppTextTheme.title1.copyWith(
                    color: widget.appComponentColor,
                    fontSize: SizeConfig.screenWidth * 0.07),
              ),
              actions: [
                widget.isShowRightButon
                    ? widget.rightButton ??
                        Row(
                          children: [
                            badges.Badge(
                              badgeContent: Text(
                                  "${notificationData.unreadCount}",
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth * 0.02,
                                      color: Colors.white)),
                              child: const Icon(Icons.notifications),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                          ],
                        )
                    : SizedBox(
                        height: SizeConfig.screenWidth * 0.05,
                        width: SizeConfig.screenWidth * 0.05,
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
              color: AppColor.white,
              elevation: SizeConfig.screenWidth * 0.1,
              notchMargin: 5,
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    //      InkWell(
                    //   onTap: () {
                    //     Navigator.pushNamed(context, RouteList.selectEquip);
                    //   },
                    //   child: Container(
                    //       height: 47,
                    //       width: 47,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(30),
                    //         color: const Color.fromARGB(255, 123, 211, 255),
                    //       ),
                    //       child: const Icon(Icons.add,
                    //
                    //        size: 30, color: Colors.white)),
                    // ),
                    iconBottomBar(
                        label: translation(context).selectEquip,
                        iconData: Icons.camera_alt,
                        isSelected: widget.selectedIndex == 0 ? true : false,
                        iconIndex: 0),

                    // badges.Badge(
                    //   showBadge: true,
                    //   badgeStyle: const badges.BadgeStyle(
                    //       elevation: 0, badgeColor: Colors.redAccent),
                    //   position: badges.BadgePosition.topEnd(
                    //       top: -3,
                    //       end: (notificationData.unreadCount ?? 0) < SizeConfig.screenWidth*0.02
                    //           ? 3
                    //           : -3),
                    //   badgeContent:
                    //       Text('${notificationData.unreadCount ?? 0}'),
                    //   child: iconBottomBar(
                    //       label: translation(context).notification,
                    //       iconData: Icons.notifications_none_rounded,
                    //       isSelected: widget.selectedIndex == 1 ? true : false,
                    //       iconIndex: 1),
                    // ),

                    iconBottomBar(
                        label: translation(context).settingScreen,
                        iconData: Icons.settings_sharp,
                        isSelected: widget.selectedIndex == 1 ? true : false,
                        iconIndex: 1),
                  ],
                ),
              ),
            )
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
        padding: EdgeInsets.only(
          top: SizeConfig.screenHeight * 0.005,
        ),
        height: SizeConfig.screenHeight / 15,
        child: Column(
          children: [
            Icon(
              iconData,
              color: isSelected
                  ? const Color.fromARGB(255, 123, 211, 255)
                  : AppColor.gray767676,
              size: SizeConfig.screenWidth * 0.07,
            ),
            label != null
                ? Text(
                    label,
                    style: TextStyle(
                        color: isSelected
                            ? const Color.fromARGB(255, 123, 211, 255)
                            : AppColor.gray767676,
                        fontSize: 12,
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
      Navigator.pushNamed(context, RouteList.selectEquip);
    }
    if (index == 1 && index != widget.selectedIndex) {
      Navigator.pushNamed(context, RouteList.patientSetting);
    }
  }

  // if (index == 1 && index != widget.selectedIndex) {
  //   Navigator.pushReplacementNamed(context, RouteList.history);
  // }
  // if (index == 2 && index != widget.selectedIndex) {
  //   Navigator.pushReplacementNamed(context, RouteList.trend);
  // }
}
