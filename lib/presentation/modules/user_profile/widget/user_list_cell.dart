// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:common_project/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/di.dart';
import '../../../bloc/userlist/get_user_detail_bloc copy/get_user_detail_bloc.dart';
import '../../../bloc/userlist/get_user_detail_bloc copy/get_user_detail_event.dart';
import '../../../theme/app_text_theme.dart';
import '../../../theme/theme_color.dart';
import '../user_detail_screen.dart';

class UserListCell extends StatefulWidget {
  final UserEntity? userEntity;
  const UserListCell({
    Key? key,
    this.userEntity,
  }) : super(key: key);

  @override
  State<UserListCell> createState() => _UserListCellState();
}

class _UserListCellState extends State<UserListCell> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BlocProvider<GetUserDetailBloc>(
                create: (context) => getIt<GetUserDetailBloc>()
                  ..add(GetUserDetailEvent(userId: widget.userEntity?.id ?? 0)),
                child: const UserDetailScreen());
          }));
        },
        child: Card(
            margin: const EdgeInsets.all(8),
            color: AppColor.primaryColor,
            child: ListTile(
              leading: const SizedBox(
                  height: 40, width: 40, child: Icon(Icons.people)),
              title: Text(
                widget.userEntity?.name ?? '',
                style: AppTextTheme.body2,
              ),
              subtitle: Text(widget.userEntity?.email ?? '',
                  style: AppTextTheme.body4),
            )));
  }
}
