import 'package:badges/badges.dart';
import 'package:common_project/presentation/theme/app_text_theme.dart';
import 'package:common_project/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';

import '../../route/route_list.dart';

class CustomScreenForm extends StatefulWidget {
  final bool? isShowBottomNayvigationBar;
  final bool isShowAppBar;
  final Color? appBarColor;
  final Color? backgroundColor;
  final Color? appComponentColor;
  final bool isShowLeadingButton;
  final Widget? leadingButton;
  final Widget? bottomAppBar;
  final int selectedIndex;
  final String title;
  final Widget child;
  final bool? isScrollable;
  final bool? isShowRightButon;
  final Widget? rightButton;
  const CustomScreenForm(
      {super.key,
      this.appBarColor = Colors.black,
      this.backgroundColor = Colors.white,
      this.appComponentColor = Colors.white,
      this.bottomAppBar,
      this.isShowBottomNayvigationBar,
      this.isShowAppBar = true,
      required this.child,
      this.isShowLeadingButton = false,
      this.leadingButton,
      this.selectedIndex = -1,
      this.isScrollable = false,
      required this.title,
      this.isShowRightButon = false,
      this.rightButton});

  @override
  State<CustomScreenForm> createState() => _CustomScreenFormState();
}

class _CustomScreenFormState extends State<CustomScreenForm> {
  @override
  Widget build(BuildContext context) {
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
                          size: 24,
                          color: widget.appComponentColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                  : null,
              centerTitle: true,
              title: Text(
                widget.title,
                style: AppTextTheme.title1
                    .copyWith(color: widget.appComponentColor),
              ),
              actions: [
                widget.rightButton ??
                    Row(
                      children: const [
                        Badge(
                          badgeContent: Text("3",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white)),
                          child: Icon(Icons.notifications),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    )
              ],
            )
          : null,
// body --------------------------------------
      body: SafeArea(
          child: widget.isScrollable == true
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  physics: const BouncingScrollPhysics(),
                  child: widget.child,
                )
              : widget.child),
// bottom app bar -------------------------
      bottomNavigationBar: widget.isShowBottomNayvigationBar == true
          ? BottomAppBar(
              color: AppColor.appBarColor,
              elevation: 0,
              shape: const CircularNotchedRectangle(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  iconBottomBar(
                      label: 'Home',
                      iconData: Icons.home,
                      isSelected: widget.selectedIndex == 0 ? true : false,
                      iconIndex: 0),
                  iconBottomBar(
                      label: 'Shopping',
                      iconData: Icons.shopping_cart,
                      isSelected: widget.selectedIndex == 1 ? true : false,
                      iconIndex: 1),
                  const SizedBox(width: 30),
                  iconBottomBar(
                      label: 'User Profile',
                      iconData: Icons.account_circle,
                      isSelected: widget.selectedIndex == 2 ? true : false,
                      iconIndex: 2),
                  iconBottomBar(
                      label: 'Weather',
                      iconData: Icons.sunny,
                      isSelected: widget.selectedIndex == 3 ? true : false,
                      iconIndex: 3),
                ],
              ),
            )
          : null,
      // floating button
      floatingActionButton: widget.isShowBottomNayvigationBar == true
          ? FloatingActionButton(
              elevation: 0,
              onPressed: () {
                Navigator.pushNamed(context, RouteList.OCR_screen);
              },
              backgroundColor: const Color(0xFF03A1E4),
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 12,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 6,
              height: MediaQuery.of(context).size.height / 25,
              margin: const EdgeInsets.only(top: 10, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24), color: Colors.white),
              child: Icon(
                iconData,
                color: isSelected ? Colors.orangeAccent : Colors.black,
              ),
            ),
            label != null
                ? Text(
                    label,
                    style: TextStyle(
                        color: isSelected ? Colors.orangeAccent : Colors.black,
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
      Navigator.pushNamedAndRemoveUntil(
          context, RouteList.home, (Route<dynamic> route) => false);
    }
    if (widget.selectedIndex == 0) {
      if (index == 1 && index != widget.selectedIndex) {
        Navigator.pushNamed(context, RouteList.shoppingCart);
      }
      if (index == 3 && index != widget.selectedIndex) {
        Navigator.pushNamed(context, RouteList.example);
      }
    } else {
      if (index == 1 && index != widget.selectedIndex) {
        Navigator.pushReplacementNamed(context, RouteList.shoppingCart);
      }
      if (index == 2 && index != widget.selectedIndex) {
        Navigator.pushReplacementNamed(context, RouteList.userList);
      }
      if (index == 3 && index != widget.selectedIndex) {
        Navigator.pushReplacementNamed(context, RouteList.example);
      }
    }
  }
}
