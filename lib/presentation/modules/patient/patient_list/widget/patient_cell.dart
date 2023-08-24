// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:mobile_health_check/domain/entities/patient_entity.dart';
import 'package:flutter/material.dart';

import '../../../../route/route_list.dart';
import '../../../../theme/app_text_theme.dart';
import '../../../../theme/theme_color.dart';
import '../../patient_list_&_infor_bloc/get_patient_bloc.dart';

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
          Navigator.pushNamed(context, RouteList.home,
              arguments: widget.userEntity?.id);
        },
        child: Card(
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10), // Đặt giá trị bán kính bo góc tại đây
            ),
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
