// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../utils/size_config.dart';
import '../theme/theme_color.dart';

class SlideAbleForm extends StatelessWidget {
  final double? extentRatio;
  final Text? textLine1;
  final Text? textLine2;
  final double? widthLeadingIconCell;
  final Icon? iconLeadingCell;
  final Function() onTapCell;
  final String? lableAction1;
  final IconData? iconAction1;
  final Function()? onAction1;
  final String? lableAction2;
  final IconData? iconAction2;
  final Function()? onAction2;
  const SlideAbleForm({
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
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Slidable(
      key:
          UniqueKey(), // Added a UniqueKey to ensure a new key is generated each time the widget is built.
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        extentRatio: extentRatio ?? 0.5,
        children: [
          //! Call Action
          SlidableAction(
            autoClose: true,
            borderRadius: BorderRadius.circular(10),
            label: lableAction1 ?? "Call",
            onPressed: (context) async {
              await onAction1?.call();
            },
            backgroundColor: const Color.fromARGB(255, 64, 247, 70),
            foregroundColor: Colors.white,
            icon: iconAction1 ?? Icons.add_box_rounded,
          ),
          //! Delete Action
          SlidableAction(
            label: lableAction2 ?? "Delete",
            autoClose: true,
            borderRadius: BorderRadius.circular(10),
            onPressed: (context) => onAction2?.call(),
            backgroundColor: AppColor.lineDecor,
            foregroundColor: Colors.white,
            icon: iconAction2 ?? Icons.delete,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(right: 2, left: 2),
        height: SizeConfig.screenHeight * 0.11,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.white,
        ),
        child: Center(
          child: ListTile(
            onTap: () {
              onTapCell.call();
            },
            contentPadding: const EdgeInsets.only(left: 10),
            leading: SizedBox(
              width: widthLeadingIconCell,
              child: iconLeadingCell,
            ),
            title: Transform.translate(
              offset: const Offset(0, 0),
              child: textLine1,
            ),
            subtitle: Transform.translate(
              offset: const Offset(0, 0),
              child: textLine2,
            ),
          ),
        ),
      ),
    );
  }
}

//! Tùy chỉnh các slidableCell
class SlidableDrawerWidget {
  IconData? iconData;
  Color backgroundColor;
  Color foregroundColor;
  String? labelText;
  Function(BuildContext)? onPressed;
  SlidableDrawerWidget(
      {required this.backgroundColor,
      required this.foregroundColor,
      required this.iconData,
      this.labelText,
      this.onPressed});
}

class SlidableCell extends StatelessWidget {
  final Widget contentWidget;
  final List<SlidableDrawerWidget>? endDrawerWidgets;
  final List<SlidableDrawerWidget>? startDrawerWidgets;
  final Color cellColor;
  final double? cellWidth;
  final double? cellHeight;

  const SlidableCell(
      {super.key,
      required this.contentWidget,
      this.endDrawerWidgets,
      this.startDrawerWidgets,
      this.cellColor = Colors.white,
      this.cellHeight,
      this.cellWidth});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Slidable(
        key: UniqueKey(),
        closeOnScroll: true,
        endActionPane: (endDrawerWidgets == null)
            ? null
            : ActionPane(
                motion: const StretchMotion(),
                extentRatio: 0.5,
                children: List.generate(
                    endDrawerWidgets!.length,
                    (index) => SlidableAction(
                          icon: endDrawerWidgets![index].iconData,
                          autoClose: true,
                          backgroundColor:
                              endDrawerWidgets![index].backgroundColor,
                          onPressed: endDrawerWidgets![index].onPressed,
                          foregroundColor:
                              endDrawerWidgets![index].foregroundColor,
                          label: endDrawerWidgets![index].labelText,
                          borderRadius: BorderRadius.circular(10),
                        )),
              ),
        startActionPane: (startDrawerWidgets == null)
            ? null
            : ActionPane(
                motion: const StretchMotion(),
                extentRatio: 0.5,
                children: List.generate(
                    startDrawerWidgets!.length,
                    (index) => SlidableAction(
                          icon: startDrawerWidgets![index].iconData,
                          autoClose: true,
                          backgroundColor:
                              startDrawerWidgets![index].backgroundColor,
                          onPressed: startDrawerWidgets![index].onPressed,
                          foregroundColor:
                              startDrawerWidgets![index].foregroundColor,
                          label: startDrawerWidgets![index].labelText,
                          borderRadius: BorderRadius.circular(10),
                        )),
              ),
        child: Container(
            // margin: EdgeInsets.only(
            //     right: SizeConfig.screenWidth * 0.04,
            //     left: SizeConfig.screenWidth * 0.03),
            height: cellHeight ?? SizeConfig.screenHeight * 0.1,
            width: cellWidth ?? SizeConfig.screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: cellColor,
            ),
            child: contentWidget));
  }
}

//! widget thiết kế contentCell theo nhu cầu trong project
class CustomSlidableWidget extends StatelessWidget {
  final List<SlidableDrawerWidget>? endDrawerWidgets;
  final List<SlidableDrawerWidget>? startDrawerWidgets;
  final Text? textLine1;
  final Text? textLine2;
  final Icon? iconLeadingCell;
  final Function() onTapCell;
  const CustomSlidableWidget(
      {super.key,
      this.endDrawerWidgets,
      this.startDrawerWidgets,
      this.iconLeadingCell,
      this.textLine1,
      this.textLine2,
      required this.onTapCell});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SlidableCell(
      endDrawerWidgets: endDrawerWidgets,
      contentWidget: Center(
        child: ListTile(
          trailing: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 15,
          ),
          onTap: () {
            onTapCell.call();
          },
          contentPadding: const EdgeInsets.only(left: 10, right: 5),
          leading: SizedBox(
            width: SizeConfig.screenHeight * 0.05,
            child: iconLeadingCell,
          ),
          title: Transform.translate(
            offset: const Offset(0, 0),
            child: textLine1,
          ),
          subtitle: Transform.translate(
            offset: const Offset(0, 0),
            child: textLine2,
          ),
        ),
      ),
    );
  }
}
