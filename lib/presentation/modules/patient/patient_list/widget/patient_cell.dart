// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:mobile_health_check/common/singletons.dart';
import 'package:flutter/material.dart';

import '../../../../../classes/language_constant.dart';
import '../../../../../domain/entities/patient_infor_entity.dart';
import '../../../../../function.dart';
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
    this.patientInforEntity,
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
          Navigator.pushNamed(
            context,
            RouteList.patientInfor,
            arguments: widget.patientInforEntity?.id,
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
                  widget.patientInforEntity?.name ?? '',
                  style: AppTextTheme.body2.copyWith(
                      fontSize: SizeConfig.screenWidth * 0.05,
                      fontWeight: FontWeight.w400),
                ),
                subtitle: Text(
                    widget.patientInforEntity?.phoneNumber == ""
                        ? "chưa cập nhật"
                        : widget.patientInforEntity!.phoneNumber,
                    style: AppTextTheme.body4),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => Center(
                        child: AlertDialog(
                          title: Text(translation(context).notification),
                          content: Text(
                            "Delete this Patient?",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          actions: [
                            TextButton(
                              child: Text(translation(context).exit),
                              onPressed: () {
                                //Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text(translation(context).accept),
                              onPressed: (){
                                widget.patientBloc.add(DeletePatientEvent(
                                  doctorId: userDataData.getUser()!.id,
                                  patientId: widget.patientInforEntity?.id,
                                ));
                                //Navigator.pop(context);
                            
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.delete_outline_outlined,
                      size: SizeConfig.screenWidth * 0.1,
                      color: AppColor.lineDecor),
                ),
              ),
            )));
  }
}
