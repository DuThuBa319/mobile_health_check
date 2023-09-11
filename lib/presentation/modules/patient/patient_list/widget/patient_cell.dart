// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:mobile_health_check/domain/entities/patient_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../function.dart';
import '../../../../route/route_list.dart';
import '../../../../theme/app_text_theme.dart';
import '../../../../theme/theme_color.dart';
import '../../bloc/get_patient_bloc.dart';

class PatientListCell extends StatefulWidget {
  final PatientEntity? patientEntity;
  final GetPatientBloc patientBloc;
  // final DoctorInforEntity? doctorInforEntity;
  const PatientListCell({
    Key? key,
    // this.doctorInforEntity,
    this.patientEntity,
    required this.patientBloc,
  }) : super(key: key);

  @override
  State<PatientListCell> createState() => _PatientListCellState();
}

class _PatientListCellState extends State<PatientListCell> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RouteList.patientInfor,
              arguments: widget.patientEntity?.id,  );
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
                  widget.patientEntity?.name ?? '',
                  style: AppTextTheme.body2.copyWith(
                      fontSize: SizeConfig.screenWidth * 0.05,
                      fontWeight: FontWeight.w400),
                ),
                subtitle: Text(
                    widget.patientEntity?.phoneNumber == ""
                        ? "chưa cập nhật"
                        : widget.patientEntity!.phoneNumber,
                    style: AppTextTheme.body4),
              ),
            )));
  }
}
