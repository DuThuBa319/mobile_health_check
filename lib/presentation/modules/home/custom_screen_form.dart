import 'package:common_project/presentation/theme/app_text_theme.dart';
import 'package:common_project/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';

class CustomScreenForm extends StatefulWidget {
  final bool? isShowBottomNayvigationBar;
  final bool isShowAppBar;
  final bool isShowLeadingButton;
  final Widget? leadingButton;
  final Widget? bottomAppBar;
  final int selectedIndex;
  final String title;
  final Widget? child;
  const CustomScreenForm(
      {super.key,
      this.bottomAppBar,
      this.isShowBottomNayvigationBar,
      this.isShowAppBar = true,
      this.child,
      this.isShowLeadingButton = false,
      this.leadingButton,
      this.selectedIndex = 1,
      required this.title});

  @override
  State<CustomScreenForm> createState() => _CustomScreenFormState();
}

class _CustomScreenFormState extends State<CustomScreenForm> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.isShowAppBar
          ? AppBar(
              backgroundColor: AppColor.blue001D37,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                widget.title,
                style: AppTextTheme.title1.copyWith(color: Colors.white),
              ),
              leading: widget.isShowLeadingButton
                  ? widget.leadingButton ??
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 24,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                  : null,
            )
          : null,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: widget.child,
      )),
      bottomNavigationBar: widget.isShowBottomNayvigationBar == true
          ? BottomNavigationBar(
              backgroundColor: AppColor.blue001D37,
              type: BottomNavigationBarType.fixed,
              items: [
                commonBottomBarItem(iconData: Icons.home, label: 'Home'),
                commonBottomBarItem(
                    iconData: Icons.account_circle, label: 'Account'),
                commonBottomBarItem(
                    iconData: Icons.notifications, label: 'Notification'),
                commonBottomBarItem(iconData: Icons.logout, label: 'Logout'),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber,
              unselectedItemColor: Colors.white,
              selectedLabelStyle: AppTextTheme.body5
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              unselectedLabelStyle: AppTextTheme.body5
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              onTap: _onItemTapped,
            )
          : null,
    );
  }

  BottomNavigationBarItem commonBottomBarItem(
      {String? label, IconData? iconData}) {
    return BottomNavigationBarItem(
      icon: Container(
        width: 64,
        height: 32,
        margin: const EdgeInsets.only(bottom: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24), color: Colors.white),
        child: Icon(iconData, color: Colors.black),
      ),
      label: label,
      backgroundColor: AppColor.blue001D37,
    );
  }
}
