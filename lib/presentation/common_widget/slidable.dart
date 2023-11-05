import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_health_check/domain/entities/patient_infor_entity.dart';
import 'package:mobile_health_check/presentation/common_widget/dialog/show_toast.dart';

import '../../classes/language.dart';
import '../../common/singletons.dart';
import '../../domain/entities/cell_person_entity.dart';
import '../../domain/entities/relative_infor_entity.dart';
import '../../function.dart';
import '../modules/admin_screen/bloc/get_doctor_bloc.dart';
import '../modules/patient_screen/bloc/get_patient_bloc.dart';
import '../route/route_list.dart';
import '../theme/app_text_theme.dart';
import '../theme/theme_color.dart';

class SlideAbleForm extends StatelessWidget {
  final PatientInforEntity? patientInforEntity;
  final RelativeInforEntity? relativeInforEntity;
  final PersonCellEntity? personCellEntity;
  final GetPatientBloc? patientBloc;
  final GetDoctorBloc? doctorBloc;
  final bool? isPatientCell;
  final bool? isDoctorCell;
  final bool? isRelativeCell;
  const SlideAbleForm(
      {super.key,
      this.isDoctorCell = false,
      this.isPatientCell = false,
      this.isRelativeCell = false,
      this.patientInforEntity,
      this.patientBloc,
      this.doctorBloc,
      this.personCellEntity,
      this.relativeInforEntity});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Slidable(
      closeOnScroll: true,
      startActionPane: isRelativeCell == true
          ? ActionPane(
              motion: const StretchMotion(),
              extentRatio: 0.45,
              children: [
//! RESET RELATIVE'S PASSWORD ACTION
                  SlidableAction(
                    autoClose: true,
                    borderRadius: BorderRadius.circular(10),
                    onPressed: (context) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(translation(context).notification),
                            content: Text(
                                translation(context).resetRelativePassword),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(translation(context).exit),
                              ),
                              TextButton(
                                onPressed: () {
                                  patientBloc?.add(ResetPasswordCustomerEvent(
                                      userId: relativeInforEntity?.id));
                                  showToast(translation(context)
                                      .resetRelativePasswordSuccessfully);
                                  Navigator.pop(context);
                                },
                                child: Text(translation(context).accept),
                              )
                            ],
                          );
                        },
                      );
                    },
                    backgroundColor: AppColor.primaryColorLight,
                    foregroundColor: Colors.white,
                    label: translation(context).reset,
                    icon: Icons.lock_reset_sharp,
                  )
                ])
          : null,
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        //! Call Action
        SlidableAction(
          autoClose: true,
          borderRadius: BorderRadius.circular(10),
          label: translation(context).call,
          onPressed: (context) async {
            if (isPatientCell == true) {
              await FlutterPhoneDirectCaller.callNumber(
                  patientInforEntity!.phoneNumber);
            } else if (isRelativeCell == true) {
              await FlutterPhoneDirectCaller.callNumber(
                  relativeInforEntity!.phoneNumber);
            } else if (isDoctorCell == true) {
              await FlutterPhoneDirectCaller.callNumber(
                  personCellEntity!.phoneNumber);
            }
          },
          backgroundColor: const Color.fromARGB(255, 64, 247, 70),
          foregroundColor: Colors.white,
          icon: Icons.phone,
        ),

        //! Delete Action
        SlidableAction(
          label: translation(context).delete,
          autoClose: true,
          borderRadius: BorderRadius.circular(10),
          onPressed: (context) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(translation(context).notification),
                  content: Text(isPatientCell == true
                      ? translation(context).deletePatient
                      : isRelativeCell == true
                          ? translation(context).deleteRelative
                          : translation(context).deleteDoctor),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(translation(context).exit),
                    ),
                    TextButton(
                      onPressed: () {
                        if (isPatientCell == true) {
                          patientBloc?.add(DeletePatientEvent(
                            doctorId: userDataData.getUser()!.id,
                            patientId: patientInforEntity?.id,
                          ));
                        } else if (isRelativeCell == true) {
                          patientBloc?.add(RemoveRelationshipRaPEvent(
                              patientId: patientInforEntity?.id,
                              relativeId: relativeInforEntity?.id));
                        } else if (isDoctorCell == true) {
                          doctorBloc?.add(DeleteDoctorEvent(
                            doctorId: personCellEntity?.id,
                          ));
                        }
                        Navigator.pop(context);
                      },
                      child: Text(translation(context).accept),
                    )
                  ],
                );
              },
            );
          },
          backgroundColor: AppColor.lineDecor,
          foregroundColor: Colors.white,
          icon: Icons.delete_outline_outlined,
        ),
      ]),
      child: Container(
          margin: const EdgeInsets.only(
            right: 2,
            left: 2,
          ),
          height: SizeConfig.screenHeight * 0.125,
          padding: const EdgeInsets.only(
            top: 7,
            bottom: 7,
          ),
          decoration: BoxDecoration(
            boxShadow: const [BoxShadow(color: Colors.black26)],
            borderRadius: BorderRadius.circular(
              10, // Đặt giá trị bán kính bo góc tại đây
            ),
            color: AppColor.white,
          ),
          child: ListTile(
            onTap: () {
              if (isPatientCell == true) {
                Navigator.pushNamed(
                  context,
                  RouteList.patientInfor,
                  arguments: patientInforEntity?.id,
                );
              } else if (isDoctorCell == true) {
                Navigator.pushNamed(
                  context,
                  RouteList.doctorInfor,
                  arguments: personCellEntity?.id,
                );
              }
            },
            contentPadding: const EdgeInsets.only(left: 10),
            leading: SizedBox(
                width: isRelativeCell == true
                    ? SizeConfig.screenWidth * 0.13
                    : SizeConfig.screenWidth * 0.1,
                child: isRelativeCell == true
                    ? Icon(
                        Icons.account_box_rounded,
                        color: AppColor.primaryColorLight,
                        size: SizeConfig.screenWidth * 0.14,
                      )
                    : Icon(
                        Icons.person_pin,
                        color: AppColor.lineDecor,
                        size: SizeConfig.screenWidth * 0.11,
                      )),
            title: Transform.translate(
              offset: const Offset(-10, 0),
              child: isPatientCell == true
                  ? Text(
                      patientInforEntity?.name ?? '',
                      style: AppTextTheme.body2.copyWith(
                          fontSize: SizeConfig.screenWidth * 0.052,
                          fontWeight: FontWeight.w500),
                    )
                  : isRelativeCell == true
                      ? Text(
                          relativeInforEntity?.name ?? '',
                          style: AppTextTheme.body2.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.06,
                              fontWeight: FontWeight.w500),
                        )
                      : Text(
                          personCellEntity?.name ?? '',
                          style: AppTextTheme.body2.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.052,
                              fontWeight: FontWeight.w500),
                        ),
            ),
            subtitle: Transform.translate(
              offset: const Offset(-10, 0),
              child: (isPatientCell == true)
                  ? Text(
                      patientInforEntity?.phoneNumber == ""
                          ? translation(context).notUpdate
                          : patientInforEntity!.phoneNumber,
                      style: AppTextTheme.body3)
                  : isRelativeCell == true
                      ? Text(
                          relativeInforEntity?.phoneNumber == ""
                              ? translation(context).notUpdate
                              : relativeInforEntity!.phoneNumber,
                          style: AppTextTheme.body4.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.05))
                      : Text(
                          personCellEntity?.phoneNumber == ""
                              ? translation(context).notUpdate
                              : personCellEntity!.phoneNumber,
                          style: AppTextTheme.body3),
            ),
          )),
    );
  }
}
