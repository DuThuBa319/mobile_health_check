// import 'dart:io';

// import 'package:another_flushbar/flushbar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../common/constants/app_locale.dart';
// import '../common_bloc/app_data_bloc.dart';
// import '../theme/theme_color.dart';
// Future<dynamic> showNoticeDialog({
//   required BuildContext context,
//   required String message,
//   String? title,
//   String? titleBtn,
//   bool barrierDismissible = true,
//   Function()? onClose,
//   bool useRootNavigator = true,
//   bool dismissWhenAction = true,
// }) {
//   final dismissFunc = () {
//     if (dismissWhenAction) {
//       Navigator.of(context, rootNavigator: useRootNavigator).pop();
//     }
//   };
//   return showDialog(
//     context: context,
//     barrierDismissible: barrierDismissible,
//     useRootNavigator: useRootNavigator,
//     builder: (context) {
//       final theme = Theme.of(context);

//       final showAndroidDialog = () => AlertDialog(
//             title: Text(
//               title ?? 'Thông báo',
//               style: theme.textTheme.headlineSmall,
//             ),
//             content: Text(
//               message,
//               style: theme.textTheme.bodyMedium,
//               textAlign: TextAlign.center,
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   dismissFunc.call();
//                   onClose?.call();
//                 },
//                 child: Text(titleBtn ?? 'Đồng ý'),
//               )
//             ],
//           );

//       if (kIsWeb) {
//         return showAndroidDialog();
//       } else if (Platform.isAndroid) {
//         return showAndroidDialog();
//       } else {
//         return CupertinoAlertDialog(
//           title: Text(title ?? 'Thông báo'),
//           content: Text(
//             message,
//             style: theme.textTheme.bodyMedium,
//             textAlign: TextAlign.center,
//           ),
//           actions: <Widget>[
//             CupertinoDialogAction(
//               onPressed: () {
//                 dismissFunc.call();
//                 onClose?.call();
//               },
//               child: Text(titleBtn ?? 'Đồng ý'),
//             ),
//           ],
//         );
//       }
//     },
//   );
// }

// Future<dynamic> showNoticeErrorDialog({
//   required BuildContext context,
//   required String message,
//   bool barrierDismissible = false,
//   void Function()? onClose,
//   bool useRootNavigator = true,
//   String? titleBtn,
// }) {
//   return showNoticeDialog(
//     context: context,
//     message: message,
//     barrierDismissible: barrierDismissible,
//     onClose: onClose,
//     titleBtn: titleBtn ?? 'Đồng ý',
//     useRootNavigator: useRootNavigator,
//     title: 'Lỗi',
//   );
// }

// Future<dynamic> showNoticeWarningDialog({
//   required BuildContext context,
//   required String message,
//   bool barrierDismissible = false,
//   void Function()? onClose,
//   bool useRootNavigator = true,
// }) {
//   final trans = translate(context);
//   return showNoticeDialog(
//     context: context,
//     message: message,
//     barrierDismissible: barrierDismissible,
//     onClose: onClose,
//     titleBtn: 'Đồng ý',
//     useRootNavigator: useRootNavigator,
//     title: 'Cảnh báo',
//   );
// }

// Future<dynamic> showNoticeConfirmDialog({
//   required BuildContext context,
//   required String message,
//   required String title,
//   bool barrierDismissible = true,
//   String? titleBtnDone,
//   String? titleBtnCancel,
//   void Function()? onConfirmed,
//   void Function()? onCanceled,
//   bool useRootNavigator = true,
//   bool dismissWhenAction = true,
//   TextStyle? styleBtnRight,
//   TextStyle? styleBtnLeft,
// }) {
//   final dismissFunc = () {
//     if (dismissWhenAction) {
//       Navigator.of(context, rootNavigator: useRootNavigator).pop();
//     }
//   };
//   // final trans = translate(context);
//   return showDialog(
//     context: context,
//     barrierDismissible: barrierDismissible,
//     useRootNavigator: useRootNavigator,
//     builder: (context) {
//       final theme = Theme.of(context);

//       final showAndroidDialog = () => AlertDialog(
//             title: Text(
//               title,
//               style: theme.textTheme.headlineSmall,
//             ),
//             content: Text(
//               message,
//               style: theme.textTheme.bodyMedium,
//               textAlign: TextAlign.center,
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   dismissFunc.call();
//                   onCanceled?.call();
//                 },
//                 child: Text(
//                   titleBtnCancel ?? 'Hủy',
//                   style: styleBtnLeft ??
//                       theme.textTheme.labelLarge?.copyWith(
//                         color: AppColor.primaryColor,
//                       ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   dismissFunc.call();
//                   onConfirmed?.call();
//                 },
//                 child: Text(
//                   titleBtnDone ?? 'Xác nhận',
//                   style: styleBtnRight ??
//                       theme.textTheme.labelLarge?.copyWith(
//                         color: AppColor.primaryColor,
//                       ),
//                 ),
//               ),
//             ],
//           );

//       if (kIsWeb) {
//         return showAndroidDialog();
//       } else if (Platform.isAndroid) {
//         return showAndroidDialog();
//       } else {
//         Widget _buildAction({
//           Function()? onTap,
//           required String title,
//           TextStyle? style,
//         }) {
//           return RawMaterialButton(
//             constraints: const BoxConstraints(minHeight: 45),
//             padding: EdgeInsets.zero,
//             onPressed: () {
//               dismissFunc.call();
//               onTap?.call();
//             },
//             child: Text(
//               title,
//               style: style ??
//                   theme.textTheme.labelLarge!.copyWith(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.normal,
//                   ),
//             ),
//           );
//         }

