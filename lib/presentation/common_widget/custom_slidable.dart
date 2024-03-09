// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_health_check/classes/language.dart';

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
            borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.01),
            label: lableAction1 ?? translation(context).call,
            onPressed: (context) async {
              await onAction1?.call();
            },
            backgroundColor: const Color.fromARGB(255, 64, 247, 70),
            foregroundColor: Colors.white,
            icon: iconAction1 ?? Icons.call,
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
                  (index) => SlidableButton(
                      contentRadius: SizeConfig.screenWidth * 0.01,
                      fontSize: SizeConfig.screenWidth * 0.03,
                      autoClose: true,
                      foregroundColor: endDrawerWidgets![index].foregroundColor,
                      iconSize: SizeConfig.screenWidth * 0.08,
                      backgroundColor: endDrawerWidgets![index].backgroundColor,
                      icon: endDrawerWidgets![index].iconData,
                      label: endDrawerWidgets![index].labelText,
                      onPressed: endDrawerWidgets![index].onPressed),
                  //  SlidableAction(
                  //   icon: endDrawerWidgets![index].iconData,
                  //   autoClose: true,
                  //   backgroundColor: endDrawerWidgets![index].backgroundColor,
                  //   onPressed: endDrawerWidgets![index].onPressed,
                  //   foregroundColor: endDrawerWidgets![index].foregroundColor,
                  //   label: endDrawerWidgets![index].labelText,
                  //   borderRadius:
                  //       BorderRadius.circular(SizeConfig.screenWidth * 0.015),
                  // ),
                ),
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
                          borderRadius: BorderRadius.circular(
                              SizeConfig.screenWidth * 0.01),
                        )),
              ),
        child: Container(
            // margin: EdgeInsets.only(
            //     right: SizeConfig.screenWidth * 0.04,
            //     left: SizeConfig.screenWidth * 0.03),
            height: cellHeight ?? SizeConfig.screenHeight * 0.1,
            width: cellWidth ?? SizeConfig.screenWidth,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(SizeConfig.screenWidth * 0.01),
              color: cellColor,
            ),
            child: contentWidget));
  }
}

class SlidableButton extends StatelessWidget {
  SlidableButton(
      {super.key,
      this.contentRadius,
      this.icon,
      this.iconSize,
      this.fontSize,
      this.label,
      this.backgroundColor,
      this.foregroundColor,
      this.borderColor,
      this.flex = 1,
      this.autoClose = true,
      required this.onPressed}) {
    borderColor ??= backgroundColor ?? Colors.transparent;
  }
  final double? contentRadius;
  final IconData? icon;
  final double? iconSize;
  final double? fontSize;
  final String? label;

  /// The amount of space the child's can occupy in the main axis is
  /// determined by dividing the free space according to the flex factors of the
  /// other [CustomSlidableAction]s.
  final int flex;

  final Color? backgroundColor;
  Color? borderColor;
  final Color? foregroundColor;

  /// Whether the enclosing [Slidable] will be closed after [onPressed]
  /// occurred.
  final bool autoClose;

  /// Called when the action is tapped or otherwise activated.
  /// If this callback is null, then the action will be disabled.
  final SlidableActionCallback? onPressed;

  void _handleTap(BuildContext context) {
    onPressed?.call(context);
    if (autoClose) {
      Slidable.of(context)?.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gets the SlidableController.
    final controller = Slidable.of(context);

    return ValueListenableBuilder<double>(
      // Listens to the slide animation.
      valueListenable: controller!.animation,
      builder: (context, value, child) {
        // This is the maximum ratio allowed by the current action pane.

        return Flexible(
            flex: flex,
            fit: FlexFit.tight,
            child: GestureDetector(
                onTap: () {
                  _handleTap(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius:
                          BorderRadius.all(Radius.circular(contentRadius!))),
                  margin: const EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(icon, size: iconSize, color: foregroundColor),
                      Text(
                        label ?? '',
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: foregroundColor,
                            //fontWeight: FontWeight.w300,
                            fontSize: fontSize),
                      )
                    ],
                  ),
                )));
      },
    );
  }
}

//! widget thiết kế contentCell theo nhu cầu trong project
class CustomSlidableWidget extends StatelessWidget {
  final List<SlidableDrawerWidget>? endDrawerWidgets;
  final List<SlidableDrawerWidget>? startDrawerWidgets;
  final Text? textLine1;
  final Widget? textLine2;
  final Widget? iconLeadingCell;
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
          titleAlignment: ListTileTitleAlignment.center,
          trailing: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: SizeConfig.screenHeight * 0.022,
          ),
          onTap: () {
            onTapCell.call();
          },
          contentPadding: EdgeInsets.only(
              left: SizeConfig.screenWidth * 0.005,
              right: SizeConfig.screenWidth * 0.005),
          leading: Transform.translate(
            offset: const Offset(0, 0),
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
