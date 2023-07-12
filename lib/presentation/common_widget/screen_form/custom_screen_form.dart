import 'package:common_project/presentation/theme/app_text_theme.dart';
import 'package:common_project/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';

import '../../route/route_list.dart';
import '../assets.dart';

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
      required this.selectedIndex,
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
                        Icon(Icons.notifications),
                        SizedBox(
                          width: 10,
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
          ? BottomNavigationBar(
              backgroundColor: widget.appBarColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: widget.selectedIndex,
              unselectedItemColor: widget.appComponentColor,
              unselectedLabelStyle:
                  AppTextTheme.body5.copyWith(fontWeight: FontWeight.normal),
              selectedItemColor: Colors.orange,
              selectedLabelStyle: AppTextTheme.body5
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.orange),
              items: [
                commonBottomBarItem(
                    iconAssets: const Icon(Icons.home, color: Colors.black),
                    label: 'Home'),
                commonBottomBarItem(
                    iconAssets:
                        const Icon(Icons.shopping_cart, color: Colors.black),
                    label: 'Shopping'),
                commonBottomBarItem(
                    iconAssets:
                        const Icon(Icons.account_circle, color: Colors.black),
                    label: 'User Profile'),
                commonBottomBarItem(
                    iconAssets: Image.asset(Assets.icWeather),
                    label: 'Weather'),
              ],
              onTap: _onItemTapped,
            )
          : null,
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
      if (index == 3 && index != widget.selectedIndex) {
        Navigator.pushReplacementNamed(context, RouteList.example);
      }
    }
  }

  BottomNavigationBarItem commonBottomBarItem(
      {String? label, Widget? iconAssets}) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 5.5,
            height: MediaQuery.of(context).size.height / 25,
            margin: const EdgeInsets.only(bottom: 3, top: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24), color: Colors.white),
            child: iconAssets,
          ),
        ],
      ),
      label: label,
      backgroundColor: AppColor.blue001D37,
    );
  }
}
