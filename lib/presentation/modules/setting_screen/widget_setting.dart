// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mobile_health_check/presentation/theme/theme_color.dart';

import '../../theme/app_text_theme.dart';

Widget settingMenuCell(String selectSetting, double height, double width) {
  return Container(
    margin: const EdgeInsets.only(top: 15, bottom: 15),
    decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            blurRadius: 15,
            color: Colors.black12,
          )
        ]),
    height: height,
    width: width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            width: 10,
          ),
          selectSetting == "Cập nhật mật khẩu"
              ? const Icon(
                  Icons.lock_outline_rounded,
                  size: 38,
                )
              : selectSetting == "Cập nhật số điện thoại"
                  ? const Icon(Icons.account_box_rounded, size: 38)
                  : const Icon(Icons.language, size: 38),
          const SizedBox(
            width: 10,
          ),
          Text(selectSetting, style: AppTextTheme.body1.copyWith()),
        ]),
        const Icon(Icons.arrow_forward_ios_rounded, size: 30),
      ],
    ),
  );
}

///
Widget settingPhoneCell(String? selectSetting, double height, double width) {
  String phone = "";
  final phoneController = TextEditingController();
  return Container(
    margin: const EdgeInsets.only(top: 15, bottom: 15),
    decoration: BoxDecoration(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(15),
    ),
    height: height,
    width: width,
    child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      const SizedBox(
        width: 20,
      ),
      SizedBox(
        height: height * 0.7,
        width: width * 0.8,
        child: TextField(
          textAlign: TextAlign.start,
          onChanged: (newphone) {
            phone = newphone;
          },
          cursorColor: AppColor.black,
          controller: phoneController,
          style: const TextStyle(fontSize: 20, color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: selectSetting,
            icon: const Icon(Icons.account_box_rounded, size: 38),
            labelStyle:
                const TextStyle(color: AppColor.gray767676, fontSize: 20),
          ),
        ),
      ),
      // Text(selectSetting, style: AppTextTheme.body1.copyWith()),
    ]),
  );
}

//

// ignore: must_be_immutable
class SettingPasswordCell extends StatefulWidget {
  final String? selectSetting;
  final double height;
  final double width;
  bool showPass;
  SettingPasswordCell(
      {Key? key,
      required this.selectSetting,
      required this.height,
      required this.width,
      required this.showPass})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingPasswordCellState createState() => _SettingPasswordCellState();
}

class _SettingPasswordCellState extends State<SettingPasswordCell> {
  String pass = "";
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 15,
            color: Colors.black12,
          )
        ],
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
      ),
      height: widget.height,
      width: widget.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              height: widget.height * 0.7,
              width: widget.width * 0.9,
              child: TextField(
                obscureText: widget.showPass,
                textAlign: TextAlign.start,
                onChanged: (newPass) {
                  pass = newPass;
                },
                cursorColor: AppColor.black,
                controller: passController,
                style: const TextStyle(fontSize: 20, color: Colors.black),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(widget.showPass
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        widget.showPass = !widget.showPass;
                      });
                    },
                  ),
                  border: InputBorder.none,
                  labelText: widget.selectSetting,
                  icon: const Icon(Icons.lock_outline_rounded, size: 38),
                  labelStyle:
                      const TextStyle(color: AppColor.gray767676, fontSize: 20),
                ),
              ),
            ),

            // Text(selectSetting, style: AppTextTheme.body1.copyWith()),
          ]),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable

