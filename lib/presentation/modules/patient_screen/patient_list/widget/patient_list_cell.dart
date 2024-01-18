// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../../../../../classes/language.dart';
import '../../../../../domain/entities/patient_infor_entity.dart';
import '../../../../../utils/size_config.dart';
import '../../../../route/route_list.dart';
import '../../../../theme/app_text_theme.dart';
import '../../../../theme/theme_color.dart';
import '../../bloc/get_patient_bloc.dart';

class PatientListCell extends StatefulWidget {
  final PatientInforEntity? patientInforEntity;
  final GetPatientBloc patientBloc;
  // final DoctorInforEntity? doctorInforEntity;
  const PatientListCell({
    Key? key,
    // this.doctorInforEntity,
    required this.patientInforEntity,
    required this.patientBloc,
  }) : super(key: key);

  @override
  State<PatientListCell> createState() => _PatientListCellState();
}

class _PatientListCellState extends State<PatientListCell> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      // padding: const EdgeInsets.only(top: 7, bottom: 7),
      margin: const EdgeInsets.only(right: 2, left: 2),
      height: SizeConfig.screenHeight * 0.125,
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: Colors.black26)],
        borderRadius: BorderRadius.circular(
          10, // Đặt giá trị bán kính bo góc tại đây
        ),
        color: AppColor.white,
      ),
      child: Center(
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteList.patientInfor,
              arguments: widget.patientInforEntity?.id,
            );
          },
          contentPadding: const EdgeInsets.only(left: 10),
          leading: SizedBox(
            width: SizeConfig.screenWidth * 0.11,
            child: Icon(Icons.person_pin,
                color: AppColor.lineDecor,
                size: SizeConfig.screenDiagonal * 0.045),
          ),
          title: Transform.translate(
            offset: const Offset(-10, 0),
            child: Text(
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                widget.patientInforEntity?.name ?? '',
                style: AppTextTheme.body2.copyWith(
                    fontSize: SizeConfig.screenWidth * 0.055,
                    fontWeight: FontWeight.w500)),
          ),
          subtitle: Transform.translate(
            offset: const Offset(-10, 0),
            child: Text(
              softWrap: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              widget.patientInforEntity?.phoneNumber == ""
                  ? translation(context).notUpdate
                  : widget.patientInforEntity!.phoneNumber,
              style: AppTextTheme.body3
                  .copyWith(fontSize: SizeConfig.screenWidth * 0.04),
            ),
          ),
        ),
      ),
    );
  }
}
