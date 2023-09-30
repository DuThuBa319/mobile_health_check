import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';

import '../../../classes/language.dart';
import '../../../common/singletons.dart';
import '../../../function.dart';
import '../../modules/notification_onesignal/bloc/notification_bloc.dart';
import '../../route/route_list.dart';

class CustomScreenForm extends StatefulWidget {
  final bool? isShowBottomNayvigationBar;
  final bool? isRelativeApp;
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
      this.isRelativeApp = false,
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
              backgroundColor: widget.appBarColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: widget.isShowLeadingButton
                  ? widget.leadingButton ??
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 35,
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
                        const SizedBox(
                          height: 30,
                          width: 30,
                        )
                    : const SizedBox(
                        height: 30,
                        width: 30,
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
              elevation: 40,
              notchMargin: 5,
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    iconBottomBar(
                        label: translation(context).homeScreen,
                        iconData: Icons.list,
                        isSelected: widget.selectedIndex == 0 ? true : false,
                        iconIndex: 0),
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

      floatingActionButton: widget.floatActionButton,
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
        padding: EdgeInsets.only(
          top: SizeConfig.screenHeight * 0.005,
        ),
        height: SizeConfig.screenHeight / 15,
        width: SizeConfig.screenWidth / 2,
        child: Column(
          children: [
            Icon(
              iconData,
              color: isSelected
                  ? const Color.fromARGB(255, 123, 211, 255)
                  : AppColor.gray767676,
              size: 27,
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
      Navigator.pushNamed(context, RouteList.patientList,
          arguments: userDataData.getUser()!.id!);
    }
    if (index == 1 && index != widget.selectedIndex) {
      Navigator.pushNamed(context, RouteList.setting);
    }
    
  }
}
