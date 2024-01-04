// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../utils/size_config.dart';
import '../theme/theme_color.dart';

// ignore: must_be_immutable
class SlideAbleForm extends StatelessWidget {
  double? extentRatio;
  Text? textLine1;
  Text? textLine2;
  double? widthLeadingIconCell;
  Icon? iconLeadingCell;
  Function() onTapCell;
  String? lableAction1;
  IconData? iconAction1;
  Function()? onAction1;
  String? lableAction2;
  IconData? iconAction2;
  Function()? onAction2;
  SlideAbleForm({
    Key? key,
    this.extentRatio,
    this.iconAction1,
    this.iconAction2,
    this.lableAction1,
    this.lableAction2,
    this.widthLeadingIconCell,
    this.iconLeadingCell,
    this.textLine1,
    this.textLine2,
    required this.onTapCell,
    this.onAction1,
    this.onAction2,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Slidable(
      key: _scaffoldKey,
      closeOnScroll: true,
      endActionPane: ActionPane(motion: const StretchMotion(), 
      extentRatio: extentRatio ?? 0.5,
      children: [
        //! Call Action
        SlidableAction(
          autoClose: true,
          borderRadius: BorderRadius.circular(10),
          label: lableAction1,
          onPressed: (context) async {
            await onAction1?.call();
          },
          backgroundColor: const Color.fromARGB(255, 64, 247, 70),
          foregroundColor: Colors.white,
          icon: iconAction1 ?? Icons.add_box_rounded,
        ),

        //! Delete Action
        SlidableAction(
          label: lableAction2,
          autoClose: true,
          borderRadius: BorderRadius.circular(10),
          onPressed: (context) {
            onAction2?.call();
          },
          backgroundColor: AppColor.lineDecor,
          foregroundColor: Colors.white,
          icon: iconAction2 ?? Icons.add_box_rounded,
        ),
      ]),
      child: Container(
          margin: const EdgeInsets.only(
            right: 2,
            left: 2,
          ),
          height: SizeConfig.screenHeight * 0.11,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10, // Đặt giá trị bán kính bo góc tại đây
            ),
            color: AppColor.white,
          ),
          child: Center(
            child: ListTile(
              onTap: () {
                onTapCell.call();
              },
              contentPadding: const EdgeInsets.only(left: 10),
              leading:
                  SizedBox(width: widthLeadingIconCell, child: iconLeadingCell),
              title: Transform.translate(
                offset: const Offset(0, 0),
                child: textLine1,
              ),
              subtitle: Transform.translate(
                  offset: const Offset(0, 0), child: textLine2),
            ),
          )),
    );
  }
}
