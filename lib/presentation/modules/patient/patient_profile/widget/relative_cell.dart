// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/common_widget/dialog/dialog_two_button.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import '../../../../../classes/language.dart';
import '../../../../../common/singletons.dart';
import '../../../../../domain/entities/patient_infor_entity.dart';
import '../../../../../domain/entities/relative_infor_entity.dart';
import '../../../../../function.dart';
import '../../../../theme/app_text_theme.dart';
import '../../bloc/get_patient_bloc.dart';

class RelativeListCell extends StatefulWidget {
  final RelativeInforEntity? relativeInforEntity;
  final PatientInforEntity? patientInforEntity;
  final GetPatientBloc? deleteRelativeBloc;
  // final DoctorInforEntity? doctorInforEntity;
  const RelativeListCell({
    Key? key,
    // this.doctorInforEntity,'
    this.patientInforEntity,
    this.deleteRelativeBloc,
    this.relativeInforEntity,
  }) : super(key: key);

  @override
  State<RelativeListCell> createState() => _RelativeListCellState();
}

class _RelativeListCellState extends State<RelativeListCell> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Container(
        margin: EdgeInsets.only(
            left: SizeConfig.screenWidth * 0.04,
            right: SizeConfig.screenWidth * 0.04,
            bottom: SizeConfig.screenWidth * 0.025),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 6),
          child: ListTile(
            title: Text(
              widget.relativeInforEntity?.name ?? '',
              style: AppTextTheme.body2.copyWith(
                  fontSize: SizeConfig.screenWidth * 0.05,
                  fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
                widget.relativeInforEntity?.phoneNumber == ""
                    ? "chưa cập nhật"
                    : widget.relativeInforEntity!.phoneNumber,
                style: AppTextTheme.body4),
            trailing: (userDataData.getUser()?.role == "doctor")
                ? IconButton(
                    onPressed: () {
                      showNoticeDialogTwoButton(
                          context: context,
                          title: translation(context).notification,
                          message: "Delete this Relative?",
                          titleBtn1: translation(context).exit,
                          titleBtn2: translation(context).accept,
                          onClose2: () {
                            widget.deleteRelativeBloc?.add(DeleteRelativeEvent(
                                patientId: widget.patientInforEntity?.id,
                                relativeId: widget.relativeInforEntity?.id));
                          });
                    },
                    icon: Icon(Icons.delete_outline_outlined,
                        size: SizeConfig.screenWidth * 0.1,
                        color: AppColor.lineDecor),
                  )
                : const SizedBox(
                    width: 0.5,
                  ),
          ),
        ));
  }
}
