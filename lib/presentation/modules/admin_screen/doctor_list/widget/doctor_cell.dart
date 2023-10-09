// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:mobile_health_check/common/singletons.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/domain/entities/cell_person_entity.dart';

import '../../../../../classes/language.dart';
import '../../../../../function.dart';
import '../../../../common_widget/dialog/dialog_two_button.dart';
import '../../../../route/route_list.dart';
import '../../../../theme/app_text_theme.dart';
import '../../../../theme/theme_color.dart';
import '../../bloc/get_doctor_bloc.dart';

class DoctorListCell extends StatefulWidget {
  final PersonCellEntity? doctorCellEntity;
  // final DoctorCellEntity? doctorCellEntity;
  final GetDoctorBloc doctorBloc;
  const DoctorListCell({
    Key? key,
    // this.doctorCellEntity,
    required this.doctorBloc,
    required this.doctorCellEntity,
  }) : super(key: key);

  @override
  State<DoctorListCell> createState() => _DoctorListCellState();
}

class _DoctorListCellState extends State<DoctorListCell> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteList.doctorInfor,
            arguments: widget.doctorCellEntity?.id,
          );
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
                leading: SizedBox(
                    height: SizeConfig.screenWidth * 0.1,
                    width: SizeConfig.screenWidth * 0.1,
                    child: const Icon(
                      Icons.people_alt_outlined,
                      color: AppColor.black,
                      size: 30,
                    )),
                title: Text(
                  widget.doctorCellEntity?.name ?? '',
                  style: AppTextTheme.body2.copyWith(
                      fontSize: SizeConfig.screenWidth * 0.05,
                      fontWeight: FontWeight.w400),
                ),
                subtitle: Text(
                    widget.doctorCellEntity?.phoneNumber == ""
                        ? "chưa cập nhật"
                        : widget.doctorCellEntity!.phoneNumber,
                    style: AppTextTheme.body4),
                trailing: (userDataData.getUser()?.role == "relative")
                    ? const SizedBox(
                        width: 0.5,
                      )
                    : IconButton(
                        onPressed: () {
                          showNoticeDialogTwoButton(
                              context: context,
                              title: translation(context).notification,
                              message: "Delete this Doctor?",
                              titleBtn1: translation(context).exit,
                              titleBtn2: translation(context).accept,
                              onClose2: () {
                                widget.doctorBloc.add(DeleteDoctorEvent(
                                  doctorId: widget.doctorCellEntity?.id,
                                ));
                              });
                        },
                        icon: Icon(Icons.delete_outline_outlined,
                            size: SizeConfig.screenWidth * 0.1,
                            color: AppColor.lineDecor),
                      ),
              ),
            )));
  }
}
