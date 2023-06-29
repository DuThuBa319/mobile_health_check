import 'package:common_project/presentation/modules/home/home_screen.dart';
import 'package:common_project/presentation/theme/app_text_theme.dart';
import 'package:common_project/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';

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
      required this.title});

  @override
  State<CustomScreenForm> createState() => _CustomScreenFormState();
}

class _CustomScreenFormState extends State<CustomScreenForm> {
  final int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: widget.isShowAppBar
          ? AppBar(
              backgroundColor: widget.appBarColor,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                widget.title,
                style: AppTextTheme.title1
                    .copyWith(color: widget.appComponentColor),
              ),
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
            )
          : null,
      body: SafeArea(
          child: widget.isScrollable == true
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  physics: const BouncingScrollPhysics(),
                  child: widget.child,
                )
              : widget.child),
      bottomNavigationBar: widget.isShowBottomNayvigationBar == true
          ? BottomNavigationBar(
              backgroundColor: widget.appBarColor,
              type: BottomNavigationBarType.fixed,
              items: [
                commonBottomBarItem(iconData: Icons.home, label: 'Home'),
                commonBottomBarItem(iconData: Icons.history, label: 'History'),
                commonBottomBarItem(
                    iconData: Icons.notifications, label: 'Notification'),
                commonBottomBarItem(
                    iconData: Icons.account_circle, label: 'Account'),
              ],
              currentIndex: _selectedIndex,
              unselectedItemColor: widget.appComponentColor,
              unselectedLabelStyle:
                  AppTextTheme.body5.copyWith(fontWeight: FontWeight.bold),
              selectedItemColor: widget.appComponentColor,
              selectedLabelStyle:
                  AppTextTheme.body5.copyWith(fontWeight: FontWeight.bold),
              onTap: _onItemTapped,
            )
          : null,
    );
  }

  void _onItemTapped(int index) {
    if (index == 0 && index != _selectedIndex) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    }
  }

  BottomNavigationBarItem commonBottomBarItem(
      {String? label, IconData? iconData}) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 5.5,
            height: MediaQuery.of(context).size.height / 25,
            margin: const EdgeInsets.only(bottom: 3, top: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24), color: Colors.white),
            child: Icon(iconData, color: Colors.black),
          ),
        ],
      ),
      label: label,
      backgroundColor: AppColor.blue001D37,
    );
  }
}
