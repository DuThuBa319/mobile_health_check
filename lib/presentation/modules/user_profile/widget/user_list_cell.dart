// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:common_project/domain/entities/user_entity.dart';
import 'package:common_project/presentation/bloc/userlist/get_user_bloc/get_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/di.dart';
import '../../../bloc/userlist/get_user_detail_bloc/get_user_detail_bloc.dart';

import '../../../theme/app_text_theme.dart';
import '../../../theme/theme_color.dart';
import '../user_detail_screen.dart';

class UserListCell extends StatefulWidget {
  final UserEntity? userEntity;
  final GetUserBloc userBloc;
  const UserListCell({Key? key, this.userEntity, required this.userBloc})
      : super(key: key);

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
                create: (context) => getIt<GetUserDetailBloc>(),
                child: UserDetailScreen(
                  id: widget.userEntity?.id ?? 0,
                  userBloc: widget.userBloc,
                ));
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
