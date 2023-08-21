// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/domain/entities/patient_entity.dart';
import 'package:flutter/material.dart';


import '../../../../../di/di.dart';
import '../../../../theme/app_text_theme.dart';
import '../../../../theme/theme_color.dart';
import '../../patient_list_&_infor_bloc/get_patient_bloc.dart';
import '../../patient_profile/patient_infor_screen.dart';


class UserListCell extends StatefulWidget {
  final UserEntity? userEntity;
  final GetUserBloc userBloc;
  const UserListCell({
    Key? key,
    this.userEntity,
    required this.userBloc,
  }) : super(key: key);

  @override
  State<UserListCell> createState() => _UserListCellState();
}

class _UserListCellState extends State<UserListCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BlocProvider<GetUserBloc>(
                create: (context) => getIt<GetUserBloc>(),
                child: HomeScreen(
                  id: widget.userEntity?.id ?? widget.userEntity?.id,
                  userBloc: widget.userBloc,
                ));
          }));

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => const HomeScreen(),
          //     ));
        },
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10), // Đặt giá trị bán kính bo góc tại đây
            ),
            elevation: 2,
            shadowColor: Color.fromARGB(
                Random().nextInt(255),
                Random().nextInt(255),
                Random().nextInt(255),
                Random().nextInt(255)),
            color: AppColor.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const SizedBox(
                    height: 40,
                    width: 40,
                    child: Icon(
                      Icons.people_alt_outlined,
                      color: AppColor.black,
                      size: 30,
                    )),
                title: Text(
                  widget.userEntity?.name ?? '',
                  style: AppTextTheme.body2
                      .copyWith(fontSize: 22, fontWeight: FontWeight.w400),
                ),
                subtitle: Text(
                    widget.userEntity?.phoneNumber == ""
                        ? "chưa cập nhật"
                        : widget.userEntity!.phoneNumber,
                    style: AppTextTheme.body4),
              ),
            )));
  }
}