//         return CupertinoAlertDialog(
//           title: Text(
//             title,
//             style: theme.textTheme.headlineSmall!.copyWith(fontSize: 17),
//           ),
//           content: Padding(
//             padding: const EdgeInsets.only(top: 8),
//             child: Text(
//               message,
//               style: theme.textTheme.bodyMedium!.copyWith(fontSize: 13),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           actions: <Widget>[
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildAction(
//                     onTap: onCanceled,
//                     title: titleBtnCancel ?? 'Hủy',
//                     style: styleBtnLeft,
//                   ),
//                 ),
//                 Container(width: 0.5, height: 44, color: Colors.grey),
//                 Expanded(
//                   child: _buildAction(
//                     onTap: onConfirmed,
//                     title: titleBtnDone ?? 'Xác nhận',
//                     style: styleBtnRight,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         );
//       }
//     },
//   );
// }

// Future<void> showModal(
//   BuildContext context,
//   Widget content, {
//   bool useRootNavigator = true,
//   bool enableDrag = true,
//   double? bottomPadding,
//   bool isEnableScroll = false,
// }) {
//   return showModalBottomSheet<void>(
//     context: context,
//     useRootNavigator: useRootNavigator,
//     backgroundColor: Colors.transparent,
//     isScrollControlled: true,
//     enableDrag: enableDrag,
//     builder: (BuildContext context) {
//       final mediaData = MediaQuery.of(context);
//       final padding = mediaData.padding;
//       final size = mediaData.size;
//       final maxContentSize = size.height - padding.top - padding.bottom - 64;
//       return Padding(
//         padding: MediaQuery.of(context).viewInsets.copyWith(left: 8, right: 8),
//         child: Wrap(
//           children: <Widget>[
//             Container(
//               constraints: isEnableScroll
//                   ? BoxConstraints(maxHeight: maxContentSize)
//                   : null,
//               padding: EdgeInsets.only(
//                 bottom: bottomPadding ?? MediaQuery.of(context).padding.bottom,
//               ),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor,
//                 borderRadius: const BorderRadiusDirectional.only(
//                   topEnd: Radius.circular(8),
//                   topStart: Radius.circular(8),
//                 ),
//               ),
//               child: isEnableScroll
//                   ? Scaffold(
//                       backgroundColor: Colors.transparent,
//                       body: Center(
//                         child: SingleChildScrollView(child: content),
//                       ),
//                     )
//                   : content,
//             )
//           ],
//         ),
//       );
//     },
//   );
// }

// Future<void> showActionDialog(
//   BuildContext context, {
//   Map<String, void Function()> actions = const <String, void Function()>{},
//   String title = '',
//   String message = '',
//   bool useRootNavigator = true,
//   bool barrierDismissible = true,
//   bool dimissWhenSelect = true,
// }) {
//   final trans = translate(context);
//   if (kIsWeb || Platform.isAndroid) {
//     return showDialog(
//       context: context,
//       barrierDismissible: barrierDismissible,
//       useRootNavigator: useRootNavigator,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(
//             title,
//             style: Theme.of(context).textTheme.headlineSmall,
//           ),
//           content: Text(
//             message,
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//           actions: [
//             ...actions.entries
//                 .map<TextButton>(
//                   (e) => TextButton(
//                     onPressed: () {
//                       if (dimissWhenSelect) {
//                         Navigator.of(
//                           context,
//                           rootNavigator: useRootNavigator,
//                         ).pop();
//                       }
//                       e.value.call();
//                     },
//                     child: Text(e.key),
//                   ),
//                 )
//                 .toList(),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context, rootNavigator: useRootNavigator).pop();
//               },
//               child: Text('Hủy'),
//             ),
//           ],
//         );
//       },
//     );
//   } else {
//     return showModalBottomSheet<void>(
//       context: context,
//       useRootNavigator: useRootNavigator,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       isDismissible: barrierDismissible,
//       builder: (BuildContext context) {
//         final theme = Theme.of(context);
//         return CupertinoActionSheet(
//           actions: [
//             ...actions.entries.map(
//               (e) => CupertinoActionSheetAction(
//                 onPressed: () {
//                   if (dimissWhenSelect) {
//                     if (dimissWhenSelect) {
//                       Navigator.of(
//                         context,
//                         rootNavigator: useRootNavigator,
//                       ).pop();
//                     }
//                     e.value.call();
//                   }
//                 },
//                 child: Text(
//                   e.key,
//                   style: theme.textTheme.headlineSmall?.copyWith(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.normal,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             )
//           ],
//           title: Text(
//             title,
//             style: theme.textTheme.titleSmall,
//             textAlign: TextAlign.center,
//           ),
//           message: Text(
//             message,
//             style: theme.textTheme.titleMedium,
//             textAlign: TextAlign.center,
//           ),
//           cancelButton: CupertinoActionSheetAction(
//             onPressed: () {
//               Navigator.of(
//                 context,
//                 rootNavigator: useRootNavigator,
//               ).pop();
//             },
//             child: Text(
//               'Hủy',
//               style: theme.textTheme.headlineSmall?.copyWith(
//                 color: Colors.blue,
//                 fontWeight: FontWeight.normal,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// Future<dynamic> showNegativeSnackBar({
//   required BuildContext context,
//   required String message,
// }) {
//   final theme = Theme.of(context);
//   return showSnackBar(
//     context: context,
//     message: message,
//     backgroundColor: const Color(0xFFFADDD6),
//     messageStyle: theme.textTheme.bodyLarge?.copyWith(
//       fontWeight: FontWeight.bold,
//       color: Colors.red,
//     ),
//     icon: Container(
//       decoration: const BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.red,
//       ),
//       padding: const EdgeInsets.all(4),
//       child: const Icon(
//         Icons.warning_rounded,
//         size: 16,
//         color: Colors.white,
//       ),
//     ),
//   );
// }

// Future<dynamic> showPositiveSnackBar({
//   required BuildContext context,
//   required String message,
// }) {
//   final theme = Theme.of(context);
//   return showSnackBar(
//     context: context,
//     message: message,
//     messageStyle: theme.textTheme.bodyLarge?.copyWith(
//       fontWeight: FontWeight.bold,
//     ),
//     icon: Container(
//       decoration: const BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.green,
//       ),
//       padding: const EdgeInsets.all(4),
//       child: const Icon(
//         Icons.check,
//         size: 16,
//         color: Colors.white,
//       ),
//     ),
//   );
// }

// Future<dynamic> showSnackBar({
//   required BuildContext context,
//   required String message,
//   Color backgroundColor = const Color.fromARGB(255, 207, 239, 216),
//   TextStyle? messageStyle,
//   Widget? icon,
// }) {
//   final theme = Theme.of(context);
//   return Flushbar(
//     margin: const EdgeInsets.all(18),
//     backgroundColor: backgroundColor,
//     borderRadius: BorderRadius.circular(4),
//     flushbarPosition: FlushbarPosition.TOP,
//     flushbarStyle: FlushbarStyle.FLOATING,
//     animationDuration: const Duration(milliseconds: 200),
//     isDismissible: true,
//     icon: icon,
//     messageText: Text(
//       message,
//       style: messageStyle ??
//           theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.normal),
//     ),
//     duration: const Duration(seconds: 4),
//   ).show(context);
// }
