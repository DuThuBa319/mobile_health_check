import 'package:badges/badges.dart' as badges;
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';

import '../../../classes/language_constant.dart';
import '../../../function.dart';
import '../../route/route_list.dart';

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
  const CustomScreenForm(
      {super.key,
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
      this.rightButton});

  @override
  State<CustomScreenForm> createState() => _CustomScreenFormState();
}

class _CustomScreenFormState extends State<CustomScreenForm> {
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
                        const Row(
                          children: [
                            badges.Badge(
                              badgeContent: Text("N",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white)),
                              child: Icon(Icons.notifications),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        )
                    : const SizedBox(
                        height: 20,
                        width: 20,
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
                      label: translation(context).homeScreen,
                      iconData: Icons.list,
                      isSelected: widget.selectedIndex == 0 ? true : false,
                      iconIndex: 0),
                  iconBottomBar(
                      label: translation(context).messagesScreen,
                      iconData: Icons.message_outlined,
                      isSelected: widget.selectedIndex == 1 ? true : false,
                      iconIndex: 1),

                  iconBottomBar(
                      label: translation(context).settingScreen,
                      iconData: Icons.settings_sharp,
                      isSelected: widget.selectedIndex == 2 ? true : false,
                      iconIndex: 2),
                ],
              ),
            )
          : null,

      // floatingActionButton:
      //     widget.isShowBottomNayvigationBar == true && widget.selectedIndex == 0
      //         ? FloatingActionButton(
      //             elevation: 0,
      //             onPressed: () {
      //               Navigator.pushNamed(context, RouteList.OCR_screen);
      //             },
      //             backgroundColor: const Color(0xFF03A1E4),
      //             child: const Icon(
      //               Icons.add,
      //               size: 40,
      //             ),
      //           )
      //         : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Widget iconBottomBar(
  //     {String? label,
  //     required IconData iconData,
  //     required bool isSelected,
  //     required int iconIndex}) {
  //   return GestureDetector(
  //     onTap: () {
  //       _onItemTapped(iconIndex);
  //     },
  //     child: SizedBox(
  //       height: MediaQuery.of(context).size.height / 12,
  //       child: Column(
  //         children: [
  //           Container(
  //             width: MediaQuery.of(context).size.width / 6,
  //             height: MediaQuery.of(context).size.height / 25,
  //             margin: const EdgeInsets.only(top: 10, bottom: 5),
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(24), color: Colors.white),
  //             child: Icon(
  //               iconData,
  //               color: isSelected ? Colors.orangeAccent : Colors.black,
  //             ),
  //           ),
  //           label != null
  //               ? Text(
  //                   label,
  //                   style: TextStyle(
  //                       color: isSelected ? Colors.orangeAccent : Colors.black,
  //                       fontSize: 12,
  //                       fontWeight:
  //                           isSelected ? FontWeight.bold : FontWeight.normal),
  //                 )
  //               : const SizedBox(),
  //         ],
  //       ),
  //     ),
  //   );
  // }
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
          top: MediaQuery.of(context).size.height * 0.005,
        ),
        height: MediaQuery.of(context).size.height / 15,
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
      Navigator.pushNamed(context, RouteList.patientList);
    }
    if (index == 2 && index != widget.selectedIndex) {
      Navigator.pushNamed(context, RouteList.setting);
    }
    if (index == 1 && index != widget.selectedIndex) {
      //  Navigator.pushNamed(context, RouteList.example);
    }
  }
  // if (index == 1 && index != widget.selectedIndex) {
  //   Navigator.pushReplacementNamed(context, RouteList.history);
  // }
  // if (index == 2 && index != widget.selectedIndex) {
  //   Navigator.pushReplacementNamed(context, RouteList.trend);
  // }
}
