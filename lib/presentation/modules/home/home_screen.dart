import 'package:common_project/presentation/bloc/login/login_bloc.dart';
import 'package:common_project/presentation/common_widget/common_button.dart';
import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../theme/theme_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LoginBloc get loginBloc => BlocProvider.of(context);
  @override
  Widget build(BuildContext context) {
    // RefreshController refreshController =
    //     RefreshController(initialRefresh: true);
    // Future<void> onRefresh() async {
    //   // monitor network fetch
    //   await Future.delayed(const Duration(milliseconds: 1000));
    //   // if failed,use refreshFailed()
    //   refreshController.refreshCompleted();

    // }

    return CustomScreenForm(
        title: 'Home',
        isShowAppBar: true,
        isShowBottomNayvigationBar: true,
        isShowLeadingButton: true,
        appBarColor: AppColor.appBarColor,
        backgroundColor: AppColor.backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CommonButton(
                title: 'Shopping Cart',
                height: 80,
              ),
              CommonButton(
                title: 'User List',
                height: 80,
                buttonColor: Colors.amber,
              ),
              CommonButton(
                title: 'Daily Temperature',
                height: 80,
                buttonColor: Colors.orange,
              ),
              CommonButton(
                title: 'Hourly Temperature',
                height: 80,
                buttonColor: Colors.red,
              )
            ],
          ),
        ));
  }
}
